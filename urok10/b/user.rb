class User
  att_reader :name
  def initialize_copy
    name = gets.chomp
    enter_name(name)
    
  end
  def enter_name(name)
    @name = name
  end


end
