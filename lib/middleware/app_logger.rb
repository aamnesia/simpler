require 'logger'

class AppLogger

  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    status, header, body = @app.call(env)
    @logger.info(message(env, status, header))

    [status, header, body]
 end

 def message(env, status, header)
   "\n" \
   "************************************************\n" \
   "Request: #{env['REQUEST_METHOD']} #{env['PATH_INFO']}\n" \
   "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}\n" \
   "Parameters: #{env['simpler.params']}\n" \
   "Response: #{status} [#{header['Content-Type']}] #{env['simpler.template_path']}\n" \
 end

end
