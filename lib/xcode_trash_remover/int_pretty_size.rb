require 'filesize'

class Integer
  def pretty
    s = to_s + ' B'
    Filesize.from(s).pretty
  end
end
