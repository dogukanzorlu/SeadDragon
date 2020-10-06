require 'minitest/autorun'
require 'seaddragon'
require 'json'

class SeadDragonTest < Minitest::Test
  def test_first
    test_result = {"username" => "HIDDEN", "surname" => "HIDDEN"}
    assert = {"username" => "fake", "surname" => "faker"}
    assert_equal test_result,
                 SeadDragon.nested_hash_values(assert, "username,surname", "for_test_method")
  end
end