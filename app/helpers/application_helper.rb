module ApplicationHelper
  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? APP_CONFIG['default_title'] + ' : ' + content_for(:title) : APP_CONFIG['default_title']
    end
  end
  
  def meta_keywords(tags = nil)
     if tags.present?
       content_for :meta_keywords, tags
     else
       content_for?(:meta_keywords) ? [content_for(:meta_keywords), APP_CONFIG['meta_keywords']].join(', ') : APP_CONFIG['meta_keywords']
     end
   end

   def meta_description(desc = nil)
     if desc.present?
       content_for :meta_description, desc
     else
       content_for?(:meta_description) ? content_for(:meta_description) : APP_CONFIG['meta_description']
     end
   end
   
   def fomat_time(t)
      t = '%04i' % t
      p DateTime.strptime(t, '%H%M').strftime('%l:%M %p')
   end
   
   def get_meeting_end_time(start_time, duration)
      e = start_time + duration
      fomat_time(e)
   end
end
