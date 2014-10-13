module PagesHelper

  def random_name
    ["Brian", "Jessica", "Martha", "Max", "JT", "Sean", "Ryan", "Prisca", "Elizabeth"].sample
  end

  def random_place
    ["San Francisco, CA", "Raleigh, NC", "London, UK", "Mexico City, MX", "Seattle, WA", "New York City, NY", "Chicago, IL", "New Orleans, LA", "Austin, TX"].sample
  end

  def random_age
    rand(13..90)
  end

  def random_sex
    ["Male", "Female", ""].sample
  end

end

