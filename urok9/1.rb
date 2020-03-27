module Validation
    def validate(name, option = {})
        var_name = "@#{name}".to_sym
        option.each do |k, v|
            if k == :presence
                if instance_variable_get(var_name) == nil ||  instance_variable_get(var_name) == ""
                    puts "Параметр #{name} не должен быть nil или пустым значением"
                    break
                else 
                    puts "Не пустой"
                end
            end
            if k == :format
                if instance_variable_get(var_name) !~ value
                    puts "Параметр #{name} не соответствует формату значения"
                    break
                else
                    puts "Formak - Ok"
                end
            end
            if k == :type
                if eval('var_name.class') != value
                    puts "Параметр #{name} не соответствует классу значения"
                    break
                else
                    puts "Класс - Ok"
                end
            end
        end
    end
end
module Accessor
    def accessor_history(*names)
       names.each do |name|
            var_name = "@#{name}".to_sym
            define_method(name) do
                instance_variable_get(var_name)
            end
            define_method("#{name}=".to_sym) do |value|
                instance_variable_set(var_name, value)
                @var_name_h[name] ||=[]
                @var_name_h[name] << value
            end
            define_method("#{name}_history") do
                @var_name_h[name].inspect
            end
        end
    end

    def strong_attr_acessor(name)
        var_name = "@#{name}".to_sym
        define_method(name) do
            instance_variable_get(var_name)
        end
        
        define_method("#{name}_".to_sym) do |value, v_class|
            
             if eval('value.class') == v_class
                 instance_variable_set(var_name, value)
             else
                 raise "bad class vaiable"
             end
        end

        define_method("#{name}_history") do
            @var_name_h[name].inspect
        end
        
     end

end


class B

def t (n,opt={})
  name = "@#{n}".to_sym
  puts name
  opt
 # opt.each do |k,v|
  #puts "k - #{k};"
  #puts "v - #{v};"
  #end
end
end
