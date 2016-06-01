# require 'feature_test_helper'
require_relative '../feature_test_base'

class TodoFeatureTestBase < FeatureTestBase
  private

  def fill_out_form(**opts)
    fill_in 'todo_name', with: opts[:name]
    fill_in 'todo_description', with: opts[:description]

    check 'todo_completed' if opts[:completed]
  end
end
