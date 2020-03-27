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
module Validation
    def validate(name, var)
        var = "@#{var}}".to_sym
        val = [:presence, :format, :type]
        define_method(name) do |var, key, value|
          if name == :presence
            if instance_variable_get(var_name) == nil ||  instance_variable_get(var_name) == ""
              puts "Параметр #{name} не должен быть nil или пустым значением"
              return false
              break
              else 
                puts "Не пустой"
                return true
            end
          end
          if name == :format
            if instance_variable_get(var_name) !~ value
              puts "Параметр #{name} не соответствует формату значения"
              return false
              break
            else 
              puts "Formak - Ok"
              return true
            end 
          end
          if name == :type
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

class A
    def initialize
      @var_name_h ||={}

    end
    extend Accessor
    extend Validation

    accessor_history :a, :b, :c

    strong_attr_acessor :d

    def validate!(name)
        err_p = ''
        err_f = ''
        err_t = ''

        #Проверка, что переменная не пуста
        if !self.class.validate(name, :presence)
            err_p = "Ошибка - переменная пуста. "
            err = false
        end
        #Проверка, что переменная соответствует формату
        if !self.class.validate(name,:format,/A-Z{0,3}/)
          err = false
          err_f = "Ошибка - переменная не соответствует формату. "
        end
        
        #Проверка, что переменная данного класса
        if !self.class.validate(name,:type,A)
          err = false
          err_t = "Ошибка - переменная не соответствует классу"
        end
        if err == false
          @err = err_p + err_f + err_t
          raise "#{@err}"
        else
            puts "Ok"
        end
          


        

    end


    
end
