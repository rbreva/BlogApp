require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  describe 'first page' do
    before(:example) do
      @user = User.create(name: 'Didier', photo: 'https://didierganthier-homepage.vercel.app/images/profile.jpg',
                          bio: 'Full-Stack Dev', post_counter: 0)
      visit users_path
    end

    it 'renders the list of users' do
      expect(page).to have_content(@user.name)
    end

    it "renders user's profile picture" do
      find("img[src='#{@user.photo}']")
    end

    it 'renders the number of posts for each user' do
      expect(page).to have_content(@user.post_counter)
    end

    it "redirects to the user's show page" do
      click_link @user.name
      expect(page).to have_current_path(user_path(@user))
    end
  end

  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Didier', photo: 'https://didierganthier-homepage.vercel.app/images/profile.jpg',
                          bio: 'Awesome dev.', post_counter: 0)
      @first_post = Post.create(author: @user, title: 'Hello World', text: 'End of the world', likes_counter: 0,
                                comments_counter: 0)
      @second_post = Post.create(author: @user, title: 'Hello Moon', text: 'To the moon', likes_counter: 0,
                                 comments_counter: 0)
      @third_post = Post.create(author: @user, title: 'Wassup Jupiter', text: 'This is the biggest planet',
                                likes_counter: 0, comments_counter: 0)
      visit user_path(@user)
    end

    it "renders user's profile picture" do
      find("img[src='#{@user.photo}']")
    end

    it "renders the user's username" do
      expect(page).to have_content(@user.name)
    end

    it "renders the user's post count" do
      expect(page).to have_content(@user.post_counter)
    end

    it "renders the user's bio" do
      expect(page).to have_content(@user.bio)
    end

    it "renders the user's last 3 posts" do
      expect(page).to have_content(@first_post.title)
      expect(page).to have_content(@second_post.title)
      expect(page).to have_content(@third_post.title)
    end

    it 'I can see a button that lets me view all of a users posts.' do
      visit user_path(@user.posts.first.author_id)
      expect(page).to have_content('See all Didier´s posts')
    end

    it 'When I click a users post, it redirects me to that posts show page.' do
      visit user_posts_path(@user)
      post_id = Post.last.id
      post_author = Post.last.author_id
      click_link @user.posts.last.text
      expect(page).to have_current_path(user_post_path(post_author, post_id))
    end

    it 'When I click to see all posts, it redirects me to the users posts index page.' do
      visit user_posts_path(@user)
      click_link 'Back to User'
      expect(page).to have_current_path(user_posts_path(@user.posts.first.author_id))
    end
  end
end
