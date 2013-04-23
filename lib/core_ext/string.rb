class String
  def ru_downcase
    self.mb_chars.downcase.to_s
  end
end