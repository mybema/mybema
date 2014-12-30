module EmojiHelper
  def emojify(content)
    h(alias_content(content)).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{asset_path("emoji/#{emoji.image_filename}")}" class="emoji-img" width="20" height="20" />)
      else
        match
      end
    end.html_safe if content.present?
  end

  def alias_content content
    content.gsub!(":)", ':smile:')
    content.gsub!(";)", ':wink:')
    content.gsub!(":(", ':confused:')
    content.gsub!(":'(", ':cry:')
    content
  end
end