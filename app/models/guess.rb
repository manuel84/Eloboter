class Guess
  API_URL = NSBundle.mainBundle.objectForInfoDictionaryKey('host')

  def self.all(&callback)
    BW::HTTP.get("#{Guess::API_URL}/api") do |response|
      if response.ok?
        callback.call BW::JSON.parse(response.body.to_str)
      else
        callback.call false
      end
    end
  end
end