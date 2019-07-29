class Notifier < ApplicationRecord
  require 'pusher'
  
  class << self
    def notifier()
      @notifier = Pusher::Client.new(
        app_id: '829218',
        key: 'a89b945f4dec90c0527f',
        secret: '82ffd98fd4600bd30ab3',
        cluster: 'us2',
        encrypted: true
      )
    end

    def trigger_FR(channel_name, obj)
      body = Rabl.render(obj, 'requests', :view_path => 'app/views/friends/', :format => :json)

      self.notifier.trigger(channel_name, 'FR', body)
    end

    def trigger_FC(channel_name, obj)
      body = Rabl.render(obj, 'requests', :view_path => 'app/views/friends/', :format => :json)

      self.notifier.trigger(channel_name, 'FC', body)
    end

    def trigger_chat(channel_name, obj)
      body = Rabl.render(obj, 'requests', :view_path => 'app/views/friends/', :format => :json)

      self.notifier.trigger(channel_name, 'chat', body)
    end

    def trigger_comment(channel_name, obj, event_id, event_type)
      comment = Rabl.render(obj, 'create', :view_path => 'app/views/comments/', :format => 'hash')
      comment = {obj.class.name.downcase => comment}
      
      post_state = Rabl.render(obj.post, 'index', :view_path => 'app/views/posts/', :format => 'hash')
      post_state = {obj.post.class.name.downcase => post_state}

      body = comment.merge(post_state)  
      body =  body.merge( {event_id: event_id, event_type: event_type} )

      self.notifier.trigger(channel_name, 'Comment', body )
    end
  end
end