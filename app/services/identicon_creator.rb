class IdenticonCreator
  def initialize(object)
    @guest_id = object.guest_id
  end

  def process
    return true if Rails.env.test?

    create_identicon
    upload_identicon
    remove_temp_identicon
  end

  private

  def create_identicon
    Identicon.file_for(@guest_id, "tmp/#{@guest_id}.jpg", 70)
    @file = File.open("tmp/#{@guest_id}.jpg")
  end

  def upload_identicon
    ASSET_BUCKET.objects["identicons/#{@guest_id}-pic.jpg"].write(file: @file, acl: :public_read)
  end

  def remove_temp_identicon
    File.delete("tmp/#{@guest_id}.jpg")
  end
end