# def test
#   raise "OPPSS...."
  

# end

# begin
#   test
#   rescue RuntimeError => e
#     puts "#{e.message}"

# end

# puts "After mesage"
class Person
    attr_accessor :account
  
    def initialize
      @name = 'Dima'
    end
    def first_name
      name
    end
  
    def check_account
      @account = Account.new
    end
end
  
  class Account
    attr_accessor :money
    def initialize
      @money = 100
    end
  end
