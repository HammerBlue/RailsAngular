require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "to be sure that fixtures are working" do
    assert_equal users(:admin).LoginCount, 3686
    assert_equal users(:admin).individual.PreferredName, 'Alesa'
  end
end
