class RequestStatsLogger
  def initialize app
    @app = app
  end

  def call env
    start_time = Time.now
    data = @app.call(env)
    end_time = Time.now
    difference_time = end_time - start_time
    Rails.logger.info "Request-Response time #{difference_time}"
    data
  end
end