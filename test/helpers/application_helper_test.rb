require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  class MockController
    attr_reader :action_name

    def initialize(**args)
      @action_name = args[:action_name]
    end
  end

  # #form_action tests
  def test_form_action_when_on_edit_page
    self.stub :controller, MockController.new(action_name: 'edit') do
      assert_equal(:patch, form_action)
    end
  end

  def test_form_action_when_not_on_edit_page
    self.stub :current_page?, MockController.new(action_name: 'index') do
      assert_equal(:post, form_action)
    end
  end
end
