class CreateGistsTable < ActiveRecord::Migration
  def change
    create_table :gists do |t|
      t.timestamps
    end
  end
end
