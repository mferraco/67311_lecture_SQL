class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :domain_id
      t.integer :manager_id

      t.timestamps
    end
    
    # still inside def change method, but not in create_table block
    execute <<-EOS
      CONSTRAINT projects_domain_id_fk FOREIGN KEY (domain_id)
      REFERENCES domains (domain_id) ON DELETE RESTRICT ON UPDATE CASCADE
    EOS
    
    execute <<-EOS
      CONSTRAINT projects_manager_id_fk FOREIGN KEY (manager_id)
      REFERENCES users (user_id) ON DELETE RESTRICT ON UPDATE CASCADE
    EOS
    
    execute <<-EOS
      CHECK (end_date > start_date);
    EOS
  end
end