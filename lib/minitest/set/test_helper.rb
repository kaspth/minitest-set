module Minitest::Set::TestHelper
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_reader :minitest_sets

    def set(object, **attributes)
      (@minitest_sets ||= []) << Minitest::Set::Change.new(object, **attributes)
    end
  end

  def before_setup
    super
    @minitest_sets = self.class.minitest_sets&.dup
    @minitest_sets&.each(&:setup)
  end

  def before_teardown
    super
    @minitest_sets&.reverse_each(&:teardown)
  end

  def set(object, **attributes, &block)
    (@minitest_sets ||= []) << Minitest::Set::Change.new(object, **attributes).tap(&:setup)
    block&.call
  ensure
    @minitest_sets.pop.teardown if block
  end
end
