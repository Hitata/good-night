module Request
  module JsonHelper
    def body
      JSON.parse(subject.body, symbolize_names: true)
    end

    def data
      body[:data]
    end

    def error
      body[:error]
    end
  end

  module AuthenticationHelper
    def authenticate_with(token)
      headers = {'Content-Type': 'application/json'}
      headers.merge('Authorization': "Token #{token}")
    end
  end
end
