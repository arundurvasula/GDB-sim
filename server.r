library(shiny)

shinyServer(function(input, output) {
  do_sim <- function (start.1, start.2, start.3, start.4)
  {
    new.infections <- 0
    total.infections <- 0
    number.jumps <- 0
    gen <- 0
    # create empty 25x25 matrix
    grid <- matrix(nrow=25, ncol=25)
    # put 1 at 4 starting positions
    grid[start.1[1], start.1[2]] = gen
    grid[start.2[1], start.2[2]] = gen
    grid[start.3[1], start.3[2]] = gen
    grid[start.4[1], start.4[2]] = gen
    
    # start loop
    while(length(which(is.na(grid), arr.ind=T)) != 0)
    {
      if(total.infections > 50){
        # how many jumps do we have?
        jumps <- floor(total.infections/50)
        # add each jump
        for(i in 1:jumps)
        {
          jump.row <- sample(1:25, 1)
          jump.col <- sample(1:25, 1)
          if(is.na(grid[jump.row, jump.col])) {
            grid[jump.row, jump.col] <- gen + 1
          }
        }
      }
      
      grid.na <- which(is.na(grid), arr.ind=T) # list of coordinates for NA values
      grid.gen <- which(grid==gen, arr.ind=T) # list of coordinates for current gen values
      for (j in 1:length(grid.gen[,1])) {
        grid.row <- grid.gen[j,][1] 
        grid.col <- grid.gen[j,][2]
        for (i in 1:length(grid.na[,1])) {
          na.row <- grid.na[i,][1]
          na.col <- grid.na[i,][2]
          if(  (grid.row+1 == na.row && grid.col == na.col) || # left
                 (grid.row-1 == na.row && grid.col == na.col) || # right
                 (grid.row == na.row && grid.col-1 == na.col) || # up
                 (grid.row == na.row && grid.col+1 == na.col) || # down
                 
                 (grid.row+1 == na.row && grid.col+1 == na.col) || # diagonal right down
                 (grid.row-1 == na.row && grid.col-1 == na.col) || # left up
                 (grid.row-1 == na.row && grid.col+1 == na.col) || # left down
                 (grid.row+1 == na.row && grid.col-1 == na.col)) { # right up
            
            grid[na.row, na.col] <- gen + 1
            new.infections = new.infections + 1
          }
        }
      }
      
      total.infections = new.infections + total.infections
      gen = gen + 1
    }
    print(total.infections)
    return(grid)
    
  }

  output$outbreakPlot <- renderPlot({
#    grid <- do_sim(c(12,12), c(12,13), c(13,12), c(13,13))
    start.1 <- eval(parse(text=input$start.1))
    start.2 <- eval(parse(text=input$start.2))
    start.3 <- eval(parse(text=input$start.3))
    start.4 <- eval(parse(text=input$start.4))
    grid <- do_sim(start.1, start.2, start.3, start.4)
    heatmap( grid, Rowv=NA, Colv=NA, col = heat.colors(256),  margins=c(1,1))
  })
})
