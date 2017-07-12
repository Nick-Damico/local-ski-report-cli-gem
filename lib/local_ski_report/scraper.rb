class LocalSkiReport::Scraper
    
    def self.get_page(url)
        html = open(url)
        Nokogiri::HTML(html)    
    end
    
    def self.get_table(html)
        table = html.css('table')
        table_rows = table.css('tr')
        table_rows.slice(2, table_rows.size - 3)
    end
    
    def self.scrap_resorts_page(state_url)
        url = "http://www.onthesnow.com/#{state_url}/skireport.html"
        doc = self.get_page(url)
        table = get_table(doc)
        self.create_resort_report(table)
    end
    
    def self.create_resort_report(table)
         table.collect do |resort|
            new_resort = LocalSkiReport::Resort.create(resort)
            new_report = LocalSkiReport::Report.create(resort)
            new_resort.add_report(new_report)
            new_resort
        end
    end
    
    def self.scrap_report_page(report, report_url)
        url = "http://www.onthesnow.com#{report_url}"
        doc = self.get_page(url)
        report.get_xt_report_info(doc)
    end
    
end