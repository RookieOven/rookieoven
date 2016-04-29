module Jekyll
  class RelatedBlogPosts < Liquid::Tag
    def initialize(tag_name, params, tokens)
      super
      @amount = params.to_i
    end

    def normalize_tags(tags)
      tags.map do |tag|
        tag.downcase.gsub(' ', '')
      end
    end

    def render(context)
      post = context['page']
      post_tags = normalize_tags(post['tags'])

      other_posts = context['site']['posts'].select do |other_post|
        other_post['title'] != post['title']
      end

      sorted_posts = other_posts.sort do |other_post|
        other_tags = normalize_tags(other_post['tags'])
        (other_tags - post_tags).count
      end

      closest = sorted_posts[0..(@amount - 1)]
      html = '<ul>'
      closest.each do |related_post|
        html << '<li>'
        html << "<a href=http://rookieoven.com#{related_post['permalink']}>#{related_post['title']}</a>"
        html << "<p>#{related_post['excerpt']}</p>"
        html << '</li>'
      end
      html << '</ul>'
    end
  end
end

Liquid::Template.register_tag('related_posts', Jekyll::RelatedBlogPosts)
