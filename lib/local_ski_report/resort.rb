class   LocalSkiReport::Resort
    attr_accessor :name, :url, :status, :number_lifts
    
    def self.resorts
        # Scrapper will get this info from site.
       
        resort_1 = self.new
        resort_1.url = "http://www.onthesnow.com/north-carolina/appalachian-ski-mtn/ski-resort.html"
        resort_1.name = "Appalachian Ski Mountain"
        resort_1.report_update = "3/26"
        resort_1.status = "Closed"
        resort_1.new_snow = "24HR: 0\""
        resort_1.base = "N/A"
        resort_1.number_lifts = "5"
        resort_1.lifts_open = "0"
        
        resort_2 = self.new
        resort_2.url = "http://www.onthesnow.com/north-carolina/cataloochee-ski-area/ski-resort.html"
        resort_2.name = "Cataloochee Ski Area"
        resort_2.report_update = "6/15"
        resort_2.status = "Closed"
        resort_2.new_snow = "24HR: 0\""
        resort_2.base = "N/A"
        resort_2.number_lifts = "5"
        resort_2.lifts_open = "0"
        [resort_1, resort_2]
    end
    
# | Resort Name     | Last Updated | Status    | New Snow  | Base Depth | Lifts Open |
# | --------------- | :----------: |:---------:| :--------:| :--------: | ---------: |
# | Ober Gatlinburg | 2/23         | Closed    | 24 HR: 0" | N/A - N/A  | 0/4        |
    
end