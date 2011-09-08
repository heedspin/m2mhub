class ContentModule < ApplicationModel
  has_attached_file( :image, :whiny => false,
                     :styles => {:show => '200>', :index => '100>', :edit => '100>', :thumbnail => '100>' },
                     :storage => :s3,
                     :s3_credentials => "#{Rails.root}/config/s3.yml",
                     :url => ':s3_domain_url',
                     :path => ":class/:attachment/:id/:style/:basename.:extension",
                     :bucket => AppConfig.s3_bucket )
  has_attached_file( :attachment,
                     :storage => :s3,
                     :s3_credentials => "#{Rails.root}/config/s3.yml",
                     :url => ':s3_domain_url',
                     :path => ":class/:attachment/:id/:style/:basename.:extension",
                     :bucket => AppConfig.s3_bucket )
  
  validates_uniqueness_of :key
  
  # Convenience method.
  def self.make!(args)
    as_of = args[:as_of]
    if as_of
      as_of = Time.parse(as_of)
    end
    key = args[:key].to_s
    cm = ContentModule.find_by_key(key) || ContentModule.new(:key => key)
    if as_of.present? and (cm.updated_at > as_of)
      puts "Not updating #{cm.key} since it was last updated #{cm.updated_at}"
    else
      if cm.new_record?
        puts "Creating #{cm.key}"
      else
        puts "Updating #{cm.key}"
      end
      cm.has_title = !(args[:title] == false) && !(args[:has_title] == false)
      cm.has_content = !(args[:content] == false) && !(args[:has_content] == false)
      cm.has_image = args[:has_image] || false
      cm.has_attachment = args[:has_attachment] || false
      cm.title = (args[:title] || args[:description]) if cm.title.blank?
      cm.content = (args[:content] || '<p>Edit me!!!</p>') if cm.content.blank?
      cm.description = args[:description]
      cm.has_meta_title = args[:has_meta_title]
      cm.has_meta_title = true if cm.has_meta_title.nil?
      cm.has_meta_description = args[:has_meta_description]
      cm.has_meta_description = true if cm.has_meta_description.nil?
      unless cm.save
        raise "Failed to make! content module: " + cm.errors.full_messages.join(', ')
      end
    end
    cm
  end  
  
  def to_s
    if self.has_content
      self.content
    elsif self.has_title
      self.title
    else
      nil
    end
  end
  
  protected

  before_save :convert_key_to_string
  def convert_key_to_string
    if self.key.is_a?(Symbol)
      self.key = self.key.to_s
    end
  end
end

# == Schema Information
#
# Table name: content_modules
#
#  id                      :integer(4)      not null, primary key
#  key                     :string(255)
#  description             :string(255)
#  has_title               :boolean(1)
#  title                   :string(255)
#  has_content             :boolean(1)
#  content                 :text
#  image_file_name         :string(255)
#  image_content_type      :string(255)
#  image_file_size         :integer(4)
#  has_image               :boolean(1)
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer(4)
#  has_attachment          :boolean(1)
#  meta_description        :text
#  has_meta_description    :boolean(1)
#  creator_id              :integer(4)
#  updater_id              :integer(4)
#  created_at              :datetime
#  updated_at              :datetime
#  meta_title              :string(255)
#  has_meta_title          :boolean(1)
#

