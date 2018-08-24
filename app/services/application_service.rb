class ApplicationService
  extend Dry::Initializer

  def valid?
    validator.success?
  end

  def errors
    validator.messages
  end

  private

  def validator
    raise NotImplementedError, 'Please define validator method in Service Class'
  end
end