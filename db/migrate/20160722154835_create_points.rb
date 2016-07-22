class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :name
      t.st_point :location, geographic: true, srid: 4326, null: false, default: 'POINT(0 0)'
    end
  end
end
