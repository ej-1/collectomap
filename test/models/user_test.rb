require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = User.new(id: 1, name: 'Erik', password: 'secret', password_confirmation: 'secret')
    @file ||= File.open(File.expand_path( '/Users/erikwjonsson/Desktop/Programming/collectomap/public/delicate-arch-night-stars-landscape.jpg', __FILE__))
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without password' do
    @user.password = nil
    @user.password_confirmation = nil
    refute @user.valid?, 'user is valid without a password'
    assert_not_nil @user.errors[:password], 'no validation error for name present'
  end

  test 'invalid without password confirmation' do
    @user.password_confirmation = '' # Lesson learned. If setting this value to nil it will not trigger validation.
    																 # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
    assert @user.invalid?, 'user is invalid without a password confirmation' # WAS IT CORRECT TO WRITE INVALID?
    assert_not_nil @user.errors[:password_confirmation], 'no validation error for name present'
  end

  test 'invalid without name' do
    @user.name = nil
    refute @user.valid?
    assert_not_nil @user.errors[:name]
  end

  test 'valid with valid image url' do
  	@user.remote_avatar_url = 'https://homepages.cae.wisc.edu/~ece533/images/cat.png'
    assert @user.valid?
  end

  test 'invalid with invalid image url' do
  	@user.remote_avatar_url = 'www.wronglink.com'
    refute @user.valid?
    assert_not_nil @user.errors[:remote_avatar_url]
  end

  test 'valid with valid image file' do
  	@user.avatar = @file
    assert @user.valid?
  end

  test 'invalid with invalid image file' do
    @user.avatar = '/public/delicate-arch-night-stars-landscape'
    refute @user.invalid?
    assert_not_nil @user.errors[:avatar]
  end

	test '#lists' do # Tests association between users and lists.
	  assert_equal 3, @user.lists.size # All lists including sublists.
	end

	test '#sublists' do
	  assert_equal 2, @user.sublists.size
	end

end
