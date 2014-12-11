class AddExternalAccountsTable < ActiveRecord::Migration
  def change
    create_table :external_accounts do |t|
      t.integer :user_id

      t.string :oodt_id
      t.boolean :oodt_baseline_survey_complete
      t.string :oodt_baseline_survey_url

      t.string :validic_id
      t.string :validic_access_token

      t.timestamps
    end

    remove_column :users, :validic_id, :string
    remove_column :users, :validic_access_token, :string
    remove_column :users, :oodt_id, :string
  end
end
