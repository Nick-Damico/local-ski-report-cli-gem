class LocalSkiReport::Scraper

    def self.get_page(url)
        html = open(url)
        puts "Loading data from #{url}..."
        sleep(5)
        Nokogiri::HTML(html)
    end

    def self.get_table(html)
        table = html.css('table')
        table_rows = table.css('tr')
        table_rows.slice(2, table_rows.size - 3)
    end

    def self.scrap_resorts_page(state_url)
        url = "https://www.onthesnow.com/#{state_url}/skireport.html"
        html = self.get_page(url)
        binding.pry
        table = get_table(html)
        self.create_resort_report(table)
    end

    def self.create_resort_report(table)
         table.collect do |row|
            new_resort = LocalSkiReport::Resort.create(row)
            new_report = LocalSkiReport::Report.create(row)
            new_resort.add_report(new_report)
            new_resort
        end
    end

    def self.scrap_report_page(report)
        url = "http://www.onthesnow.com#{report.resort.url}"
        doc = self.get_page(url)
        report.get_xt_report_info(doc)
    end

end
