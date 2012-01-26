# Generate a random string, useful for creating temporary passwords.
#
# source (1/25/2012): http://jaysonrowe.blogspot.com/2011/10/creating-random-string-in-ruby.html
module RandomString
  SPCHAR = %w[!@#$&_].shuffle[0..2]
  UPCHAR = ('A'..'Z').to_a.shuffle[0..4]
  CHAR =  ('a'..'z').to_a.shuffle[0..4]
  NUMCHAR = ('0'..'9').to_a.shuffle[0..4]

  def self.create(length=15)
    s = SPCHAR
    c = CHAR
    u = UPCHAR
    n = NUMCHAR
    @password =  s + c + n + u
    @password.sort_by { rand }.join[0..length]
  end
end