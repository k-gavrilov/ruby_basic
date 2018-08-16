module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(obj, val_type, *args)
      @required_validations ||= []
      @required_validations << {obj: obj, val_type: val_type, args: args}
    end

    def required_validations
      @required_validations
    end

    def presence(parameters)
      instance = parameters[:instance]
      obj_sym = parameters[:obj]
      obj = instance.instance_variable_get("@#{obj_sym}".to_sym)
      true if obj
    end

    def format(parameters)
      instance = parameters[:instance]
      obj_sym = parameters[:obj]
      obj = instance.instance_variable_get("@#{obj_sym}".to_sym)
      reg_exp = parameters[:args][0]
      true if obj =~ reg_exp
    end

    def type(parameters)
      instance = parameters[:instance]
      obj_sym = parameters[:obj]
      obj = instance.instance_variable_get("@#{obj_sym}".to_sym)
      class_name = parameters[:args][0]
      true if obj.is_a? class_name
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
        val_type = validation[:val_type]
        validation[:instance] = self
        result = self.class.send(val_type, validation)
        raise ":#{obj_sym} #{val_type.to_s.capitalize} error" unless result
      end
      true
    end
  end
end
