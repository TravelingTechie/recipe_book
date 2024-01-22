# Create a main sample user.
User.create!(name:  "Example User",
             email: "example@worklifechaos.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
         
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@worklifechaos.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Generate microposts for a subset of users.
users = User.order(:created_at).take(8)

3.times do
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 5)
  category = "Main Dish"
  users.each { |user| user.recipes.create!(title: title,
                                          content: content, 
                                          category: category) }
end