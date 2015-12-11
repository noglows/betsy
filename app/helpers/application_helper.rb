module ApplicationHelper
  def readable_date(date)
   date.strftime("%B %u, %Y - %I:%M")
  end

  def cents_to_dollars(money)
    number_to_currency(money/100)
  end

  def cc_expiration(date)
    month = date[0..1]
    year = date[2..3]
    year = "20" + year
    if month[0] = "0"
      month = month[1]
    end
    month = month.to_i
    monthnames =
      {
        1 => "January",
        2 => "February",
        3 => "March",
        4 => "April",
        5 => "May",
        6 => "June",
        7 => "July",
        8 => "August",
        9 => "September",
        10 => "October",
        11 => "November",
        12 => "December"
      }

    month = monthnames[month]
    "#{month} #{year}"
  end




end
