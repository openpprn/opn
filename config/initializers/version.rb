module WwwMyapneaOrg
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 0
    TINY = 0
    BUILD = "rc" # nil, "pre", "beta1", "beta2", "rc", "rc2"

    STRING = [MAJOR, MINOR, TINY, BUILD].compact.join('.')
  end
end