# require 'test_helper'
# require 'minitest/rails/capybara'
require_relative './todo_feature_test_base'

class CreateNewTodoTest < TodoFeatureTestBase
  def test_entering_valid_data
    new_name = 'New name'
    visit new_todo_path

    assert_content(I18n.t('todos.new.heading'))

    fill_out_form(name: new_name)

    click_on(I18n.t('save'))

    assert_selector 'h1', text: new_name
    assert has_link? I18n.t('todos.show.edit')
    assert has_link? I18n.t('todos.show.back_to_list')
  end

  def test_entering_invalid_data
    new_name = nil
    description = 'some description'
    todo_hash = {name: new_name, description: description}

    visit new_todo_path

    assert_content(I18n.t('todos.new.heading'))

    fill_out_form(todo_hash)
    click_on(I18n.t('save'))

    # Verify we're showing the new page again
    assert_selector 'input#todo_name'
    assert_selector 'textarea#todo_description'

    new_name = 'Something else more valid'
    fill_out_form(todo_hash.merge(name: new_name))
    click_on(I18n.t('save'))

    assert_selector 'h1', text: new_name
    assert_content description
    assert has_link? I18n.t('todos.show.edit')
    assert has_link? I18n.t('todos.show.back_to_list')
  end
end
