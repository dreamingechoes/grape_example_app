User.create!([
  {email: "example@email.com", encrypted_password: "$2a$10$cK.IBWQaabU9qKoN8Jr2Je71t3iZmUpZRj.Yb2NVbTt.GCc1eQLX6", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, name: "Example user"}
])
ApiKey.create!([
  {access_token: "18dfef7acf97765b54abecdf86a25bba", expires_at: "2043-03-12 21:03:46", user_id: 3, active: nil}
])
Product.create!([
  {name: "Product 1", description: "Description of product 1", image_url: "https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150", price: 10, stock: 1, user_id: nil},
  {name: "Product 2", description: "Description of product 2", image_url: "https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150", price: 20, stock: 2, user_id: nil},
  {name: "Product 3", description: "Description of product 3", image_url: "https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150", price: 30, stock: 3, user_id: nil},
  {name: "Product 4", description: "Description of product 4", image_url: "https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150", price: 40, stock: 4, user_id: nil},
  {name: "Product 5", description: "Description of product 5", image_url: "https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150", price: 50, stock: 5, user_id: nil}
])
Review.create!([
  {title: "Review 1", body: "Body of review 1", user_id: nil, product_id: 1},
  {title: "Review 2", body: "Body of review 2", user_id: nil, product_id: 2},
  {title: "Review 3", body: "Body of review 3", user_id: nil, product_id: 3},
  {title: "Review 4", body: "Body of review 4", user_id: nil, product_id: 4},
  {title: "Review 5", body: "Body of review 5", user_id: nil, product_id: 5}
])
