class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.decimal :amount_paid
      t.datetime :payment_date
      t.references :loan

      t.timestamps
    end
  end
end
