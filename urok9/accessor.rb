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
            puts value
            puts v_class

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

class A
    def initialize
       @var_name_h ||={}
       #@var_class ||=""
    end

    extend Accessor
 #   accessor_history :a, :b, :c

 strong_attr_acessor :d
    
end
