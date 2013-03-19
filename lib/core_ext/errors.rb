module ActiveModel
  class Errors

    def error_names
      @_error_names ||= {}
    end

    def add_with_save_names(attribute, message = nil, options = {})
      message ||= :invalid
      if message.is_a? Proc
        message = message.call
      end
      error_names[attribute] ||= []
      error_names[attribute] << message
      add_without_save_names(attribute,message, options)
    end

    alias_method_chain :add, :save_names
  end
end
