require 'active_support/core_ext/string'

class Hash

  def rubyify_keys!
    keys.each{|k|
      v = delete(k)
      new_key = k.to_s.underscore
      self[new_key] = v
      v.rubyify_keys! if v.is_a?(Hash)
      v.each{|p| p.rubyify_keys! if p.is_a?(Hash)} if v.is_a?(Array)
    }
    self
  end

end
