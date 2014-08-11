module CreameryFormattingHelpers

  # Since reformatting phone is used by multiple models (instructor, family),
  # we can pull it out here and call it whenever needed
  def reformat_phone
    self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
  end

end