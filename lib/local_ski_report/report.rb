class LocalSkiReport::Report
  attr_reader :base_depth, :l_update, :lifts, :location, :name, :snowfall_past_24, :snowfall_past_72, :open_acreage, :snowfall, :url

  @@all = []

  def initialize(resort)
    @base_depth = resort.base_depth
    @lifts = resort.lifts
    @l_update = resort.l_update || 'N/A'
    @open_acreage = resort.open_acreage
    @name = resort.name
    @snowfall_past_24 = resort.snowfall[:twenty_four] || '0'
    @snowfall_past_72 = resort.snowfall[:seventy_two] || '0'
    @url = resort.url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear
    @@all.clear
  end

  def report
    rows = []
    rows << [name, { value: l_update, alignment: :center }, { value: "#{@snowfall_past_24}\" - #{@snowfall_past_72}\"", alignment: :center }, { value: base_depth, alignment: :center }, { value: lifts, alignment: :right }]
    Terminal::Table.new title: 'Ski Report', headings: ['Resort Name', 'Updated On', 'New Snow', 'Base Depth', 'Lifts Open'], rows: rows
  end

  def get_xt_report_info(html)
    table = html.css('table')
    rows = table.css('tr')
    @elevation = rows[1].css('td').text.split(' - ')
    @trails = rows[2].css('td').text.delete('|').split
    @tickets = get_ticket_prices(rows[4])
  end

  def xt_report
    rows = []
    rows << ['ELEVATION', 'Base:', elevation[0].to_s, 'Summit:', elevation[1].to_s]
    rows << ['TRAILS', "Beginner: #{trails[0]}", "Intermediate: #{trails[1]}", "Advanced: #{trails[2]}", "Expert: #{trails[3]}"]
    rows << ['TICKET PRICES', 'Starting at:', tickets[0].to_s, { value: 'to', alignment: :center }, tickets[1].to_s]
    table = Terminal::Table.new title: "#{resort.name} Full Report", rows: rows
    table.style = { all_separators: true }
    table
  end
end
