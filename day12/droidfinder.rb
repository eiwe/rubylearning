# We must seek out the droids
module DroidFinder
  class Search
    def initialize(app)
      @app = app
    end

    def call(env)
      case env['PATH_INFO']
        when "/"
          @app.call(env)
        when "/jawa"
          [200, {"Content-Type" => "text/plain"}, ["Success, you have found the droids!"]]
        else
          [404, {"Content-Type" => "text/plain"}, ["These are not the droids you're looking for."]]
      end
    end
  end
end
