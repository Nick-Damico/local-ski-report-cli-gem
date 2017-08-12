# CLI GEM Project	Local-ski-report-cli-gem
=================================

1. Plan your gem, imagine your interface
2. Start with the project structure - google
3. Start with the entry point - the file run
4. force that to build the CLI interface
5. stub out the interface
6. start making things real
7. discover objects
8. program


## 1. Plan your gem
- A CLI for listing Ski Reports for Ski Areas and Resorts in US.


## 2 - 4 Proj. Structure, Create Entry Point from bin/ski_report, Start building CLI interface.

- Project setup using ```bundle gem local_ski_report``` 
- Setup Env file in ```config/environment.rb```
 
```
User types ‘local_ski_report’
```

“Select a state to see list of Resorts: “
1. Colorado
2. California
3. West Virginia 
4. Tennessee
5. North Carolina

```
user type : ‘4’
```

“Select one of the available Resorts to see most recent Ski Report: “
1. Ober Gatlinburg

### Tabular data layout will be done using ```ruby gem terminal-table```.

| Resort Name     | Last Updated | Status    | New Snow  | Base Depth | Lifts Open |
| --------------- | :----------: |:---------:| :--------:| :--------: | ---------: |
| Ober Gatlinburg | 2/23         | Closed    | 24 HR: 0" | N/A - N/A  | 0/4        |

```
“ Type:  “More” to view list of State Resorts again, “new” to search other states, or ‘quite’ to exit program: “
```

## 5. Stub out interface

## Currently building out a few methods inside LocalSkiReport::CLI 
    1. #list_regions = Gives user a list of regions with ski areas or resorts
    2. #list_states = Gives user a list of states within the selected regions
    3. Need #method to take user selected state and retrieve a list of ski areas and resorts from <http://www.onthesnow.com>, user will select ski area using a number and a final report will be displayed.
    4. #greeting = Welcomes user to Local Ski Report App.
    5. #exit_msg = Tells user goodbye once they choose to exit.
    6. #menu = The interface, asking the user to make choices for what data they want.
    
## 6. Start making things real
    
    Task 1: list_resorts method needs a way of giving the user a real list of ski areas to choose from, 
    this method will need to use the users choices from list_regions and list_states to get a
    real list of the Ski areas from www.onthesnow.com.
    
    Solution 1: Possibly construct a url from those choices and supply it to the scrapper.
    
    