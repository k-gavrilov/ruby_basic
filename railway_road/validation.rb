module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(obj, val_type, *args)
      @required_validations ||= []
      @required_validations << {obj: "@#{obj}".to_sym, val_type: val_type, args: args}
    end

    def required_validations
      @required_validations
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue RuntimeError
      false
    end

    protected

    def validate!
      self.class.required_validations.each do |validation|
        obj_sym = validation[:obj]
        val_type = "validate_#{validation[:val_type]}".to_sym
        args = validation[:args]
        result =
          case val_type
          when :validate_presence then validate_presence(obj_sym)
          when :validate_format then validate_format(obj_sym, args[0])
          when :validate_type then validate_type(obj_sym, args[0])
          end
        raise ":#{obj_sym} #{val_type.to_s.capitalize} error" unless result
      end
      true
    end

    def validate_presence(obj_sym)
      true if instance_variable_get(obj_sym)
    end

    def validate_format(obj_sym, reg_exp)
      true if instance_variable_get(obj_sym) =~ reg_exp
    end

    def validate_type(obj_sym, class_name)
      true if instance_variable_get(obj_sym).is_a? class_name
    end
  end
end
