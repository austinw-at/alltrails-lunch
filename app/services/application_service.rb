class ApplicationService
  def call(*arguments)
    new(*arguments).call
  end
end
