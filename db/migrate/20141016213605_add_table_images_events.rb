class AddTableImagesEvents < ActiveRecord::Migration
  def up
  	 create_table(:event_images) do |t|
  	 	t.references :event, null:false
      t.has_attached_file :image
      t.timestamps
    end
  end

  def down
  	drop_table :event_images
  end
end
