require 'test_helper'

class IndividualTest < ActiveSupport::TestCase

  test "to be sure that fixtures are working" do
    assert_equal individuals(:admin).PreferredName, 'Alesa'
  end

  test "that user->individual association is working" do
    assert_equal individuals(:admin).user.LoginCount, 3686
  end
end
