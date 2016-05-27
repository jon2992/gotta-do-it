##
# Controller used to interact with Todo items.
class TodosController < ApplicationController

  ##
  # Index action for a list of todos
  def index
    @todos = Todo.all
  end

  ##
  # Show action for a single todo
  def show
    @todo = Todo.find(nav_params[:id])
  end

  ##
  # New action to display the form for a new todo
  def new
    @todo = Todo.new
  end

  ##
  # Edit action for editing an existing todo
  def edit
    @todo = Todo.find(nav_params[:id])
  end

  ##
  # Simple update action for updating a todo
  def update
    @todo = Todo.find(nav_params[:id])

    @todo.update(todo_params) ? redirect_to(@todo) : render(action: :edit)
  end

  ##
  # Create action that saves a new todo
  def create
    @todo = Todo.new(todo_params)

    @todo.save ? redirect_to(@todo) : render(action: :new)
  end

  private

  ##
  # Params for a todo. Requires the parent level :todo that then allows
  # the attributes of a todo
  def todo_params
    params.require(:todo).permit(:name, :description, :completed)
  end

  ##
  # Parameters from the URL used for navigation
  def nav_params
    params.permit(:id)
  end
end
