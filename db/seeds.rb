# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

creator = User.first
service_types = %w[Radiology Pharmacy Laboratory Surgery Mortuary Maternity Consultation Dental Ophthalmology Other\ Procedures]

(service_types || []).each do |type|
  service_type = ServiceType.where(name: type).first_or_initialize
  service_type.creator = creator.id
  service_type.save
end


CSV.foreach("#{Rails.root}/db/prices_seed.csv",{:headers=>:first_row, :col_sep => ","}) do |row|
  type = ServiceType.where(name: row[4]).first.id
  service = Service.create({name: row[0], unit: row[1], service_type_id: type, creator: creator.id})
  service_price = ServicePrice.create(service_id: service.id,price: row[2],price_type: row[3], creator: creator.id)
end