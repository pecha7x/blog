class ApplicationService
  def initialize(hash = {}, **kwargs, &); end

  class << self
    def call(hash = {}, **kwargs, &)
      new(**hash.merge(kwargs), &).call
    end
  end

  def call; end
end
