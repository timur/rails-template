# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
Employee.destroy_all
Person.destroy_all
1_000.times do |i|
  Employee.create(
    name: Faker::Name.name,
    position: ['Accountant', 'Accountant', 'Chief Executive Officer (CEO)', 'Chief Financial Officer (CFO)', 'Chief Marketing Officer (CMO)', 'Chief Operating Officer (COO)', 'Customer Support', 'Data Coordinator', 'Developer', 'Developer', 'Developer', 'Developer', 'Development Lead', 'Director', 'Financial Controller', 'Integration Specialist', 'Integration Specialist', 'Integration Specialist', 'Javascript Developer', 'Javascript Developer', 'Junior Javascript Developer', 'Junior Technical Author', 'Marketing Designer', 'Marketing Designer', 'Office Manager', 'Office Manager', 'Office Manager', 'Personnel Lead', 'Post-Sales support', 'Pre-Sales Support', 'Regional Director', 'Regional Director', 'Regional Director', 'Regional Director', 'Regional Director', 'Regional Marketing', 'Sales Assistant', 'Sales Assistant', 'Sales Assistant', 'Secretary', 'Senior Javascript Developer', 'Senior Marketing Designer', 'Software Engineer', 'Software Engineer', 'Software Engineer', 'Software Engineer', 'Software Engineer', 'Software Engineer', 'Support Engineer', 'Support Engineer', 'Support Engineer', 'Support Lead', 'System Architect', 'Systems Administrator', 'Systems Administrator', 'Team Leader', 'Technical Author'].sample,
    office: ["London", "Singapore", "Tokyo", "New York", "Edinburgh", "San Francisco"].sample,
    age: rand(20..100),
    start_date: rand(1..1000).days.ago.to_date,
  )
end

1_000.times do |i|
  Person.create(
    name: Faker::Name.name,
    position: ['Accountant', 'Accountant', 'Chief Executive Officer (CEO)', 'Chief Financial Officer (CFO)', 'Chief Marketing Officer (CMO)', 'Chief Operating Officer (COO)', 'Customer Support', 'Data Coordinator', 'Developer', 'Developer', 'Developer', 'Developer', 'Development Lead', 'Director', 'Financial Controller', 'Integration Specialist', 'Integration Specialist', 'Integration Specialist', 'Javascript Developer', 'Javascript Developer', 'Junior Javascript Developer', 'Junior Technical Author', 'Marketing Designer', 'Marketing Designer', 'Office Manager', 'Office Manager', 'Office Manager', 'Personnel Lead', 'Post-Sales support', 'Pre-Sales Support', 'Regional Director', 'Regional Director', 'Regional Director', 'Regional Director', 'Regional Director', 'Regional Marketing', 'Sales Assistant', 'Sales Assistant', 'Sales Assistant', 'Secretary', 'Senior Javascript Developer', 'Senior Marketing Designer', 'Software Engineer', 'Software Engineer', 'Software Engineer', 'Software Engineer', 'Software Engineer', 'Software Engineer', 'Support Engineer', 'Support Engineer', 'Support Engineer', 'Support Lead', 'System Architect', 'Systems Administrator', 'Systems Administrator', 'Team Leader', 'Technical Author'].sample,
    status: ["successfull", "warning", "danger"].sample,
    portfolio: [0, 20, 40, 60, 80, 100].sample,
    email: Faker::Internet.email,
    department: ["Accounting", "Business Development", "Engineering", "Human Resources", "Legal", "Marketing", "Product Management", "Research and Development", "Sales", "Services", "Support"].sample,
  )
end

Person.rebuild_search_index
