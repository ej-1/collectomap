require 'test_helper'

class ListItemTest < ActiveSupport::TestCase

  setup do
    @list_item = list_items(:one)
    @file ||= File.open(File.expand_path( '/Users/erikwjonsson/Desktop/Programming/collectomap/public/delicate-arch-night-stars-landscape.jpg', __FILE__))
  end

  test 'valid list item' do
    assert @list_item.valid?
  end

  test 'invalid without title' do
    @list_item.title = nil
    refute @list_item.valid?
    assert_not_nil @list_item.errors[:title]
  end

  test 'invalid without description' do
    @list_item.description = nil
    refute @list_item.valid?
    assert_not_nil @list_item.errors[:description]
  end

  test 'invalid without belonging to list' do
    @list_item.list_id = nil
    assert @list_item.invalid?
    #assert_not_nil @list_item.errors[:user_id]
  end

end
