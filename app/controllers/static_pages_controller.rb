class StaticPagesController < ApplicationController
  def about
    now = Time.now.utc.to_date
    dob = Date.new(1988, 4, 19)
    @age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def home
  end
end
