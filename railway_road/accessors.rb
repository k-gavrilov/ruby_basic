module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        history_func_name = "#{name}_history".to_sym
        history_var_name = "@#{history_func_name}".to_sym
        define_method(history_func_name) do
          instance_variable_get(history_var_name)
        end
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          history = instance_variable_get(history_var_name)
          history ||= instance_variable_set(history_var_name, [instance_variable_get(var_name)])
          instance_variable_set(var_name, value)
          history << value
        end
      end
    end

    def strong_attr_accessor(name, class_name)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise TypeError, "Incorrect type, expected #{class_name}" unless value.is_a?(class_name)
        instance_variable_set(var_name, value)
      end
    end
  end
end
