desc "Convert posts from rst to html"
task :regenerate_posts => :environment do
  Post.all.each do |post|
    post.save
  end
end
