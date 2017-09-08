class MyRouteApp

  attr_reader :controller
  attr_accessor :http_path_info

  def initialize(controller)
    @controller = controller
  end

  def matches?(request)
    request.env['REQUEST_PATH'][/\/([^\.$]+)/]
    self.http_path_info = $1
    self.http_path_info.sub!(/\/$/, '')

    if url = WoodShop::FriendlyIdSlug.find_by( slug: self.http_path_info )
      return true if url.sluggable_type == controller
    end

    false
  end

end