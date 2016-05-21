class TodosController < ApplicationController

  def index
    @todos = Todo.all
  end

  def show
    @todo = Todo.find(nav_params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    @todo.save ? redirect_to(@todo) : render(action: :new)
  end

  private

  def todo_params
    params.require(:todo).permit(:name, :description)
  end

  def nav_params
    params.permit(:id)
  end
end
