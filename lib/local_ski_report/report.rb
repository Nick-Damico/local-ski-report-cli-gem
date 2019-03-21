class LocalSkiReport::Report
    attr_accessor :date, :url, :status, :new_snow, :base, :lifts_open, :resort, :elevation, :trails, :tickets

    @@all = []

    def initialize(date, url, status, new_snow, base, lifts_open)
        @date = date
        @url = url
        @status = status
        @new_snow = new_snow
        @base = base
        @lifts_open = lifts_open
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
