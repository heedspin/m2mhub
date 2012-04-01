# == Schema Information
#
# Table name: ingrpc
#
#  fgc_number       :string(6)       default(""), not null
#  fgc_desc         :string(65)      default(""), not null
#  fpc_desc         :string(65)      default(""), not null
#  sc01             :decimal(7, 3)   default(0.0), not null
#  sc02             :decimal(7, 3)   default(0.0), not null
#  sc03             :decimal(7, 3)   default(0.0), not null
#  sc04             :decimal(7, 3)   default(0.0), not null
#  sc05             :decimal(7, 3)   default(0.0), not null
#  sc06             :decimal(7, 3)   default(0.0), not null
#  sc07             :decimal(7, 3)   default(0.0), not null
#  sc08             :decimal(7, 3)   default(0.0), not null
#  sc09             :decimal(7, 3)   default(0.0), not null
#  sc10             :decimal(7, 3)   default(0.0), not null
#  sc11             :decimal(7, 3)   default(0.0), not null
#  sc12             :decimal(7, 3)   default(0.0), not null
#  sc13             :decimal(7, 3)   default(0.0), not null
#  sc14             :decimal(7, 3)   default(0.0), not null
#  sc15             :decimal(7, 3)   default(0.0), not null
#  sc16             :decimal(7, 3)   default(0.0), not null
#  sc17             :decimal(7, 3)   default(0.0), not null
#  sc18             :decimal(7, 3)   default(0.0), not null
#  sc19             :decimal(7, 3)   default(0.0), not null
#  sc20             :decimal(7, 3)   default(0.0), not null
#  sc21             :decimal(7, 3)   default(0.0), not null
#  sc22             :decimal(7, 3)   default(0.0), not null
#  sc23             :decimal(7, 3)   default(0.0), not null
#  sc24             :decimal(7, 3)   default(0.0), not null
#  sc25             :decimal(7, 3)   default(0.0), not null
#  sc26             :decimal(7, 3)   default(0.0), not null
#  sc27             :decimal(7, 3)   default(0.0), not null
#  sc28             :decimal(7, 3)   default(0.0), not null
#  sc29             :decimal(7, 3)   default(0.0), not null
#  sc30             :decimal(7, 3)   default(0.0), not null
#  sc31             :decimal(7, 3)   default(0.0), not null
#  sc32             :decimal(7, 3)   default(0.0), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#

class M2m::ItemGroupCode < M2m::Base
  set_table_name 'ingrpc'
  scope :for_key, lambda { |key|
    {
      :conditions => { :fgc_number => key }
    }
  }
  def text
    @text ||= self.fgc_desc.titleize
  end
  def short_text
    @short_text ||= self.text.split(' ').first
  end
  
  @@cache = {}
  def self.cached_lookup(key)
    return nil unless key.present?
    @@cache[key] ||= M2m::ItemGroupCode.for_key(key).first  
  end
end
