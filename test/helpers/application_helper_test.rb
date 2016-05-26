require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  # #form_action tests
  def test_form_action_when_on_edit_page
    self.stub :current_page?, true do
      assert_equal(:patch, form_action)
    end
  end

  def test_form_action_when_not_on_edit_page
    self.stub :current_page?, false do
      assert_equal(:post, form_action)
    end
  end
end
