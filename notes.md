## CLI GEM Project	Local-ski-report-cli-gem
=================================

1. Plan your gem, imagine your interface
2.  Start with the project structure - google
3. Start with the entry point - the file run
4. force that to build the CLI interface
5. stub out the interface
6. start making things real
7. discover objects
8. program


1. Plan your gem
- A command line interface for ski resort reports in your specified state.

```
User types ‘local-ski-report’
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
| # of Trails   | # Trails Open | Snow Fall  |
| ------------- |:-------------:| ----------:|
| 10            | 5             | $1600      |
  
```
“ Type:  “More” to view list of State Resorts again, “new” to search other states, or ‘quite’ to exit program: “
```