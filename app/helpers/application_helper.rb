module ApplicationHelper
  def readable_date(date)
   date.strftime("%B %u, %Y - %I:%M")
  end
end
