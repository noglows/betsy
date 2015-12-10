# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
seed_categories = [
  { name: "stuffed animals" },
  { name: "stickers" },
  { name: "clothing" },
  { name: "slippers" },
  { name: "socks" },
  { name: "people"}
]

seed_categories.each do |seed|
  Category.create(seed)
end

seed_users = [
  { first_name: "Daphne", last_name: "Gold", email: "1@1.com" },
  { first_name: "Amy", last_name: "Hunter", email: "2@2.com" },
  { first_name: "Jessica", last_name: "Noglows", email: "3@3.com" },
  { first_name: "Lauren", last_name: "Granger", email: "4@4.com" },
  { first_name: "Mystery Person", last_name: "Mystery", email: "5@5.com" }
]

seed_users.each do |seed|
  user = User.create(seed)
  user.password = "1"
  user.save
end

seed_products = [
  {name: "Fuzzy Bunny", description: "A bunny that is fuzzy", price: 1000, inventory_total: 15, retired: false, image_url: "https://img1.etsystatic.com/016/0/5209660/il_fullxfull.418850207_s1jz.jpg", user_id: 1, :categories => Category.where(:name => ['stuffed animals'])},
  {name: "Fuzzy Wozniack", description: "A fuzzy computer guy", price: 5000, inventory_total: 1, retired: false, image_url: "http://rack.0.mshcdn.com/media/ZgkyMDEyLzEyLzA0LzVmL3N0ZXZld296bmlhLmMzUy5qcGcKcAl0aHVtYgkxMjAweDYyNyMKZQlqcGc/04902e3b/343/steve-wozniak-on-steve-jobs-videos--e2d1864990.jpg", user_id: 2, :categories => Category.where(:name => ['people'])},
  {name: "Fozzie Was-he", description: "A muppet that tells dad jokes", price: 3000, inventory_total: 5, retired: true, image_url: "http://vignette1.wikia.nocookie.net/muppet/images/b/be/Fozzie-pose-60percent.png/revision/latest?cb=20131219191526", user_id: 3, :categories => Category.where(:name => ['stuffed animals', 'stickers'])},
  {name: "Fonzie Was-he", description: "Eeeeyyyyyyy", price: 2000, inventory_total: 8, retired: false, image_url: "http://digilander.libero.it/happydays/foto_attori/fonzie/hdc1.jpg", user_id: 4, :categories => Category.where(:name => ['people', 'socks'])},
  {name: "Fuzzy Wah-Wah pedal", description: "Making some glorious vintage guitar sounds", price: 4000, inventory_total: 50, retired: false, image_url: "http://i.ebayimg.com/images/i/251806872987-0-1/s-l1000.jpg", user_id: 2, :categories => Category.where(:name => ['stuffed animals',  'slippers'])},
  {name: "Fun Size Whatchamacallit", description: "Caaaaaaaaandy", price: 500, inventory_total: 2000, retired: true, image_url: "http://ecx.images-amazon.com/images/I/41kHr2%2BU6XL._SL500_AA300_.jpg", user_id: 1, :categories => Category.where(:name => ['stuffed animals', 'clothing'])}
]

seed_products.each do |seed|
  Product.create(seed)
end

seed_reviews = [
  {rating: 3, review_text: "Adorable, but the jokes got real old real fast", product_id: 3 },
  {rating: 5, review_text: "He is too cool for school. Everyone loves the Fonz!", product_id: 4 },
  {rating: 1, review_text: "This made my guitar sound fuzzy, but the pedal itself wasn't fuzzy, which was a total bummer.", product_id: 5 },
  {rating: 2, review_text: "I liked the calls, but not the whats, the mas, or the its in this candy bar. Reeses are better", product_id: 6 },
  {rating: 4, review_text: "This bunny was really fuzzy. I would have liked just a little more fuzz. I'm picky.", product_id: 1 },
  {rating: 5, review_text: "Gotta love the Woz", product_id: 2 }
]

seed_reviews.each do |seed|
  Review.create(seed)
end

# seed_orders = [
#   { status: "pending", user_id: 1 },
#   { status: "complete", user_id: 2 },
#   { status: "cancelled", user_id: 3 },
#   { status: "paid", user_id: 4 },
#   { status: "pending", user_id: 5 },
#   { status: "pending", user_id: 5 }
# ]

seed_orders = [
  { status: "pending" },
  { status: "complete" },
  { status: "complete" },
  { status: "paid" },
  { status: "pending" },
  { status: "pending" }
]

seed_orders.each do |seed|
  Order.create(seed)
end

seed_order_items = [
  { quantity: 1, order_id: 3, product_id: 2 },
  { quantity: 12, order_id: 1, product_id: 6 },
  { quantity: 2, order_id: 2, product_id: 4 },
  { quantity: 4, order_id: 4, product_id: 5 },
  { quantity: 3, order_id: 5, product_id: 6 },
  { quantity: 2, order_id: 3, product_id: 2 },
  { quantity: 7, order_id: 1, product_id: 5 },
  { quantity: 2, order_id: 4, product_id: 1 },
  { quantity: 5, order_id: 6, product_id: 6 },
]

seed_order_items.each do |seed|
  OrderItem.create(seed)
end
