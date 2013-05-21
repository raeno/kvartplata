class BigDecimal

  def in_delta_with(other)
    (other - self).abs < 0.001
  end
end