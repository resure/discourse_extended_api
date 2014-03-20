
# Taken from Discourse (https://github.com/discourse/discourse)

require 'openssl'
require 'xor'

def hash_password(password, salt)

  iterations = ENV['PBKDF2_ITERATIONS'].to_i
  algorithm = ENV['PBKDF2_ALGORITHM'] 

  h = OpenSSL::Digest.new(algorithm)

  u = ret = OpenSSL::HMAC.digest(h, password, salt + [1].pack("N"))

  2.upto(iterations) do
   u = OpenSSL::HMAC.digest(h, password, u)
   ret.xor!(u)
  end

  ret.bytes.map{|b| ("0" + b.to_s(16))[-2..-1]}.join("")
end
