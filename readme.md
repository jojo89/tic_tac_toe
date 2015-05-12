#instructions
1. run ```bundle install```
2. run ```ruby tic_tac_toe.rb```
3. run specs with ```bundle exec rspec```

##notes
  I decided to decouple the descision engine from the Game itself. I created the ```LayoutAnalyzer``` class for this.
  I thought it was a good idea to have the game use the analyzer to decide if the game was finished and to generate the best possible
  turn for the computer player. The method I'm using for finding whether the game is finished is passing the coordinates
  of the last turn passed to the analyzer. I thought this was better that iterating through all of the cells. This way I only need to
  check if the last cell to see if it creates a winning sequence. This saves a lot of processing time ecspecially if you
  have a particularly large board. This same speed concern is also my explanation for why the grid is keeping track of the count
  of it's filled squares. The other option would involve checking all the squares to see if there are any blanks. 
