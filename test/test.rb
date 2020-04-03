require 'minitest/autorun'
require '9'
class TestPerson < Minitest::Test
def test_introduction
person = Person.new
person.name = 'Bob'
assert(person.introduction == 'Hello, my name is Bob!')
end
end
