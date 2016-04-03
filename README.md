# DomFor

Helper for creating HTML wrappers ActiveRecord objects

[![Gem Version](https://badge.fury.io/rb/dom_for.png)](http://badge.fury.io/rb/dom_for)
[![Build Status](https://travis-ci.org/mgrachev/dom_for.png?branch=master)](https://travis-ci.org/mgrachev/dom_for)
[![Coverage Status](https://coveralls.io/repos/mgrachev/dom_for/badge.png?branch=master)](https://coveralls.io/r/mgrachev/dom_for?branch=master)
[![Code Climate](https://codeclimate.com/github/mgrachev/dom_for.png)](https://codeclimate.com/github/mgrachev/dom_for)
[![Dependency Status](https://gemnasium.com/mgrachev/dom_for.svg)](https://gemnasium.com/mgrachev/dom_for)
[![Inline docs](http://inch-ci.org/github/mgrachev/dom_for.svg?branch=master)](http://inch-ci.org/github/mgrachev/dom_for)

## Installation

Add this line to your application's Gemfile:

    gem 'dom_for'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dom_for

## Usage

By default the helper `dom_for` creates tag `div`. But it can override, passing an additional argument `tag: :span`, for example:

```erb
<%# /app/views/users/index.html.erb %>
<%= dom_for User, class: 'customers', attribute_1: 'value_1', attribute_2: 'value_2', attribute_3: 'value_3' do %>
  <% @users.each do |user| %>
    <%= dom_for user, tag: :p, admin: user.admin, blocked: user.blocked do %>
      <%= content_tag(:span, user.name) %>
    <% end %>
  <% end %>
<% end %>
```

```html
<div id="users" class="users customers" data-action="index" data-attribute-1="value_1" data-attribute-2="value_2" data-attribute-3="value_3">
  <p id="user_1" class="user" data-admin="true" data-blocked="false" data-object-id="1">
    <span>Mikhail</span>
  </div>
  <p id="user_2" class="user" data-admin="false" data-blocked="false" data-object-id="2">
    <span>Yulia</span>
  </div>
</div>
```

The first argument can be used as a model ActiveRecord:

```erb
<%# /app/views/users/index.html.erb %>
<%= dom_for User do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div id="users" class="users" data-action="index">
  <span />
</div>
```

And record ActiveRecord:

```erb
<%# /app/views/users/show.html.erb %>
<%= dom_for @user do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div id="user_1" class="user" data-action="show" data-object-id="1" />
  <span />
</div>
```

The second argument passed to additional html-attributes (is optional):

```erb
<%# /app/views/users/index.html.erb %>
<%= dom_for User class: 'clients', attribute_1: 'value_1', attribute_2: 'value_2' do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div id="users" class="users clients" data-action="index" data-attribute-1="value_1" data-attribute-2="value_2">
  <span />
</div>
```

The third argument, the helper `dom_for`, takes a block of code that will be wrapped in the tag `<div>` (is optional):

```erb
<%# /app/views/users/index.html.erb %>
<%= dom_for User, tag: :span %>
```

```html
<span id="users" class="users" data-action="index" />
```

When defined instance variable with class name, the helper `dom_for` creates the additional html-attributes for this object:

```erb
<%# /app/views/users/show.html.erb %>
<% @user = User.last %>
<%= dom_for User do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div id="user_1" class="user" data-action="show" data-object-id="1" data-object="users">
  <span />
</div>
```

For each request, the helper `dom_for` creates additional attribute `data-action`, which will be equal to the method of the controller handling the request:

```erb
<%# /app/views/users/index.html.erb %>
<%= dom_for User do %>
  <%= tag(:span) %>
<% end %>
```

```html
<div id="users" class="users" data-action="index">
  <span />
</div>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
