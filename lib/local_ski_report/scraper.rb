class LocalSkiReport::Scraper
  include Formattable
  ONTHESNOW_URL = 'https://www.onthesnow.com/united-states/skireport.html'.freeze
  ONTHESNOW_FILE_DIR = './public/onthesnow/'.freeze
  attr_reader :browser, :file_usa, :parsed_html

  def initialize
    @browser = Watir::Browser.new(
      :chrome, chromeOptions: { args: ['--headless', '--window-size=1200x600'] }
    )
    @file_usa = File.exist?(ONTHESNOW_FILE_DIR + 'resorts_in_usa.html') ? File.open(ONTHESNOW_FILE_DIR + 'resorts_in_usa.html') : nil
  end

  def scrape_usa_resorts
    html = if file_usa
             File.read(file_usa.path)
           else
             write_to_file(long_scrape.html, 'resorts_in_usa.html')
    end
    build_resorts(nokogirify(html))
  end

  def scrape_state_resorts(state_name)
    state_url = urlify(state_name)
    url = "https://www.onthesnow.com/#{state_url}/skireport.html"
  end

  def scrap_report_page(report)
    url = "http://www.onthesnow.com#{report.resort.url}"
    doc = get_page(url)
    report.get_xt_report_info(doc)
  end

  private
  def build_resorts(html)
    resorts_table = extract_table(html, '#resort-list-wrapper .resortList tbody')
    table_rows = resorts_table.css('tr')
    table_rows.each do |row|
      resort_hash = scrape_resort(row)
      # Possibly move this dependency out of the Scraper Class
      LocalSkiReport::Resort.new(resort_hash)
    end
  end

  def extract_data_cells_from_row(row, adjustment = 0)
    table_data_cells = row.css('td')
    table_data_cells.slice(0, table_data_cells.length - adjustment)
  end

  def extract_table(html, selector)
    html.css(selector)
  end

  def scrape_resort(row)
    resort_args = {}
    extract_data_cells_from_row(row, 2).each.with_index do |td, index|
      case index
      when 0
        resort_args[:name] = td.css('div.name a').text
        resort_args[:url] = td.css('div.name a').attr('href').value
        resort_args[:location] = td.css('div.rRegion').text.gsub(', USA', '')
        resort_args[:l_update] = td.css('div.lUpdate').text.split(' ').last
      when 1
        # Logic for if Resort is Open : Closed
      when 2
        hourly_snowfall = td.css('div b').text.tr('"', ' ').split(' ')
        resort_args[:snowfall] = {
          twenty_four: hourly_snowfall[0],
          seventy_two: hourly_snowfall[1]
        }
      when 3
        resort_args[:base_depth] = td.css('.link-light b').text.delete('"')
      when 4
        resort_args[:lifts] = td.css('div').text
      when 5
        resort_args[:open_acreage] = td.css('div').text
      end
    end # End of loop
    
    resort_args
  end

  def long_scrape
    browser.goto(ONTHESNOW_URL)
    browser.execute_script('window.scrollBy(0, 1450)')
    puts 'This may take up to a min to complete.'
    counter = 1
    24.times do
      browser.execute_script('window.scrollBy(0, 730)')
      sleep(2)
      LocalSkiReport::Output.loading(counter)
      counter += 1
    end
    browser
  end

  def nokogirify(html)
    Nokogiri::HTML(html)
  end

  def write_to_file(html, filename)
    file_usa = File.open(ONTHESNOW_FILE_DIR + filename, 'w') do |f|
      f.puts html
    end
  end
end
