namespace :dev do
  task fake_users: :environment do
    users = User.all
    users.each do |user|
      unless user.role = "admin" || user.name = "User"
        user.destroy
      end
    end
    
    20.times do
      user= User.create!(
        email: FFaker::Internet.email,
        password: "123456",
        name: FFaker::Name.last_name,
        intro: FFaker::Lorem.paragraph,
      )
    end
    puts "have created fake users"
    puts "now you have #{User.count} users date"
  end

  task fake_posts: :environment do
    Post.destroy_all
    CategoriesPost.destroy_all

    100.times do |i|
      Post.create!(
        title: FFaker::Lorem::phrase,
        content: FFaker::Lorem::sentence(100) ,
        remote_image_url: FFaker::Image::url,
        seem: "All",
        user_id: User.all.sample.id,
      )
      CategoriesPost.create!(
        category_id: Category.all.sample.id,
        post_id: Post.last.id
      )
    end
    puts "have created fake posts"
    puts "now you have #{Post.count} posts data"
  end

  task fake_friendships: :environment do
    Friendship.destroy_all
    puts "creating fake friendship..." 
    User.all.each do |u|
      @users = User.where.not(id: u.id).shuffle
      5.times do
        Friendship.create!(
          user_id: u.id,
          friend_id: @users.pop.id
        )
      end
    end
    puts "now you have #{Friendship.count} friendship"
  end

  task fake_collects: :environment do
    500.times do |i|
      Collect.create!(
        user_id: User.all.sample.id,
        post_id: Post.all.sample.id
        )
    end
    puts "have created fake collects"
    puts "now you have #{Collect.count} fake collects data"
  end

  task fake_comments: :environment do
    Comment.destroy_all
    200.times do |i|
      Comment.create!(
        content: FFaker::Lorem.sentence,
        post_id: Post.all.sample.id,
        user_id: User.all.sample.id
        )
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data"  
  end

  task rebuild: [
    "db:drop",
    "db:create",
    "db:migrate",
    "db:seed",
    :fake_users,
    :fake_posts,
    :fake_comments,
    :fake_friendships,
    :fake_collects
    ]

  task fake_all: [
    :fake_users,
    :fake_posts,
    :fake_comments,
    :fake_friendships,
    :fake_collects
    ] 

end