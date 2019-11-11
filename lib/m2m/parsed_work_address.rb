module M2m::ParsedWorkAddress
  def parse_work_address
    if !@work_address_parsed
      @work_address_attention = nil
      @work_address_parts = self.work_address.split("\n").map(&:strip).select(&:present?)
      @work_address_parts.each_with_index do |txt, index|
        if txt =~ /^(att|attn|attention)[:\.](.+)/i
          @work_address_attention = $2.strip
          @work_address_parts.delete_at(index)
          break
        end
      end
      @work_address_parsed = true
    end
  end

  def work_address_attention
    self.parse_work_address
    @work_address_attention
  end

  def work_address_parts
    @work_address_parts
  end

  # For NS export
  def work_address_line(index1, index2=nil, default='')
    self.parse_work_address
    index2 ||= index1
    self.work_address_parts[index1..index2].try(:join, "\n")
  end
end