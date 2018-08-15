module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(obj, val_type, *args)
      case val_type
      when :presence
        send(:presence, obj)
      when :format
        send(:format, obj, args[0])
      when :type
        send(:type, obj, args[0])
      end
    end

    protected

    def presence(obj)
      true if obj
    end

    def format(obj, reg_exp)
      true if obj =~ reg_exp
    end

    def type(obj, class_name)
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
      required_validations.each do |validation|
        obj_sym = validation[:obj]
        obj = instance_variable_get("@#{obj_sym}".to_sym)
        val_type = validation[:val_type]
        args = validation[:args]
        unless self.class.validate(obj, val_type, args)
          raise ":#{obj_sym} #{val_type.to_s.capitalize} error"
        end
      end
      true
    end
  end
end
