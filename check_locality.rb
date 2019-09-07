require 'awesome_print'
require 'json'
require 'csv'
require 'net/http'

cities = [
  { lat: 51.987198, lon: 47.244943 },
  { lat: 46.8499, lon: 40.5508 },
  { lat: 27.33326, lon: 68.3457 }
]

path = '/Users/pavel/Desktop/burger.csv'

# CSV.foreach(path) do |row|
#  ap row
# end

def get_info(lat, lon)
  Net::HTTP.get(URI("https://api.3geonames.org/#{lat},#{lon}.json"))
end

headers = %w[Id Name Name_From Latt Longt Timezone]
data = CSV.generate(headers: true) do |csv|
  csv << headers
  # cities.each do |city|
  CSV.foreach(path) do |row|
    res = get_info(row[7], row[8])
    json = JSON.parse(res)['major']
    # ap json['name']
    if row[0] == 'ID'

    elsif row[7] == json['latt'] && row[8] == json['longt']

    elsif row[7].nil? || row[8].nil?

    else
      csv << [row[0], row[2], json['name'], row[7], row[8], json['timezone']]
    end
  end
end

File.write("file.csv", data)
