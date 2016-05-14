class TodosController < ApplicationController

  def index
    @todos = Todo.all
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    todo = Todo.new(todo_params)
    todo.save

    redirect_to action: :index
  end

  private

  def todo_params
    params.permit(:name, :description)
  end

end
