use Rack::Static,
  :urls => ["/stylesheets", "/images"],
  :root => "about/public/"

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('about/public/index.html', File::RDONLY)
  ]
}
