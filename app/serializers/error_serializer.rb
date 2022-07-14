class ErrorSerializer
  def self.format_data_error
    { data: { error: 'error' } }
  end

  def self.data_error_response
    format_data_error[:data]
  end
end
