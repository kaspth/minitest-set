module Minitest
  module Set
    autoload :TestHelper, "minitest/set/test_helper"
    autoload :Change,     "minitest/set/change"
  end

  # minitest's plugin loading happens in `Minitest.autorun`'s `at_exit` hook,
  # so we'd have already crashed through any class-level `set` calls by that point.
  # Thus the eager include.
  Test.include Set::TestHelper
end
