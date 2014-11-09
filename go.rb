require 'pdf_forms'
require 'yaml'
# README : https://github.com/jkraemer/pdf-forms

# adjust the pdftk path to suit your pdftk installation
# add :data_format => 'XFdf' option to generate XFDF instead of FDF when
# filling a form (XFDF is supposed to have better support for non-western
# encodings)
# add :utf8_fields => true in order to get UTF8 encoded field metadata (this
# will use dump_data_fields_utf8 instead of dump_data_fields in the call to
# pdftk)
pdftk = PdfForms.new('/usr/local/bin/pdftk')

# find out the field names that are present in form.pdf
fields = pdftk.get_field_names '/data/development/pdf/b20.pdf'
puts "replacing these pdf fields: #{fields}"

users = YAML.load_file("users.yml")

users.each do |user|
  username = user[1]['username']
  password = user[1]['password']
  puts "#{username} -> #{password}"
  pdftk.fill_form '/data/development/pdf/b20.pdf', "output/b20-#{user[0]}.pdf", :username => username, :password => password
end

# optionally, add the :flatten option to prevent editing of a filled out form
# pdftk.fill_form '/path/to/form.pdf', 'myform.pdf', {:foo => 'bar'}, :flatten => true