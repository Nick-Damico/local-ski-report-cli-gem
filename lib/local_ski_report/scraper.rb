class LocalSkiReport::Scraper
  ONTHESNOW_URL = 'https://www.onthesnow.com/united-states/skireport.html'
  ONTHESNOW_FILE_DIR = './public/onthesnow/resorts_in_usa.html'
  attr_reader :browser, :file_usa

  def initialize
    @browser = Watir::Browser.new(
      :chrome, chromeOptions: { args: ['--headless', '--window-size=1200x600'] }
    )
    @file_usa = File.exist?(ONTHESNOW_FILE_DIR)
  end

  def create_resort_report(table)
    table.collect do |row|
      new_resort = LocalSkiReport::Resort.create(row)
      new_report = LocalSkiReport::Report.create(row)
      new_resort.add_report(new_report)
      new_resort
    end
  end

  def extract_table(html)
    table = html.css('table')
    table_rows = table.css('tr')
    table_rows.slice(2, table_rows.size - 3)
  end

  def scrape_usa_resorts
    html = long_scrape.html
    write_to_file(html)
    # table = get_table(html)
    # create_resort_report(table)
  end

  def scrape_state_resorts(state_url)
    url = "https://www.onthesnow.com/#{state_url}/skireport.html"
  end

  def scrap_report_page(report)
    url = "http://www.onthesnow.com#{report.resort.url}"
    doc = get_page(url)
    report.get_xt_report_info(doc)
  end

  private
    def long_scrape
      browser.goto(ONTHESNOW_URL)
      browser.execute_script('window.scrollBy(0, 1450)')
      32.times do
        browser.execute_script('window.scrollBy(0, 730)')
        sleep(3)
      end
      browser
    end

    def nokogirify(html)
      Nokogiri::HTML(html)
    end

    def write_to_file(html)
      file = File.open(ONTHESNOW_FILE_DIR, 'w') do |f|
        f.puts html
      end
    end
end
