


//DONE:

// Finds full rows and clears them
// Checks for collisions with old pieces on screen
// Checks for collisions with the bottom of the screen



//TODO:

// Rotates Piece left
// Rotates Piece right
// Responds to keyboard input
// Determines game is over



var gameScreen: [[Int]] = [[0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0],
                           [1,1,1,1,0,0,1,1,1,1]]

let l = [[0,1,0,0,0,0],
         [0,1,0,0,0,0],
         [0,1,1,0,0,0],
         [0,0,0,0,0,0],
         [0,0,0,0,0,0],
         [0,0,0,0,0,0]]

let l2 = [[0,0,1,0,0,0],
          [0,0,1,0,0,0],
          [0,1,1,0,0,0],
          [0,0,0,0,0,0],
          [0,0,0,0,0,0],
          [0,0,0,0,0,0]]

let i = [[0,1,0,0,0],
         [0,1,0,0,0],
         [0,1,0,0,0],
         [0,1,0,0,0],
         [0,0,0,0,0],
         [0,0,0,0,0]]

let t = [[0,0,0,0,0,0],
         [0,1,1,1,0,0],
         [0,0,1,0,0,0],
         [0,0,0,0,0,0],
         [0,0,0,0,0,0],
         [0,0,0,0,0,0]]

let s = [[0,1,0,0,0,0],
         [0,1,1,0,0,0],
         [0,0,1,0,0,0],
         [0,0,0,0,0,0],
         [0,0,0,0,0,0],
         [0,0,0,0,0,0]]

let z = [[0,0,1,0,0],
         [0,1,1,0,0],
         [0,1,0,0,0],
         [0,0,0,0,0],
         [0,0,0,0,0],
         [0,0,0,0,0]]

let o = [[0,1,1,0,0,0],
         [0,1,1,0,0,0],
         [0,0,0,0,0,0],
         [0,0,0,0,0,0],
         [0,0,0,0,0,0],
         [0,0,0,0,0,0]]

let pieces: [[[Int]]] = [l, l2, t, i, o, s, z]

var currentPiece: [[Int]] = [[]]

var nextPiece: [[Int]] = [[]]



// Creates Score Keeping

var score: Int = 0

var time: Int = 0

var level: Int = 1

var lines: Int = 0



// Creates offset to move piece

let INITIAL_Y_OFFSET: Int = 0

let INITIAL_X_OFFSET: Int = 3

var pieceOffset: (Int,Int) = (INITIAL_X_OFFSET, INITIAL_Y_OFFSET)

let SCORE_FOR_CLEARED_LINE: Int = 100



// Creates methods to display tetris pieces and update game state

func getRandomPieceFrom(pieces: [[[Int]]]) -> [[Int]] {
    
    let randomInt: Int = Int(arc4random_uniform(UInt32(pieces.count)))
    
    return pieces[randomInt]
}

func getValueAtCoords(x: Int, y: Int, inputArray: [[Int]]) -> Int {
    
    return inputArray[y][x]
}

func showPieceOn(screen: [[Int]], piece: [[Int]]) -> [[Int]] {
    
    var returnScreen = screen
    
    let pieceHeight = piece.count - 1
    
    let pieceWidth = piece[0].count - 1
    
    for height_index in 0...pieceHeight {
        
        for width_index in 0...pieceWidth {
            
            if(getValueAtCoords(x: width_index, y: height_index, inputArray: piece) == 1) {
                
                if((height_index + pieceOffset.1 < gameScreen.count - 1) &&
                    (width_index + pieceOffset.0 < gameScreen[0].count - 1)) {
                    
                    returnScreen[height_index + pieceOffset.1][width_index + pieceOffset.0] = 1
                }
            }
        }
    }
    
    return returnScreen
}

