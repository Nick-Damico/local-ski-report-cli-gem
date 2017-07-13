# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
    LocalSkiReport::CLI.rb creates an instance of the CLI Class on start of the app
    User is presented with an ordered list of Regions and prompted to choose one,
    User is then presented with an ordered list of States with Skiing in that selected
    region.

    User is presented with a list of resorts and ski areas, once a resort is picked
    a table of data with information is displayed for the user.
    The user finally is given the option to select another region, get more information
    which displays a table of expanded info about the selected ski area and exit to 'quit' the app.
- [x] Pull data from an external source
    A list of Ski Areas | Resorts as well as data about the ski areas using a 
    scraper on www.onthesnow.com.
- [x] Implement both list and detail views
    The scraper presents to the user a list of regions, once the user selects
    a ski area a table data of information is displayed, and the user then has
    the option to go further into additional information about the area if needed.

