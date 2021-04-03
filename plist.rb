require 'nokogiri'

devp = File.open('device.plist')
doc = Nokogiri::XML(devp)
xml_node = doc.xpath('//string')[2].to_s
device_name = xml_node.gsub('<string>', '').gsub('</string>', '')
puts device_name

