require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database 
  include singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Questions
  attr_accessor :id, :title, :body, :users_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @users_id = options['users_id']
  end

  def self.find_by_id
end

class Users
  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
end

class Questions_Follows
  attr_accessor :id, :questions_id, :users_id

  def initialize(options)
    @id = options['id']
    @questions_id = options['questions_id']
    @users_id = options['users_id']
  end
end

class Replies
  attr_accessor :id, :parent_reply_id, :title, :body, :questions_title, :questions_id, :users_id

  def initialize(options)
    @id = options['id']
    @parent_reply_id = options['parent_reply_id']
    @title = options['title']
    @body = options['body']
    @questions_title = options['questions_title']
    @questions_id = options['questions_id']
    @users_id = options['users_id']
  end
end

class Questions_Likes
  attr_accessor :questions_id, :likes, :users_id

  def initialize(options)
    @questions_id = options['questions_id']
    @likes = options['likes']
    @users_id = options['users_id']
  end
end

