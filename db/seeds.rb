CATEGORY_TREE = {
  "Electrónica" => [ "Celulares", "Computadoras" ],
  "Ropa" => [ "Ropa de Hombre", "Ropa de Mujer" ],
  "Hogar" => [ "Muebles", "Cocina" ]
}.freeze

subcategories = []

CATEGORY_TREE.each do |parent_name, children_names|
  parent = Category.find_or_create_by!(name: parent_name)

  children_names.each do |child_name|
    subcategories << Category.find_or_create_by!(name: child_name, parent: parent)
  end
end

puts "Categorías: #{Category.count} (#{CATEGORY_TREE.size} padre, #{subcategories.size} hijas)"

if Product.count.zero?
  Faker::Config.locale = "es-MX"

  20.times do |i|
    category = subcategories[i % subcategories.size]

    Product.create!(
      name: Faker::Commerce.unique.product_name,
      description: Faker::Lorem.paragraph(sentence_count: 3),
      price: rand(100.0..5000.0).round(2),
      stock: rand(0..50),
      category: category,
      published_at: rand(1..30).days.ago
    )
  end
end

puts "Productos: #{Product.count}"

admin = User.find_or_initialize_by(email: "admin@test.com")
admin.assign_attributes(password: "password123", role: "admin", confirmed_at: Time.current)
admin.save!

customer = User.find_or_initialize_by(email: "user@test.com")
customer.assign_attributes(password: "password123", role: "customer", confirmed_at: Time.current)
customer.save!

puts "Usuarios: #{User.count} (admin@test.com / user@test.com, password: password123)"
