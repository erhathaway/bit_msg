def parse_encrypted(encrypted)
	encrypted = encrypted.to_s.gsub('\n', '').gsub('{"{','').gsub('}"}','').gsub('\"','')
	encrypted = encrypted.split(',')
	message = {}
	encrypted.each do |item|
		item = item.split(':')
		key = item[0]
		value = item[1]
		message[key]=value
	end

	#want 'iv' and 'ct'
	message
end