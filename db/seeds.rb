require 'random_data'

# Create Posts
50.times do
# #1
  Post.create!(
# #2
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
posts = Post.all

# Create Comments
# #3
100.times do
  Comment.create!(
# #4
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

# Create a Unique Post
puts "#{Post.count}"
Post.find_or_create_by(title: "This is Liane little post!", body: "A unique post that Liane created!")
puts "#{Post.count}"
# Create a Unique Comment
Comment.create_with(title: "Yo this is super dope!").find_or_create_by(body: "Hey, Liane, this comment is one of a kind!")


puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
