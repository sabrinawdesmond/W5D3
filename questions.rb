require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database 
  include Singleton

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

  def self.find_by_id(id)
    id = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE 
      id = ?
    SQL
    return nil unless id.length > 0
    Questions.new(id.first)
  end

  def create
    raise '#{self} already in database' if @id 
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @users_id)
    INSERT INTO 
      questions(title, body, users_id)
    VALUES
      (?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_users_id(users_id)
    users_id = QuestionsDatabase.instance.execute(<<-SQL, users_id)
    SELECT
      *
    FROM
      questions
    WHERE
      users_id = ?
    SQL
    return nil unless users_id.length > 0 
    users_id.map { |q| Questions.new(q) }
  end

  # def author(questions_id)
  #   SELECT
  #     fname, lname
  #   n.author
  # end
end

class Users
  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    id = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE 
      id = ?
    SQL
    return nil unless id.length > 0
    Users.new(id.first)
  end

  def self.find_by_name(fname, lname)
    name = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE 
      fname = ? AND lname = ?
    SQL
    return nil unless name.length > 0
    Users.new(name.first)
  end

  def authored_questions(user_id)
    user_id = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    return nil unless user_id.length > 0
    users_id.map { |u| Questions.new(u) }
  end

  def authored_replies(users_id)
    user_id = QuestionsDatabase.instance.execute(<<-SQL, Replies.find_by_users_id(users_id))
    SELECT
      *
    FROM
      replies
    WHERE
      users_id = ?
    SQL
    return nil unless users_id.length > 0
    users_id.map { |u| Replies.new(u) }
  end

  def create
    raise '#{self} already in database' if @id 
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
    INSERT INTO 
      users(fname, lname)
    VALUES
      (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end
end

class Questions_Follows
  attr_accessor :id, :questions_id, :users_id

  def initialize(options)
    @id = options['id']
    @questions_id = options['questions_id']
    @users_id = options['users_id']
  end

  def self.find_by_id(id)
    id = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions_follows
    WHERE 
      id = ?
    SQL
    return nil unless id.length > 0
    Questions_Follows.new(id.first)
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

  def self.find_by_id(id)
    id = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE 
      id = ?
    SQL
    return nil unless id.length > 0
    Replies.new(id.first)
  end

  def self.find_by_questions_id(questions_id)
    id = QuestionsDatabase.instance.execute(<<-SQL, questions_id)
    SELECT
      *
    FROM
      replies
    WHERE 
      questions_id = ?
    SQL
    return nil unless questions_id > 0
    Replies.new(questions_id.first)
  end

  def create
    raise '#{self} already in database' if @id 
    QuestionsDatabase.instance.execute(<<-SQL, @parent_reply_id, @title, @body, @questions_title, @questions_id, @users_id)
    INSERT INTO 
      replies(parent_reply_id, title, body, questions_title, questions_id, users_id)
    VALUES
      (?, ?, ?, ?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_users_id(users_id)
    users_id = QuestionsDatabase.instance.execute(<<-SQL, users_id)
     SELECT
      *
    FROM
      replies
    WHERE
      users_id = ?
    SQL
    return nil unless users_id.length > 0
    users_id.map { |r| Replies.new(r) }
  end

end

class Questions_Likes
  attr_accessor :questions_id, :likes, :users_id

  def initialize(options)
    @questions_id = options['questions_id']
    @likes = options['likes']
    @users_id = options['users_id']
  end

  def self.find_by_id(id)
    id = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions_likes
    WHERE 
      id = ?
    SQL
    return nil unless id.length > 0
    Questions_Likes.new(id.first)
  end
end

