require 'test_helper'

class ListTest < ActiveSupport::TestCase

  setup do # SETUP IS UN BEFORE EACH TEST. TEST ARE RUN INDEPENDATLY AND ARE RUN IN RANDOM ORDERS.
    @list = lists(:one)
    @file ||= File.open(File.expand_path( '/Users/erikwjonsson/Desktop/Programming/collectomap/public/delicate-arch-night-stars-landscape.jpg', __FILE__))
  end

  test 'valid list item' do
    assert @list.valid?
  end

  test 'invalid without title' do
    @list.title = nil
    refute @list.valid?
    assert_not_nil @list.errors[:title]
  end

  test 'invalid without description' do
    @list.description = nil
    refute @list.valid?
    assert_not_nil @list.errors[:description]
  end

  test 'invalid without belonging to user' do
    @list.user = nil
    assert @list.invalid?
  end

end
