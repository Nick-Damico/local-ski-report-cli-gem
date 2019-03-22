class LocalSkiReport::Report
    attr_accessor :base_depth, :lifts, :location, :name, :open_acreage, :snowfall, :url

    @@all = []

    def initialize(resort)
      @base_depth = resort.base_depth
      @lifts = resort.lifts
      @l_update = resort.l_update
      @open_acreage = resort.open_acreage
      @name = resort.name
      @snowfall = resort.snowfall
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
        rows << [self.resort.name, {:value => self.date, :alignment => :center}, self.status, {:value => self.new_snow, :alignment => :center},{:value => self.base, :alignment => :center}, {:value => "#{self.lifts_open}/#{resort.lifts}", :alignment => :right}]
        Terminal::Table.new :title => "Ski Report", :headings => ['Resort Name', 'Updated On', 'Status', 'New Snow', 'Base Depth', 'Lifts Open'], :rows => rows
    end

    def get_xt_report_info(html)
        table = html.css('table')
        rows = table.css('tr')
        @elevation = rows[1].css('td').text.split(" - ")
        @trails = rows[2].css('td').text.gsub("|","").split
        @tickets = get_ticket_prices(rows[4])
    end

    def xt_report
        rows = []
        rows << ['ELEVATION', "Base:", "#{elevation[0]}", "Summit:", "#{elevation[1]}"]
        rows << ["TRAILS", "Beginner: #{trails[0]}", "Intermediate: #{trails[1]}", "Advanced: #{trails[2]}", "Expert: #{trails[3]}"]
        rows << ["TICKET PRICES", "Starting at:", "#{tickets[0]}", {:value => "to", :alignment => :center}, "#{tickets[1]}"]
        table = Terminal::Table.new :title => "#{self.resort.name} Full Report", :rows => rows
        table.style = {:all_separators => true}
        table
    end
end