func addPieceTo(screen: [[Int]], inputPiece: [[Int]]) -> [[Int]] {
    
    var returnScreen = screen
    
    for height_index in 0...inputPiece.count - 1 {
        
        for width_index in 0...inputPiece[0].count - 1 {
                 
            if(getValueAtCoords(x: width_index, y: height_index, inputArray: inputPiece) == 1) {
                
                if(height_index + pieceOffset.1 < screen.count) {
                    
                    returnScreen[height_index + pieceOffset.1][width_index + pieceOffset.0] = 1
                }
            }
        }
    }
    
    return returnScreen
}

func display(piece: [[Int]]) {
    
    for height_index in 0...piece.count - 1 {
        
        for width_index in 0...(piece[0].count - 1) {
            
            if(piece[height_index][width_index] == 0) {
                
                print("  ", terminator:"")
                
            } else {
                
                print("[]", terminator:"")
            }
        }
        
        print() // prints new line character
    }
}

func displayGameScreen(inputScreen: [[Int]]) {
    
    let screenHeight = inputScreen.count - 1
    
    let screenWidth = inputScreen[0].count - 1
    
    for height_index in 0...screenHeight {

        if(height_index == 0 || height_index < inputScreen.count) {
            
            print("<!", terminator:"")
        }
        
        for width_index in 0...(screenWidth) {
            
            if(inputScreen[height_index][width_index] == 0) {
                
                print(" .", terminator:"")
                
            } else {
                
                print("[]", terminator:"")
            }
        }
        
        if(height_index == 0 || height_index < inputScreen.count) {
            
            print("!>", terminator:"")
        }
        
        print() // prints new line character

        if(height_index == 19 ) {
            
            print("<!********************!>")
            print("  \\/\\/\\/\\/\\/\\/\\/\\/\\/\\/")
        }
    }
}

func displayStats() {
    
    print("FULL LINES: " + String(lines))
    
    print("TIME: " + String(time))
    
    print("LEVEL: " + String(level))
    
    print("SCORE: " + String(score))
}

func clearFullRowsFrom(screen: [[Int]]) -> [[Int]] {
    
    var returnScreen = screen
    
    let MAX_NUMBER_OF_ITEMS_IN_ROW = screen[0].count
    
    let SCREEN_HEIGHT = screen.count - 1
    
    let SCREEN_WIDTH = screen[0].count - 1
    
    for y in 0...SCREEN_HEIGHT { // loops through all rows
        
        var numberOfItemsFoundInRow = 0
        
        for x in 0...SCREEN_WIDTH { // loops through all columns
            
            let iteratedValue = screen[y][x] // get value at coordinate
            
            if (iteratedValue == 1) {
                
                numberOfItemsFoundInRow = numberOfItemsFoundInRow + 1
                
                if(numberOfItemsFoundInRow == MAX_NUMBER_OF_ITEMS_IN_ROW) {
                    
                    score = score + SCORE_FOR_CLEARED_LINE
                    
                    lines = lines + 1
                    
                    // Removes full row
                    
                    for height_index in (0...y).reversed() {
                        
                        for width_index in 0...SCREEN_WIDTH {
                            
                            if(height_index - 1 >= 0) { // checks if this is the top row
                                
                                returnScreen[height_index][width_index] = returnScreen[height_index - 1][width_index]
                            }
                        }
                    }
                }
            }
        }
    }
    
    return returnScreen
}



// Checks for collisions

func willOverlap(inputScreen: [[Int]], inputPiece: [[Int]], inputOffsetX: Int, inputOffsetY: Int) -> Bool {
    
    var returnBoolean: Bool = false
    
    let pieceHeight = inputPiece.count - 1
    
    let pieceWidth = inputPiece[0].count - 1
    
    let screenHeight = inputScreen.count - 1
    
    // find the position of points that do not have a spot below them
    
    for height_index in 0...pieceHeight {
        
        for width_index in 0...pieceWidth {
            
            if(inputPiece[height_index][width_index] == 1) { // pixel is 1
                
                if(height_index + 1 < pieceHeight) {
                    
                    let currentY = height_index + 1
                    
                    if(inputPiece[currentY][width_index] == 0) { // pixel below is 0
                        
                        if(currentY + inputOffsetY <= screenHeight) {
                            
                            if(inputScreen[currentY + inputOffsetY][width_index + inputOffsetX] == 1) { // pixel on screen is 1 at coord
                                
                                // check if the pixel below is 1
                                
                                returnBoolean = true
                                
                                return returnBoolean
                            }
                        }
                    }
                }
            }
        }
    }
    
    return returnBoolean
}

