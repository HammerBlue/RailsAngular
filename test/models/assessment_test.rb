require 'test_helper'

class AssessmentTest < ActiveSupport::TestCase

  test "to be sure that fixtures are working" do
    assert_equal assessments(:no_time_single_stage_single_questiongroup_tf).Name, 'No Time Single Stage Single Questiongroup TF'
  end

  test "to be sure that associations are working" do
  	assert_equal assessments(:no_time_single_stage_single_questiongroup_tf).stages.count, 1
  end

  test "to be sure that associations sort are working" do
  	assert_equal assessments(:no_time_double_stage).stages.count, 2
  	assert_equal assessments(:no_time_double_stage).stages.first, stages(:single_questiongroup_tf)
  	assert_equal assessments(:no_time_double_stage).stages.last, stages(:single_questiongroup_multiplechoice)
  end
end
