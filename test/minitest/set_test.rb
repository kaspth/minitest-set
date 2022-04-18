# frozen_string_literal: true

require "test_helper"

# Over-DRY to increase chances of future-me being hoist on past-me's pitard. Thus cursing at this very comment.
class Minitest::SetTest < Minitest::Test
  class Attribution
    singleton_class.attr_accessor :name, :greeting
  end

  private
    def assert_attributes_change(value)
      assert_equal value, Attribution.name
      assert_equal value, Attribution.greeting
    end
end

class Minitest::Set::MethodsTest < Minitest::SetTest
  set Attribution, name: :outer, greeting: :outer

  def test_class_level_set_changes_attributes
    assert_attributes_change :outer
  end

  def test_instance_level_set_changes_attributes_without_block
    set Attribution, name: :inner, greeting: :inner
    assert_attributes_change :inner
  end

  def test_instance_level_set_changes_attributes_with_block
    set Attribution, name: :inner, greeting: :inner do
      assert_attributes_change :inner
    end

    assert_attributes_change :outer
  end
end

class Minitest::Set::HooksTest < Minitest::SetTest
  set Attribution, name: :outer, greeting: :outer

  def setup
    # The class level `set` setup should've run here.
    super
    assert_attributes_change :outer
  end

  def teardown
    # The class level `set` teardown should've run here.
    super
    assert_nil Attribution.name
    assert_nil Attribution.greeting
  end
end
