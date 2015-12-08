# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
seed_products = [
  {name: "Fuzzy Bunny", description: "A bunny that is fuzzy", price: 1000, inventory_total: 15, retired: false, image_url: "https://img1.etsystatic.com/016/0/5209660/il_fullxfull.418850207_s1jz.jpg", user_id: 1},
  {name: "Fuzzy Wozniack", description: "A fuzzy computer guy", price: 5000, inventory_total: 1, retired: false, image_url: "http://rack.0.mshcdn.com/media/ZgkyMDEyLzEyLzA0LzVmL3N0ZXZld296bmlhLmMzUy5qcGcKcAl0aHVtYgkxMjAweDYyNyMKZQlqcGc/04902e3b/343/steve-wozniak-on-steve-jobs-videos--e2d1864990.jpg", user_id: 2},
  {name: "Fozzie Was-he", description: "A muppet that tells dad jokes", price: 3000, inventory_total: 5, retired: true, image_url: "http://vignette1.wikia.nocookie.net/muppet/images/b/be/Fozzie-pose-60percent.png/revision/latest?cb=20131219191526", user_id: 3},
  {name: "Fonzie Was-he", description: "Eeeeyyyyyyy", price: 2000, inventory_total: 8, retired: false, image_url: "http://digilander.libero.it/happydays/foto_attori/fonzie/hdc1.jpg", user_id: 4},
  {name: "Fuzzy Wah-Wah pedal", description: "Making some glorious vintage guitar sounds", price: 4000, inventory_total: 50, retired: false, image_url: "http://i.ebayimg.com/images/i/251806872987-0-1/s-l1000.jpg", user_id: 2},
  {name: "Fun Size Whatchamacallit", description: "Caaaaaaaaandy", price: 500, inventory_total: 2000, retired: true, image_url: "http://ecx.images-amazon.com/images/I/41kHr2%2BU6XL._SL500_AA300_.jpg", user_id: 1}
]

seed_products.each do |seed|
  Product.create(seed)
end

seed_reviews = [
  {rating: 3, review_text: "Adorable, but the jokes got real old real fast", product_id: 3, user_id: 4},
  {rating: 5, review_text: "He is too cool for school. Everyone loves the Fonz!", product_id: 4, user_id: 1},
  {rating: 1, review_text: "This made my guitar sound fuzzy, but the pedal itself wasn't fuzzy, which was a total bummer.", product_id: 5, user_id: 3},
  {rating: 2, review_text: "I liked the calls, but not the whats, the mas, or the its in this candy bar. Reeses are better", product_id: 6, user_id: 2},
  {rating: 4, review_text: "This bunny was really fuzzy. I would have liked just a little more fuzz. I'm picky.", product_id: 1, user_id: 1},
  {rating: 5, review_text: "Gotta love the Woz", product_id: 2, user_id: 5}
]

seed_reviews.each do |seed|
  Review.create(seed)
end
