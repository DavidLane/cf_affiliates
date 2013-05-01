ActiveAdmin.register Affiliate do
  
  # Filters
  filter :title
  filter :contact_email  
  filter :city
  filter :state
  filter :country
  
  # List
  index do
    column :id
    column :title
    column :city
    column :state
    column :country
    actions
  end
  
  # Form
  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :website
    end
    f.inputs "Map Data" do
      f.input :coords_lat
      f.input :coords_long
    end
    
    f.inputs "Contact Data" do
      f.input :contact_name
      f.input :contact_number
      f.input :contact_email
      f.input :address
      f.input :postcode
      f.input :city
      f.input :state
      f.input :region
      f.input :country      
    end
    
    #f.inputs "Certifications" do
    #  f.input :certifications, :as => :check_boxes
    #end
    
    f.inputs "Scrape Data" do
      f.input :original_scrape_data
    end
    
    f.actions    
  end  
end
