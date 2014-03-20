
class User
	include DataMapper::Resource

	property :id,							Serial
	property :username,				String
	property :admin,					Boolean
	property :moderator,			Boolean
	property :password_hash,	String
	property :salt,						String

	def to_json
		{
			id: self.id,
			username: self.username,
			admin: self.admin,
			moderator: self.moderator
		}.to_json
	end
end

DataMapper.setup(:default, ENV['DB_PATH'])
DataMapper.finalize
