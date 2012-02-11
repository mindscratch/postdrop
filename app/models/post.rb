class Post
  include Mongoid::Document
  field :content, :type => String
  field :created_at, :type => Time, default: -> { Time.now }
  field :posted_to, :type => Array
end
