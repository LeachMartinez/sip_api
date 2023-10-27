class AuthorizationError < StandardError
  attr_reader :exception_type

  def initialize(msg, exception_type)
    @exception_type = exception_type
    super(msg)
  end
end
