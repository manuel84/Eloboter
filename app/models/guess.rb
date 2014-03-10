class Guess
  def self.all(&callback)
    BW::HTTP.get("#{NSBundle.mainBundle.objectForInfoDictionaryKey('host')}/api") do |response|
      if response.ok?
        callback.call BW::JSON.parse(response.body.to_str)
      else
        callback.call false
      end
    end
  end
end