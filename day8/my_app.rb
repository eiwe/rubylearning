# my_app.rb
#
# A simple rack app
#
class MyApp
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["This is an extremely complicated web application with a sophisticated back end that defies all explanation."]]
  end
end
