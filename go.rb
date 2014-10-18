require 'pdf_forms'
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

# take form.pdf, set the 'foo' field to 'bar' and save the document to myform.pdf

["rita", "sue", "bob", "too" ].each do |name|
    pdftk.fill_form '/data/development/pdf/b20.pdf', "output/b20-#{name}.pdf", :username => name, :password => 's3cr3t'
end

# optionally, add the :flatten option to prevent editing of a filled out form
# pdftk.fill_form '/path/to/form.pdf', 'myform.pdf', {:foo => 'bar'}, :flatten => true