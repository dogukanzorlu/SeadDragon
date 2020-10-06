# frozen_string_literal: true

require 'openssl'
require 'json'

# Simple json fields encrypt and decrypt
module SeadDragon
  class SeadDragon

    def initialize(chiper_key, cipher_iv)
      @chiper_key = chiper_key
      @cipher_iv = cipher_iv
    end

    def nested_hash_values(obj, key, crypt_method)
      a = []
      arr = key.split(",")
      arr.map do |v|
        if obj.is_a?(Hash)
          obj[v] = send(crypt_method,obj[v]) if obj.key?(v)
          t = obj
          t.each_value { |e| nested_hash_values(e,v, crypt_method) }
          a << obj
        end
      end

      a.last
    end


    def encrypt(val)

      cipher = OpenSSL::Cipher::AES256.new(:CBC)
      cipher.encrypt
      cipher.key = @chiper_key
      cipher.iv = @cipher_iv

      encrypted = cipher.update(val) + cipher.final

      encrypted
    end

    def decrypt(val)

      decipher = OpenSSL::Cipher::AES256.new(:CBC)
      decipher.decrypt
      decipher.key = @chiper_key
      decipher.iv = @cipher_iv

      decrypted = decipher.update(val) + decipher.final

      decrypted
    end

    def for_test_method(val)
      "HIDDEN"
    end
  end
end

