class AddPhotoAsAttachmentToAccounts < ActiveRecord::Migration[5.0]
  def up
    remove_column :accounts, :photo
    add_attachment :accounts, :photo
  end
  def down
    remove_column :accounts, :photo
    add_column :accounts, :photo, :string
  end
end
