module PagesHelper

  def ccfa_pprn?
    @pprn == "ccfa"
  end

  def sapcon_pprn?
    @pprn == "sapcon"
  end

  def req?
    cookies[:req]
  end

end

