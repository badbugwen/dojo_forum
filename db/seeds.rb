#Category
Category.destroy_all

category_list =[
  { name: "Family" },
  { name: "Career" },
  { name: "Sport" },
  { name: "Interest" },
  { name: "Health" },
  { name: "Food" },
  { name: "News" }
]

category_list.each do |category|
  Category.create( name: category[:name] )
end

puts "Category created!"  

#Default admin
User.create(name: "Admin", email: "admin@example.com", password: "12345678", role: "admin")
User.create(name: "User", email: "user@test.com", password: "123456")
puts "Default admin and user created!"