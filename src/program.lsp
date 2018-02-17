;; ************************************************************
;; * Name:  Philip Glazman                                    *
;; * Project:  Kono - Lisp Implementation                     *
;; * Class:  CMPS 366 Organization of Programming Languages   *
;; * Date:  2/6/2018                                          *
;; ************************************************************

;; TO RUN: sbcl --non-interactive --load program.lsp

;; Seed randomness. Only use of a global var. Find better solution later. 
;; Solution found on internet: https://stackoverflow.com/questions/4034042/random-in-common-lisp-not-so-random
(setf *random-state* (make-random-state t))

;; /* ********************************************************************* 
;; Function Name: randomDice 
;; Purpose: Returns a number between 2 and 12. Simluates dice roll.
;; Parameters: 
;;             none.
;; Return Value: A number between 2 and 12.
;; Local Variables: 
;;             none.
;; Algorithm: 
;;             1) Use random function to generate random number.
;; Assistance Received: none 
;; ********************************************************************* */
(defun randomDice ()
	(+ 2 (random 11)))

;; /* ********************************************************************* 
;; Function Name: choosefirstPlayer 
;; Purpose: Returns the first player in a list. Will either be (HUMAN) or (COMPUTER).
;; Parameters: 
;;             none.
;; Return Value: List containing (HUMAN) or list containing (COMPUTER). List will contain first player to play game.
;; Local Variables: 
;;             humanDice, holds atom from randomDice function. Represents dice roll for human.
;;             computerDice, holds atom from randomDice function. Represents dice roll for computer.
;; Algorithm: 
;;             1) Get random dice roll for human.
;;			   2) Get random dice roll for computer.
;;			   3) Output dice rolls to human.
;;			   4) If human dice roll is greater than computer dice roll, then return list (HUMAN).
;;		 	   5) If human dice roll is less than computer dice roll, then return list (COMPUTER).
;;			   6) Else if the dice rolls are equal, then recursive call function. 
;; Assistance Received: none 
;; ********************************************************************* */
(defun choosefirstPlayer()
	(let* ((humanDice (randomDice))
			(computerDice (randomDice)))
			(format t "Human rolls ~D. ~%" humanDice)
			(format t "Computer rolls ~D. ~%" computerDice)
			(cond 	((> humanDice ComputerDice)
					(list 'human))
					((< humanDice ComputerDice)
					(list 'computer))
					((= humanDice ComputerDice)
					(choosefirstPlayer)))))

;; /* ********************************************************************* 
;; Function Name: computerColor 
;; Purpose: Returns list holding computer player's color. 
;; Parameters: 
;;             none.
;; Return Value: List holding computer player's color, and human player's color.
;; Local Variables: 
;;             randomColor, holds atom from random function. This is a random 0 or 1 that chooses the computer player's color.
;; Algorithm: 
;;             1) Get random 0 or 1.
;;			   2) If number is 1, then computer is white. 
;;			   3) Else if number is 0, then computer is black.
;; Assistance Received: none 
;; ********************************************************************* */
(defun computerColor ()
	(let* ( (randomColor (random 1)) )
			(cond 	((= randomColor 1)
						(append (append (list 'w) (list 'human)) (list 'b)))
					((= randomColor 0)
						(append (append (list 'b) (list 'human)) (list 'w))))))

;; /* ********************************************************************* 
;; Function Name: chooseColor 
;; Purpose: Depending on who the first player is, ask first player for their color.
;; Parameters: 
;;             none.
;; Return Value: List holding first player and the first player's color choice.
;; Local Variables: 
;;             none.
;; Algorithm: 
;;             1) If first player is human, then ask human for what color they will play.
;;			   2) If first palyer ic omputer, randomly choose color for computer using computerColor function.
;; Assistance Received: none 
;; ********************************************************************* */
(defun chooseColor(firstPlayer)
	(cond 	((string= (first firstPlayer) 'human)
			(append firstPlayer (readHumanColor)))
			((string= (first firstPlayer) 'computer)
			(append firstPlayer (computerColor )))))

;; /* *********************************************
;; Source Code to draw the game board on the screen
;; ********************************************* */

;; /* ********************************************************************* 
;; Function Name: makeRowForBoard 
;; Purpose: Generates the row for the board.
;; Parameters: 
;;             column, the column index.
;;			   row, the row index.
;;			   boardSize, board size.
;; Return Value: List containing the pieces for that row.
;; Local Variables: 
;;             none.
;; Algorithm: 
;;             1) ...
;; Assistance Received: none 
;; ********************************************************************* */
(defun makeRowForBoard (column row boardSize)
	(cond ((= column 0)
				()             )
				;; First row is white.
				((= row 1)
					(append (list 'w)
					(makeRowForBoard (- column 1) row boardSize) )
				)
				;; Place white pieces on second row.
				((and (= row 2) (OR (= column 1) (= column boardSize)))
					(append (list 'w)
					(makeRowForBoard (- column 1) row boardSize) )
				)
				;; Place black pieces on last row
				((= row boardSize)
					(append (list 'b)
					(makeRowForBoard (- column 1) row boardSize) )        
				)
				;; Place black pieces on second to last row
				((and (= row (- boardSize 1)) (OR (= column 1) (= column boardSize)))
					(append (list 'b)
					(makeRowForBoard (- column 1) row boardSize) )
				)
				;; Place regular + pieces
				(t 
				(append (list '+)
				(makeRowForBoard (- column 1) row boardSize) )  )))

;; /* ********************************************************************* 
;; Function Name: makeBoard 
;; Purpose: Generates board with size.
;; Parameters: 
;;             boardSize, the board size.
;;			   constSize, actual board size.
;; Return Value: List of lists that represents board.
;; Local Variables: 
;;             none.
;; Algorithm: 
;;             1) ...
;; Assistance Received: none 
;; ********************************************************************* */
(defun makeBoard (boardSize constSize)
	(cond ((= boardSize 0)
				()             )
				(t 
				(append
				(makeBoard (- boardSize 1) constSize)
				(list (makeRowForBoard constSize boardSize constSize))))))

;; Displays board to user.
(defun displayBoard (board boardlength)
	(cond 		((= (length board) 0)
					(format t "~D ~%" 'S)  
					(format t "~D  " 'W)
					)
				((= boardlength 0)
					(format t "~D ~%" 'N)
					(displayBoard board (+ boardlength 1)))
				(t 
					 (format t "~D ~S ~%" boardlength (first board))
					 (displayBoard (rest board) (+ boardlength 1))
					 (format t "~D " (length board))
				)))

;; Returns row based on row number.
(defun filterRows (board boardlength row)
	(cond (	(= (length board) (- boardlength row) )
			(first board))
		  (t (filterRows (rest board) boardlength row))))

;; Returns column based on colum number.
(defun filterColumns (row boardlength column)
	(cond (	(= (length row) (- boardlength column) )
			(first row))
		  (t (filterColumns (rest row) boardlength column))))

;; Checks if a given piece can be moved.
;; returns piece color as a check, if not piece ,then clearly cannot move - allows computer and human to do their own checks
(defun validPieceToMove (board coordinates)
	;;rest thru rows,
	;; rest thru columns, 
	(filterColumns (filterRows board (+ (length board) 1) (first coordinates)) (+ (length board) 1) (first (rest coordinates))))

;; Returns row with updated piece at specific column index
(defun updateColumn (row boardlength columnIndex piece)
	(cond ( (= (length row) (- boardlength columnIndex) )
			(append piece (rest row)))
		  (t 
		  	(cons (first row) (updateColumn (rest row) boardlength columnIndex piece)
			))))

(defun updateRow (board boardlength rowIndex row)
	(cond ( (= (length board) (- boardlength rowIndex) )
			(append row (rest board)))
		  (t 
		  	(cons (first board) (updateRow (rest board) boardlength rowIndex row)
			))))

(defun updateCoordinates (board row column piece)
	(updateRow board (+ (length board) 1) row (list (updateColumn (filterRows board (+ (length board) 1) row) (+ (length board) 1) column piece))))

(defun updateBoard (board oldCoordinates NewCoordinates piece)
	;; update new coordinate
	(updateCoordinates (updateCoordinates board (first NewCoordinates) (first (rest NewCoordinates)) piece) (first oldCoordinates) (first (rest oldCoordinates)) (list '+))
	;; remove old coordinate
	)

	

;; // List all the relevant functions here

;; /* *********************************************
;; Source Code to ask the human player for input
;; ********************************************* */

;; Validates choice if yes, then true. Else no.
(defun validYesNo (choice)
	(cond ( (string= choice "Y")
					(print choice)  )
				( (string= choice "N")
					(print choice)  )
				( t 
					(readPlayFromFile) )) )

;; Validates board size.
(defun validBoardSize (choice)
	(cond ( (= choice 5)
					(print choice)  )
				( (= choice 7)
					(print choice)  )
				( (= choice 9)
					(print choice)  )
				( t 
					(readBoardSize) )) )

;; Validates menu choice.
(defun validMenu (choice)
	(cond ( (= choice 1)
					(list 'save)  )
				( (= choice 2)
					(list 'play)  )
				( (= choice 3)
					(list 'help)  )
				( (= choice 4)
					(list 'quit)  )
				( t 
					(readMenu) )) )

;; Validates direction of piece.
(defun validHumanDirection (choice row column)
	(cond ( (string= choice "NW")
			(append (list (- row 1)) (list (- column 1))))
		  ( (string= choice "NE")
		  	(append (list (- row 1)) (list (+ column 1))))
		  ( (string= choice "SE")
		  	(append (list (+ row 1)) (list (+ column 1))))
		  ( (string= choice "SW")
		  	(append (list (+ row 1)) (list (- column 1))))
		  (t 
		  	(readHumanDirection))))

;; Validates color choice.
(defun validColor (choice)
	(cond ( (string= choice "W")
			(append (append (list 'w) (list 'computer) (list 'b))))
		 ( (string= choice "B")
		 	(append (append (list 'b) (list 'computer) (list 'w))))
		  (t 
		  	(readHumanColor))))

;; Ask user to read if they would like to read game from file.
(defun readPlayFromFile ()
		(princ "Do you want to start a game from a file? (Y/N) ")
		(terpri)
		(validYesNo (read))  )

;; Ask user for size of board.
(defun readBoardSize ()
		(princ "Enter size of board (5/7/9): ")
		(terpri)
		(validBoardSize (read))  )

;; Ask user for menu choice.
(defun readMenu ()
		(terpri)
		(princ "1. Save the game.")
		(terpri)
		(princ "2. Make a move.")
		(terpri)
		(princ "3. Ask for help.")
		(terpri)
		(princ "4. Quit the game.")
		(terpri)
		(validMenu (read)))

;; Ask user for color.
(defun readHumanColor ()
		(princ  "What color will you play? (w/b)")
		(terpri)
		(validColor (read)))

;; Ask user for row of piece to move.
(defun readHumanRow ()
	(princ "Enter row of piece to move: ")
	(terpri)
	(list (read)))

;; Ask user for column of piece to move.
(defun readHumanColumn ()
	(princ "Enter column of piece to move: ")
	(terpri)
	(list (read)))

;; Ask user direction to move piece
(defun readHumanDirection (coordinates)
	(princ "Enter direction to move (NW/NE/SE/SW): ")
	(terpri)
	(validHumanDirection (read) (first coordinates) (first (rest coordinates))))


;; /* *********************************************
;; Source Code for serialization 
;; ********************************************* */

;; Return list of players, board, current player
;; (defun openFile()
;; 	(let* (	( inFile (open "game.txt" :direction :input :if-does-not-exist nil))
;; 			(print (read-line inFile ))
;; 																				)
;; 			(close inFile)))
;; (print (openFile))

(defun getPlayerColor (players currentTurn)
	(cond 	(	(string= currentTurn (first (rest (rest players))) )
				(first (rest (rest (rest players)))))
			(	(string= currentTurn (first players))
				(first (rest players)))))

;; /* ********************************************************************* 
;; Function Name: playRound 
;; Purpose: Logic for the round. Alternates each player for the turn and holds board state.
;; Parameters: 
;;             none.
;; Return Value: none.
;; Local Variables: 
;;             none.
;; Algorithm: 
;;             1) ...
;; Assistance Received: none 
;; ********************************************************************* */
(defun playRound (players board currentTurn)
		(format t "It is ~A's turn. ~%" currentTurn)
		(displayBoard board 0)
		;;(check winner)
		(let*( 	(choice (readMenu))
				(playerColor (getPlayerColor players currentTurn)))
		(cond 	((string= (first choice) 'save)
							(print "Saving game"))
						((string= (first choice) 'play)
							(let*( (coordinates (append (readHumanRow) (readHumanColumn) ))
								   (finalCoordinates (readHumanDirection coordinates)))
									(validPieceToMove board coordinates)
									;;(validDirectionToMove))
									(cond 
									;; if the current player is last in players, next in players
									((string= currentTurn (first (rest (rest players))) )
										(playRound players (updateBoard board coordinates finalCoordinates (list playerColor)) (first players)))
									;; if current player is first players, then next in players
									((string= currentTurn (first players))
										(playRound players (updateBoard board coordinates finalCoordinates (list playerColor)) (first (rest (rest players))))))
									))
								((string= (first choice) 'help)
									(print "Asking for help"))
								((string= (first choice) 'quit)
									(print "Quiting game")
									(Quit)))))
		;; Logic for updating board state, and next player
		

;; init game new
(let* 	(	;; User is asked to resume game from text file.
			(fileChoice (readPlayFromFile))
			;; User is asked for board size at the start of round.
			(boardSize (readBoardSize))
			;; Creates board using n size.
			(board (makeBoard boardSize boardSize))
			;; choose first player and board.
			(players (chooseColor (choosefirstPlayer))))
			
			(format t "~A is ~A. ~%" (first players) (first (rest players)))
			(format t "~A is ~A. ~%" (first (rest (rest players))) (first (rest (rest (rest players)))))
			(playRound players board (first players))
			
			)

;; /* *********************************************
;; Source Code to help the computer win the game
;; ********************************************* */
;; // List all the relevant functions here

