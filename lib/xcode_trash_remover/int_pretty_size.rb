require 'filesize'

class Integer
  def pretty
    s = self.to_s + ' B'
    Filesize.from(s).pretty
  end
end
