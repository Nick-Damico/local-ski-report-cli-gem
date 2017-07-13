class LocalSkiReport::Report
    attr_accessor :date, :url, :status, :new_snow, :base, :lifts_open, :resort, :elevation, :trails, :tickets
    
    @@all = []
    
    def initialize
        @@all << self
    end
    
    def self.all
        @@all
    end
    
    def self.clear
        @@all.clear
    end
    
    def self.create(html)
        report = self.new
        report.date = html.css('div.lUpdate').text
        report.url =  html.css('td')[3].css('a').first['href']
        report.status = report.get_status(html.css('td')[1].css('div').first['class'].split(" ").pop)
        report.new_snow = html.css('td')[2].css('b')[0].text
        report.base = html.css('td')[3].css('b')[0].text
        lift_open = html.css('td')[4].text.split("/").first
        lift_open == "" ? report.lifts_open = 0 : report.lifts_open = lift_open
       
        report
    end
    
    def get_ticket_prices(row)
        arr = row.css('td').text.gsub("US","").split
        [arr[1], arr[3]]
    end
    
    def get_status(state)
        case state
        when "stateD1"
            "Open"
        when "stateD2"
            "Closed"
        else
            "Weekends Only"
        end
    end
    
    def get_xt_report_info(html)
        table = html.css('table')
        rows = table.css('tr')
        self.elevation = rows[1].css('td').text.split(" - ")
        self.trails = rows[2].css('td').text.gsub("|","").split
        self.tickets = get_ticket_prices(rows[4])
    end

    def report(resort)
        rows = []
        rows << [resort.name, {:value => self.date, :alignment => :center}, self.status, {:value => self.new_snow, :alignment => :center},{:value => self.base, :alignment => :center}, {:value => "#{self.lifts_open}/#{resort.lifts}", :alignment => :right}]
        Terminal::Table.new :title => "Ski Report", :headings => ['Resort Name', 'Updated On', 'Status', 'New Snow', 'Base Depth', 'Lifts Open'], :rows => rows
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