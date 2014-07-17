require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  should have_many(:assignments)
end
