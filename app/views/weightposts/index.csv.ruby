require 'csv'

CSV.generate do |csv|
  column_names = %w(Date Weight)
  csv << column_names
  @weights.each do |elem1, elem2|
    column_values = [
    I18n.l(elem1, format: :short),
    elem2
    ]
    csv << column_values
  end
end