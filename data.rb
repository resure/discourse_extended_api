
class User
  include DataMapper::Resource

  has n, :group_users
  has n, :groups, through: :group_users

  property :id,             Serial
  property :username,       String
  property :admin,          Boolean
  property :moderator,      Boolean
  property :password_hash,  String
  property :salt,           String

  def to_json
    {
      id: self.id,
      username: self.username,
      admin: self.admin,
      moderator: self.moderator,
      groups: self.groups.map { |g| g.name }
    }.to_json
  end
end

class GroupUser
  include DataMapper::Resource

  property :id,       Serial
  property :group_id, Integer
  property :user_id,  Integer

  belongs_to :group,  key: true
  belongs_to :user,   key: true
end

class Group
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

  has n, :users, through: :group_users
end


DataMapper.setup(:default, ENV['DB_PATH'])
DataMapper.finalize
