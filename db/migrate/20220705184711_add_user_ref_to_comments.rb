# frozen_string_literal: true

class AddUserRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comment, :user, null: false, foreign_key: true
  end
end
