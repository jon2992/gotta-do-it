require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  # Index tests
  def test_index_displays_all_todos
    get :index

    Todo.all.each do |s|
      assert_select('li h1', s.name)
      assert_select('li p', s.description)
    end

    assert_select('li p', text: I18n.t('todos.index.completed'), count: 1)
  end

  def test_index_with_no_todos
    Todo.delete_all

    get :index

    assert_select('.alert p', I18n.t('todos.index.no_todos_found'))
  end

  # Show tests
  def test_show_displays_todo
    get :show, id: Todo.first.id

    assert_select('h1', Todo.first.name)
  end

  def test_show_displays_completed_todo
    completed_todo = Todo.find_by(completed: true)

    get :show, id: completed_todo.id

    assert_select('h1.todo__completed', completed_todo.name)
    assert_select('p', completed_todo.description)
  end

  def test_show_displays_uncompleted_todo_without_completed_class
    incomplete_todo = Todo.find_by(completed: false)

    get :show, id: incomplete_todo.id

    assert_empty(css_select('h1.todo__completed'))
  end

  # Edit action tests
  def test_displays_correct_todo
    todo = todos(:two)

    get :edit, id: todo.id

    assert_select('.field__entry')
  end

  def test_displays_completed_field
    get :edit, id: Todo.first.id

    assert_select('input[type=checkbox].field__entry__checkbox')
  end

  # Update action tests
  def test_update_succeeds_redirects_to_show
    todo = todos(:one)

    patch :update, id: todo.id, todo: {completed: true}

    assert_equal(Todo.find(todo.id).completed, true)
    assert_redirected_to action: :show,
                         controller: :todos,
                         id: todo.id
  end

  private

  def form_content_assertions
    assert_select('label', count: 2) do |elements|
      assert_select elements.first.name, I18n.t('todos.form.name_label')
      assert_select elements[1].name, I18n.t('todos.form.description_label')
    end
  end
end