func willTouchBottom(inputScreen: [[Int]], inputPiece: [[Int]], inputOffsetY: Int) -> Bool {
    
    var returnBoolean: Bool = false
    
    let pieceHeight = inputPiece.count - 1
    
    let pieceWidth = inputPiece[0].count - 1
    
    let screenHeight = inputScreen.count - 1
    
    let screenWidth = inputScreen[0].count - 1
    
    // find the pixel that has a 0 in the space below it
    
    for height_index in 0...pieceHeight {
        
        for width_index in 0...pieceWidth {
            
            if(inputPiece[height_index][width_index] == 1) { // pixel is 1
                
                if(height_index + 1 < pieceHeight) {
                    
                    var currentY = height_index + 1
                    
                    if(inputPiece[currentY][width_index] == 0) { // pixel below is 0
                        
                        if(currentY + inputOffsetY > screenHeight) {
                            
                            returnBoolean = true
                            
                            return returnBoolean
                        }
                    }
                }
            }
        }
    }
    
    return returnBoolean
}



// Rotates current piece

func transformLeft(piece: [[Int]]) -> [[Int]] {
    
    var returnPiece: [[Int]] = piece
    
    // modify the currentPiece
    
    for y in 0...piece.count - 1 {
        
        for x in 0...piece[0].count - 1 {
        
            returnPiece[y][x] = returnPiece[x][y]
        }
    }
    
    return returnPiece
}

func transformRight(piece: [[Int]]) -> [[Int]] {
    
    var returnPiece: [[Int]] = piece
    
    // modify the currentPiece
    
    return returnPiece
    
}

func rotate(piece: [[Int]], direction: String) -> [[Int]] {
    
    var returnPiece: [[Int]] = [[]]
    
    switch(direction) {
    case "left":
        returnPiece = transformLeft(piece: piece)
        break
    case "right":
        returnPiece = transformRight(piece: piece)
        break
    default:
        break
    }
    
    return returnPiece
}



// Creates Game Loop

func runGameLoop() {
    
    var gameIsActive: Bool = true
    
    while(gameIsActive) {
        
        displayStats()
        
        print("NEXT PIECE: ")
        
        print()
        
        display(piece: nextPiece)
        
        if((willOverlap(inputScreen: gameScreen, inputPiece: currentPiece, inputOffsetX: pieceOffset.0, inputOffsetY: pieceOffset.1)) ||
            (willTouchBottom(inputScreen: gameScreen, inputPiece: currentPiece, inputOffsetY: pieceOffset.1))) {
            
            gameScreen = addPieceTo(screen: gameScreen, inputPiece: currentPiece)

            currentPiece = nextPiece
            
            nextPiece = getRandomPieceFrom(pieces: pieces)
            
            pieceOffset.0 = INITIAL_X_OFFSET
            
            pieceOffset.1 = INITIAL_Y_OFFSET
            
        } else {
            
            pieceOffset.1 = pieceOffset.1 + 1
        }
        
        time = time + 1
        
        displayGameScreen(inputScreen: showPieceOn(screen: gameScreen, piece: currentPiece))
        
        gameScreen = clearFullRowsFrom(screen: gameScreen)
        
        sleep(1)
        
        //clearDaConsole() // XCODE console cuts off output (varies)
        CPlusWrapper().daClearScreenWrapped() // CONSOLE APP
    }
}



// Runs functions

currentPiece = getRandomPieceFrom(pieces:pieces)

nextPiece = getRandomPieceFrom(pieces:pieces)

runGameLoop()



//testing piece rotation
//display(piece: currentPiece)
//currentPiece = rotate(piece: currentPiece, direction: "left")
//display(piece: currentPiece)
