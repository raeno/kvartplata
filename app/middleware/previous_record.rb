module ClientSideValidations::Middleware
  class PreviousRecord < ClientSideValidations::Middleware::Base
    def response
      month = DateTime.now
      prev_value =  ::Metric.where('month < ?',month).last.send(request.params[:attr])
      a = request.params[:metric].to_f
      if a >= prev_value
        self.status = 200
      else
        self.status = 404
      end
      super
    end
  end
end