class LocalSkiReport::Scraper
    
    def self.get_page(url)
        html = open(url)
        Nokogiri::HTML(html)    
    end
   
    def self.scrap_resorts_page(state_url)
        url = "http://www.onthesnow.com/#{state_url}/skireport.html"
        doc = self.get_page(url)
        table = doc.css('table')
        table_rows = table.css('tr')
        tr_of_resorts = table_rows.slice(2, table_rows.size - 3)
        # rows is capturing an array of node_lists
        # each element is a <tr>
        # the first (2) rows are empty of info, and the last
        # are removed using .slice then the rest are iterated over below.
        
        tr_of_resorts.collect do |resort|
            # Build Resort Object
            new_resort = LocalSkiReport::Resort.new
            new_resort.name = resort.css('td div.name').text
            # Need to Check which url gives full report
            new_resort.url = resort.css('div.name a').first['href']
            new_resort.location = resort.css('td div.rRegion').text
            new_resort.lifts =  resort.css('td')[4].text.gsub("/","")
            
            # Build Report Object
            new_report = LocalSkiReport::Report.new
            new_report.date = resort.css('div.lUpdate').text
            new_report.url = resort.css('td')[3].css('a').first['href']
            status = resort.css('td')[1].css('div').first['class'].split(" ").pop
            if status == "stateD1"
                new_report.status = "Open"
            elsif status == "stateD2"
                new_report.status = "Closed"
            else
                new_report.status = "Weekends"
            end
            new_report.new_snow = resort.css('td')[2].css('b')[0].text
            new_report.base = resort.css('td')[3].css('b')[0].text
            new_report.lifts_open = resort.css('td')[4].text
            
            # Collaborate Resort Instance and Report
            # Resort 'has many' Reports
            # A Report 'belongs to a' Resort
            new_resort.reports << new_report
            new_report.resort = new_resort
            new_resort
        end
        
    end
    
    def self.scrap_report_page(report_url)
        doc = self.get_page(report_url)
    end
    
end