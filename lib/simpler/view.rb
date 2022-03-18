require 'erb'
require_relative 'view/plain'
require_relative 'view/html'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      render_template.result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template_path
      path = template || [controller.name, action].join('/')
      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

    def render_template
      template = @env['simpler.template']

      if template.is_a? Hash
        Plain.new(template) if template.has_key?(:plain)
      else
        Html.new(template_path)
      end
    end

  end
end
