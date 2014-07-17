module PagesHelper

  def ccfa_pprn?
    @pprn_code == "ccfa"
  end

  def sapcon_pprn?
    @pprn_code == "sapcon"
  end

  def req?
    cookies[:req] || false
  end

  def random_name
    ["Brian", "Jessica", "Martha", "Max", "JT", "Sean", "Ryan", "Prisca", "Elizabeth"].shuffle.first
  end

  def random_place
    ["San Francisco, CA", "Raleigh, NC", "London, UK", "Mexico City, MX", "Seattle, WA", "New York City, NY", "Chicago, IL", "New Orleans, LA", "Austin, TX"].shuffle.first
  end

  def random_age
    rand(13..90)
  end

  def random_sex
    ["Male", "Female", ""].shuffle.first
  end

end

