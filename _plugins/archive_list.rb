# Archives
module Jekyll
  class ArchiveListTag < Liquid::Tag
    def render(context)
      html = ""
      posts = context.registers[:site].posts
      cur_date = posts[0].date
      count = 0
      dates = Array.new
      posts.each do |post|
        if post.date.year == cur_date.year and post.date.month == cur_date.month
            count += 1
        else
            dates << [cur_date, count]
            cur_date = post.date
            count = 0
        end
      end
      dates << [cur_date, count]
      dates.each do |d|
        html << "<li><a href='/#{d[0].strftime("%Y/%_m")}/'>#{d[0].strftime("%b %Y")} (#{d[1]})</a></li>\n"
      end
      html
    end
  end
end

Liquid::Template.register_tag('archive_list', Jekyll::ArchiveListTag)
