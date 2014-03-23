# DomFor

Helper for creating HTML wrappers ActiveRecord objects

[![Build Status](https://travis-ci.org/mgrachev/dom_for.png?branch=master)](https://travis-ci.org/mgrachev/dom_for)
[![Coverage Status](https://coveralls.io/repos/mgrachev/dom_for/badge.png?branch=master)](https://coveralls.io/r/mgrachev/dom_for?branch=master)
[![Dependency Status](https://gemnasium.com/mgrachev/dom_for.svg)](https://gemnasium.com/mgrachev/dom_for)

## Installation

Add this line to your application's Gemfile:

    gem 'dom_for'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dom_for

## Usage

```erb
<%= dom_for User, attribute_1: 'value_1', attribute_2: 'value_2', attribute_3: 'value_3' do %>
  <% @users.each do |user| %>
    <%= dom_for user, admin: user.admin, blocked: user.blocked do %>
      <%= content_tag(:span, user.name) %>
    <% end %>
  <% end %>
<% end %>
```

```html
<div class="users" data-action="index" data-attribute-1="value_1" data-attribute-2="value_2" data-attribute-3="value_3" id="users">
  <div class="user" data-admin="true" data-blocked="false" data-object-id="1" id="user_1">
    <span>Mikhail</span>
  </div>
  <div class="user" data-admin="false" data-blocked="false" data-object-id="2" id="user_2">
    <span>Yulia</span>
  </div>
</div>
```

The first argument can be used as a model ActiveRecord:

```erb
<%= dom_for User do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div class="users" data-action="index" id="users" />
  <span />
</div>
```

And record ActiveRecord:

```erb
<%= dom_for @user do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div class="user" data-action="show" data-object-id="1" id="user_1" />
  <span />
</div>
```

The second argument passed to additional html-attributes (is optional):

```erb
<%= dom_for User, attribute_1: 'value_1', attribute_1: 'value_2' do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div class="users" data-action="index" data-attribute-1="value_1" data-attribute-2="value_2" id="users" />
  <span />
</div>
```

The third argument, the helper `dom_for`, takes a block of code that will be wrapped in the tag `<div>` (is optional):

```erb
<%= dom_for User %>
```

```html
<div class="users" data-action="index" id="users" />
```

When defined instance variable with class name, the helper `dom_for` creates the additional html-attributes for this object:

```erb
<% @user = User.last %>
<%= dom_for User do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div class="user" data-action="show" data-object-id="1" data-object="users" id="user_1" >
  <span />
</div>
```

For each request, the helper `dom_for` creates additional attribute `data-action`, which will be equal to the method of the controller handling the request:

```erb
<%= dom_for User do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div class="users" data-action="index" id="users">
  <span />
</div>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request