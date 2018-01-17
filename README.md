# WoodShop
Engine without best practices.

## Usage
How to use my plugin - NOHOW !

#### Index


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'wood_shop'
```

And then execute:
```bash
$ bundle
$ rails db:migrate
```
Add routes helpers
```ruby
module ApplicationHelper
  include WoodShop::Engine.routes.url_helpers
end
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
