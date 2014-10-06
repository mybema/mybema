class IdenticonWorker
  include Sidekiq::Worker

  def perform klass, object_id
    object = klass.constantize.find(object_id)
    IdenticonCreator.new(object).process
  end
end