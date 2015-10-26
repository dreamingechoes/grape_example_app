class AddModelsRelations < ActiveRecord::Migration
  def change
    add_reference :products, :user, index: true
    add_reference :reviews, :user, index: true
    add_reference :reviews, :product, index: true
  end
end
