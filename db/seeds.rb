10.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    name: "テスト太郎#{n + 1}",
    password: "123456",
    image: File.open('./app/assets/images/test.jpg')
  )
end