class EnkiFormatter
  class << self
    def format_as_xhtml(text)
      if text[0..21] == ".. -*- mode: rst -*-\r\n"
        RbST.new(text).to_html(:strip_comments, :part => :fragment)
      else
        Lesstile.format_as_xhtml(
          text,
          :text_formatter => lambda {|text| RedCloth.new(CGI::unescapeHTML(text)).to_html},
          :code_formatter => Lesstile::CodeRayFormatter
        )
      end
    end
  end
end
