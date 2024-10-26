class CreateAdjustments < ActiveRecord::Migration[6.1]
  def change
    create_table :adjustments do |t|
      t.decimal :amount
      t.decimal :interest_rate
      t.references :loan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
