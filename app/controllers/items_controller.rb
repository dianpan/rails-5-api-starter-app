class ItemsController < ApplicationController
  before_action :set_todo
  before_action :set_todo_item, only: [:show, :update, :destroy]

  def index
    @items = @todo.items
    render json: @items
  end

  def show
    render json: @item
  end

  def create
    @item = @todo.items.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def update
    @item.update(item_params)
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.require(:item).permit(:name, :done, :todo_id)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_item
    @item = @todo.items.find_by!(id: params[:id]) if @todo
  end
end
