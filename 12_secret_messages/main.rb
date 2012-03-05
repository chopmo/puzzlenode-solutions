require 'ciphers/caesar'

cipher = Ciphers::Caesar.new(1)

encrypted = cipher.encrypt("HEJ MED DIG. DET GAAR FINT.")
puts encrypted
puts cipher.decrypt(encrypted)
