;; ************************************************************
;; * Name:  Philip Glazman                                    *
;; * Project:  Kono - Lisp Implementation                     *
;; * Class:  CMPS 366 Organization of Programming Languages   *
;; * Date:  2/6/2018                                          *
;; ************************************************************

;; TO RUN: sbcl --non-interactive --load program.lsp

;; /* *********************************************
;; Source Code for game logic and utility functions.
;; ********************************************* */

;; /* ********************************************************************* 
;; Function Name: randomDice 
;; Purpose: Returns a number between 2 and 12. Simluates dice roll.
;; Parameters: 
;;             none.
;; Return Value: A number between 2 and 12.
;; Local Variables: 
;;             randomSeed, stores random state needed to seed randomness.
;; Algorithm: 
;;             1) Seed randomness.
;;			   2) Use random function to generate random number.
;; Assistance Received: none 
;; ********************************************************************* */
(defun randomDice ()
	(let* ( (randomSeed (make-random-state t)))
			(+ 2 (random 11 randomSeed))))

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
	(let* (	(humanDice (randomDice))
			(computerDice (randomDice))	)
			(format t "Human rolls ~D. ~%" humanDice)
			(format t "Computer rolls ~D. ~%" computerDice)
			(cond (	(> humanDice ComputerDice)
					(list 'human)	)
				  (	(< humanDice ComputerDice)
					(list 'computer)	)
				  (	(= humanDice ComputerDice)
					(choosefirstPlayer)))))

;; /* ********************************************************************* 
;; Function Name: computerColor 
;; Purpose: Returns list holding computer player's color. 
;; Parameters: 
;;             none.
;; Return Value: List holding computer player's color, and human player's color.
;; Local Variables: 
;;             randomColor, holds atom from random function. This is a random 0 or 1 that chooses the computer player's color.
;;             randomSeed, stores random state needed to seed randomness.
;; Algorithm: 
;;             1) Get random 0 or 1.
;;			   2) If number is 1, then computer is white. 
;;			   3) Else if number is 0, then computer is black.
;; Assistance Received: none 
;; ********************************************************************* */
(defun computerColor ()
	(let* ( (randomSeed (make-random-state t))
			(randomColor (random 1 randomSeed)))
			(cond (	(= randomColor 1)
					(append (append (list 'w) (list 'human)) (list 'b))	)
				  (	(= randomColor 0)
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
	(cond (	(string= (first firstPlayer) 'human)
			(append firstPlayer (readHumanColor))	)
		  (	(string= (first firstPlayer) 'computer)
			(append firstPlayer (computerColor )))))

;; /* ********************************************************************* 
;; Function Name: getPlayerColor 
;; Purpose: Returns the color of the player.
;; Parameters: 
;;			   players, list holding each player and its player color
;; 			   currentTurn, atom holding player to get color of.
;; Return Value: Atom that is either W or B for player color.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the player is the third in the players list, return the fourth item in the players list.
;;             2) If the player is the first in the players list, return the second item in the players list.
;; Assistance Received: none 
;; ********************************************************************* */
(defun getPlayerColor (players currentTurn)
	(cond (	(string= currentTurn (first (rest (rest players))) )
			(first (rest (rest (rest players)))))
		  (	(string= currentTurn (first players))
			(first (rest players)))))

;; /* ********************************************************************* 
;; Function Name: getOppositePlayerColor 
;; Purpose: Returns the color of the opposite player.
;; Parameters: 
;;			   playerColor, color of the player that you want the opposite of.
;; Return Value: Atom that is either W or B for player color.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If player color is white, return black.
;;             2) If player color is black, return white.
;; Assistance Received: none 
;; ********************************************************************* */
(defun getOppositePlayerColor (playerColor)
	(cond (	(string= playerColor 'w) 
			'b)
		  (	(string= playerColor 'b)
			'w)))

;; /* ********************************************************************* 
;; Function Name: getSuperPieceForPlayerColor 
;; Purpose: Returns the super piece of a given player color. Returns lower-case letter of player color.
;; Parameters: 
;;			   playerColor, color of the player.
;; Return Value: String holding either "w" or "b" as super piece.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If player color is white, return lower-case white string.
;;             2) If player color is black, return lower-case black string.
;; Assistance Received: none 
;; ********************************************************************* */
(defun getSuperPieceForPlayerColor (playerColor)
	(cond (	(string= playerColor "W") 
			"w")
		  (	(string= playerColor "B")
			"b")))

;; /* ********************************************************************* 
;; Function Name: getNextPlayer 
;; Purpose: Return the next player that will be playing.
;; Parameters: 
;;			   currentTurn, holds who is current player.
;; Return Value: Name of the player that is next.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If current player is human, return computer.
;;             2) If current player is computer, return human.
;; Assistance Received: none 
;; ********************************************************************* */
(defun getNextPlayer (currentTurn)
	(cond (	(string= currentTurn 'human )
			'computer)
		  (	(string= currentTurn 'computer)
			'human)))

;; /* ********************************************************************* 
;; Function Name: getOpponentColor 
;; Purpose: Return the color of the opponent.
;; Parameters: 
;;			   players, list holding each player and its color.
;;			   currentTurn, holds who is current player.
;; Return Value: The color of the opponent player.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the current player is second in the players list, return the color of the first player.
;;             2) If the current player is first in the players list, return the color of the second player.
;; Assistance Received: none 
;; ********************************************************************* */
(defun getOpponentColor (players currentTurn)
	(cond (	(string= currentTurn (first (rest (rest players))) )
			(first (rest players)))
		  (	(string= currentTurn (first players))
			(first (rest (rest (rest players)))))))

;; /* ********************************************************************* 
;; Function Name: flatten 
;; Purpose: Remove nested lists in the provided list and concatenates the lists. 
;; Parameters: 
;;			   list, the list to unnest.
;; Return Value: A new list that unnested lists inside.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the list is empty, return empty list.
;;			   2) If the first item of the list is an atom, prepend it to the rest of the list.
;;			   3) Default option is to recursively call function while appending the first of the list to the rest of the list.
;; Assistance Received: Recieved help from stackoverflow.
;; 		 https://stackoverflow.com/questions/2680864/how-to-remove-nested-parentheses-in-lisp
;; ********************************************************************* */
(defun flatten (list)
  	(cond ;; If list is empty, return empty list.
	  	  (	(eq list nil) 
	  		())
		  ;; If the first in the list is an atom, add it to the rest of the list.
		  (	(atom (first list)) 
		  	(cons (first list) (flatten (rest list))))
		  ;; Recursively call function.
		  (t 
		  	(append (flatten (first list)) (flatten (rest list))))))

;; /* ********************************************************************* 
;; Function Name: getCountofBlack 
;; Purpose: Get the number of remaining black pieces left on the board.
;; Parameters: 
;;			   board, unnested board list.
;;			   count, the number of black pieces.
;; Return Value: The count of the number of black pieces left on the board.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Recursively call getCountofBlack until there is no more board left.
;;			   2) Check if the first of the board is black, if it is, increment count and call getCountOfBlack with the rest of board.
;;			   3) Else, Call getCountOfBlack with the rest of board.
;;			   4) TODO: recursively call function without count parameter.
;; Assistance Received: None.
;; ********************************************************************* */
(defun getCountofBlack (board count)
	(cond (	(eq (first board) nil)
			count)
		  (	(OR (string= (first board) "B") (string= (first board) "b"))
			(getCountOfBlack (rest board) (+ count 1)))
		  (t 
			(getCountOfBlack (rest board) count))))

;; /* ********************************************************************* 
;; Function Name: getCountofWhite 
;; Purpose: Get the number of remaining white pieces left on the board.
;; Parameters: 
;;			   board, unnested board list.
;;			   count, the number of white pieces.
;; Return Value: The count of the number of white pieces left on the board.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Recursively call getCountofWhite until there is no more board left.
;;			   2) Check if the first of the board is white, if it is, increment count and call getCountofWhite with the rest of board.
;;			   3) Else, Call getCountofWhite with the rest of board.
;;			   4) TODO: recursively call function without count parameter.
;; Assistance Received: None.
;; ********************************************************************* */
(defun getCountofWhite (board count)
	(cond (	(eq (first board) nil)
			count)
		  (	(OR (string= (first board) "W") (string= (first board) "w"))
			(getCountofWhite (rest board) (+ count 1)))
		  (t 
			(getCountofWhite (rest board) count))))

;; /* ********************************************************************* 
;; Function Name: getWhiteSide 
;; Purpose: Gets the number of remaining black pieces that have yet to capture the white side.
;; Parameters: 
;;			   board, unnested board list.
;;			   boardlength, the length of the board.
;;			   numBlack, the number of black pieces that have not captured the white side.
;;			   index, index number used for looping through unnested board.
;; Return Value: The count of black pieces that have not captured the white side.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the board is empty, return the number of black pieces left outside of white side.
;;			   2) If the home piece has a black piece on it, then decrement the number of black pieces.
;;			   3) Recursively call this function until the entire white home side has been accounted for.
;; Assistance Received: None.
;; ********************************************************************* */
(defun getWhiteSide (board boardlength numBlack index)
	(cond (	(eq (first board) nil)
			numBlack)
			;; Checking columns in row one for black piece.
		  (	(AND (<= index (+ boardlength 1)) (OR (string= (first board) "B") (string= (first board) "b")))
			(getWhiteSide (rest board) boardlength (- numBlack 1) (+ index 1)))
		  	;; Checking columns in row two for black piece.
		  (	(AND (= index (* boardlength 2)) (OR (string= (first board) "B") (string= (first board) "b")))
			(getWhiteSide (rest board) boardlength (- numBlack 1) (+ index 1)))
		  (t 
			(getWhiteSide (rest board) boardlength numBlack (+ index 1)))))

;; /* ********************************************************************* 
;; Function Name: getBlackSide 
;; Purpose: Gets the number of remaining white pieces that have yet to capture the black side.
;; Parameters: 
;;			   board, unnested board list.
;;			   boardlength, the length of the board.
;;			   numWhite, the number of white pieces that have not captured the white side.
;;			   index, index number used for looping through unnested board.
;; Return Value: The count of white pieces that have not captured the black side.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the board is empty, return the number of white pieces left outside of black side.
;;			   2) If the home piece has a white piece on it, then decrement the number of white pieces.
;;			   3) Recursively call this function until the entire black home side has been accounted for.
;; Assistance Received: None.
;; ********************************************************************* */
(defun getBlackSide (board boardlength numWhite index)
	(cond (	(eq (first board) nil)
			numWhite)
			;; Check last row for white pieces.
		  (	(AND (>= index (* boardlength (- boardlength 1))) (OR (string= (first board) "W") (string= (first board) "w")))
			(getBlackSide (rest board) boardlength (- numWhite 1) (+ index 1)))
			;; Check second to last row for white pieces.
		  (	(AND (= index (* boardlength (- boardlength 2))) (OR (string= (first board) "W") (string= (first board) "w")))
			(getBlackSide (rest board) boardlength (- numWhite 1) (+ index 1)))
		  (	(AND (= index (+ (* boardlength (- boardlength 2)) 1)) (OR (string= (first board) "W") (string= (first board) "w")))
			(getBlackSide (rest board) boardlength (- numWhite 1) (+ index 1)))
		  (t 
			(getBlackSide (rest board) boardlength numWhite (+ index 1)))))

;; /* ********************************************************************* 
;; Function Name: checkwinner 
;; Purpose: Returns t if a winning condition has been met, else returns empty list.
;; Parameters: 
;;			   board, game board.
;; Return Value: T or nil if game condition has been met.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Check if the white side has been captured by black pieces.
;;			   2) Check if the black side has been captured by white pieces.
;; Assistance Received: None.
;; ********************************************************************* */
(defun checkwinner(board)
	(cond (	(= (getWhiteSide (flatten board) (length board) (getCountofBlack (flatten board) 0) 1) 0)
			t)
		  (	(= (getBlackSide (flatten board) (length board) (getCountofWhite (flatten board) 0) 1) 0)
			t)
		  (t
			())))

;; /* ********************************************************************* 
;; Function Name: countBlackScore 
;; Purpose: Counts the score for the black player.
;; Parameters: 
;;			   board, unnested game board.
;;			   boardlength, length of the board.
;;			   score, current score
;;			   index, used to traverse board.
;; Return Value: Score which is sum of the total points captured.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Using an unnested game board piece. Check if the index has a black piece on it.
;;			   2) Depending on the index, add points to the score.
;; Assistance Received: None.
;; ********************************************************************* */
(defun countBlackScore (board boardlength score index)
	(cond 	((eq (first board) nil)
			score)
			((AND (= index 1) (OR (string= (first board) "B") (string= (first board) "b")))
				(countBlackScore (rest board) boardlength (+ score 3) (+ index 1)))
			((AND (= index 2) (OR (string= (first board) "B") (string= (first board) "b")))
				(countBlackScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (= index 3) (OR (string= (first board) "B") (string= (first board) "b")))
				(countBlackScore (rest board) boardlength (+ score 5) (+ index 1)))
			;; board size is 5
			((AND (AND (= index 4) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 5))
				(countBlackScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (AND (= index 5) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 5))
				(countBlackScore (rest board) boardlength (+ score 3) (+ index 1)))
			;; board size is 7
			((AND (AND (= index 4) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 7))
				(countBlackScore (rest board) boardlength (+ score 7) (+ index 1)))
			((AND (AND (= index 5) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 7))
				(countBlackScore (rest board) boardlength (+ score 5) (+ index 1)))
			((AND (AND (= index 6) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 7))
				(countBlackScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (AND (= index 7) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 7))
				(countBlackScore (rest board) boardlength (+ score 3) (+ index 1)))
			;; board size is 9
			((AND (AND (= index 4) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 9))
				(countBlackScore (rest board) boardlength (+ score 7) (+ index 1)))
			((AND (AND (= index 5) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 9))
				(countBlackScore (rest board) boardlength (+ score 9) (+ index 1)))
			((AND (AND (= index 6) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 9))
				(countBlackScore (rest board) boardlength (+ score 7) (+ index 1)))
			((AND (AND (= index 7) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 9))
				(countBlackScore (rest board) boardlength (+ score 5) (+ index 1)))
			((AND (AND (= index 8) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 9))
				(countBlackScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (AND (= index 9) (OR (string= (first board) "B") (string= (first board) "b"))) (= boardlength 9))
				(countBlackScore (rest board) boardlength (+ score 3) (+ index 1)))
			;; row 2
			((AND (= index (+ boardlength 1)) (OR (string= (first board) "B") (string= (first board) "b")))
				(countBlackScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (= index (* boardlength 2)) (OR (string= (first board) "B") (string= (first board) "b")))
				(countBlackScore (rest board) boardlength (+ score 1) (+ index 1)))
			(t 
			(countBlackScore (rest board) boardlength score (+ index 1)))))

;; /* ********************************************************************* 
;; Function Name: countWhiteScore 
;; Purpose: Counts the score for the white player.
;; Parameters: 
;;			   board, unnested game board.
;;			   boardlength, length of the board.
;;			   score, current score
;;			   index, used to traverse board.
;; Return Value: Score which is sum of the total points captured.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Using an unnested game board piece. Check if the index has a white piece on it.
;;			   2) Depending on the index, add points to the score.
;; Assistance Received: None.
;; ********************************************************************* */
(defun countWhiteScore (board boardlength score index)
	(cond 	((eq (first board) nil)
			score)
			((AND (= index (+ (* boardlength (- boardlength 1)) 1)) (OR (string= (first board) "W") (string= (first board) "w")))
				(countWhiteScore (rest board) boardlength (+ score 3) (+ index 1)))
			((AND (= index (+ (* boardlength (- boardlength 1)) 2)) (OR (string= (first board) "W") (string= (first board) "w")))
				(countWhiteScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (= index (+ (* boardlength (- boardlength 1)) 3)) (OR (string= (first board) "W") (string= (first board) "w")))
				(countWhiteScore (rest board) boardlength (+ score 5) (+ index 1)))
			;; board size is 5
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 4)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 5))
				(countWhiteScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 5)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 5))
				(countWhiteScore (rest board) boardlength (+ score 3) (+ index 1)))
			;; board size is 7
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 4)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 7))
				(countWhiteScore (rest board) boardlength (+ score 7) (+ index 1)))
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 5)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 7))
				(countWhiteScore (rest board) boardlength (+ score 5) (+ index 1)))
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 6)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 7))
				(countWhiteScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 7)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 7))
				(countWhiteScore (rest board) boardlength (+ score 3) (+ index 1)))
			;; board size is 9
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 4)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 9))
				(countWhiteScore (rest board) boardlength (+ score 7) (+ index 1)))
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 5)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 9))
				(countWhiteScore (rest board) boardlength (+ score 9) (+ index 1)))
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 6)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 9))
				(countWhiteScore (rest board) boardlength (+ score 7) (+ index 1)))
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 7)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 9))
				(countWhiteScore (rest board) boardlength (+ score 5) (+ index 1)))
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 8)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 9))
				(countWhiteScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (AND (= index (+ (* boardlength (- boardlength 1)) 9)) (OR (string= (first board) "W") (string= (first board) "w"))) (= boardlength 9))
				(countWhiteScore (rest board) boardlength (+ score 3) (+ index 1)))
			;; row 2
			((AND (= index (* boardlength (- boardlength 1))) (OR (string= (first board) "W") (string= (first board) "w")))
				(countWhiteScore (rest board) boardlength (+ score 1) (+ index 1)))
			((AND (= index (+ (* boardlength (- boardlength 2)) 1)) (OR (string= (first board) "W") (string= (first board) "w")))
				(countWhiteScore (rest board) boardlength (+ score 1) (+ index 1)))
			(t 
			(countWhiteScore (rest board) boardlength score (+ index 1)))))

;; /* ********************************************************************* 
;; Function Name: calculateScores 
;; Purpose: Calculates scores for computer and human players.
;; Parameters: 
;;			   board, game board.
;;			   boardlength, length of the board.
;; Return Value: Returns list containing score for white and black players.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Get scores for white player.
;;			   2) Get scores for black player.
;;			   3) Put scores into list and return the list.
;; Assistance Received: None.
;; ********************************************************************* */
(defun calculateScores (board boardlength)
	;; Return white score and black score in that order.
	(list (+ (countWhiteScore board boardlength 0 1) (* (- (+ boardlength 2) (getCountOfBlack board 0)) 5))
	(+ (countBlackScore board boardlength 0 1) (* (- (+ boardlength 2) (getCountofWhite board 0)) 5))))

;; /* ********************************************************************* 
;; Function Name: announceScores 
;; Purpose: Outputs player score.
;; Parameters: 
;;			   player, player name - either computer or human.
;;			   score, player's score.
;; Return Value: None.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Output player and score.
;; Assistance Received: None.
;; ********************************************************************* */
(defun announceScores (player score)
	(format t "~A scored ~S points. ~%" player score))

;; /* ********************************************************************* 
;; Function Name: calculateWinner 
;; Purpose: Calculates the winner for the current game round.
;; Parameters: 
;;			   playerOne, first player.
;;			   scoreOne, player one's score.
;;			   playerTwo, second player.
;;			   scoreTwo, player two's score.
;; Return Value: List containing winner and difference of scores to be awarded.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Check if scoreOne is greater than scoreTwo. If so, then output that the playerOne is winner.
;;             2) Check if scoreOne is less than scoreTwo. If so, then output that the playerTwo is winner.
;;			   3) If it is a tie, output that it is a tie.
;; Assistance Received: None.
;; ********************************************************************* */
(defun calculateWinner (playerOne scoreOne playerTwo scoreTwo)
	(cond (	(> scoreOne scoreTwo)
			(format t "~A won and is awarded ~S points ~%" playerOne (- scoreOne scoreTwo))
			(list playerOne (- scoreOne scoreTwo)))
		  (	(< scoreOne scoreTwo)
			(format t "~A won and is awarded ~S points ~%" playerTwo (- scoreTwo scoreOne))
			(list playerTwo (- scoreTwo scoreOne)))
		  (	(= scoreOne scoreTwo)
			(format t "There is no clear winner. It is a draw. ~%")
			(list playerOne 0))))

;; /* ********************************************************************* 
;; Function Name: getWinner 
;; Purpose: Announces scores for the current round and calls function to calculate Winner.
;; Parameters: 
;;			   board, game board.
;;			   players, players list holding players and player colors.
;; Return Value: List containing winner and difference of scores to be awarded.
;; Local Variables: 
;;             scores, list that has total points for each player for the round.
;; Algorithm: 
;;             1) Announce first player's points.
;;             2) Announce second player's points.
;;			   3) Announce winner.
;; Assistance Received: None.
;; ********************************************************************* */
(defun getWinner(board players)
	;; scores for the game.
	(let* ( (scores (calculateScores (flatten board) (length board))))
		;; if first player is white, announce the white score
		(cond (	(string= (first (rest players)) "W")
				(announceScores (first players) (first scores))
				(announceScores (first (rest (rest players))) (first (rest scores)))
				(calculateWinner (first players) (first scores) (first (rest (rest players))) (first (rest scores))))
				;; if first player is black, announce the black score
			  ( (string= (first (rest players)) "B")
				(announceScores (first players) (first (rest scores)))
				(announceScores (first (rest (rest players))) (first scores))
				(calculateWinner (first players) (first (rest scores)) (first (rest (rest players))) (first scores))))))

;; /* ********************************************************************* 
;; Function Name: announceTournamentScores 
;; Purpose: Announces tournament scores.
;; Parameters: 
;;			   player, player to be announced.
;;			   score, player's score.
;; Return Value: None.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Announce player's tournament score.
;; Assistance Received: None.
;; ********************************************************************* */
(defun announceTournamentScores (player score)
	(format t "~A has ~S points. ~%" player score))

;; /* ********************************************************************* 
;; Function Name: tournamentControl 
;; Purpose: Main tournament control logc. Calls functions to announce scores and asks user to play again.
;; Parameters: 
;;			   prevWinner, previous winner of the tournament.
;;			   scores, scores list that has tournament score for each player.
;; Return Value: None.
;; Local Variables: 
;;             tournamentScore, list hold tournament scores for each player.
;;			   playAgain, choice for human to play round again.
;; Algorithm: 
;;             1) Announce player's tournament score.
;;			   2) Ask human if they want to play again. Record answer to local variable.
;;			   3) Previous winner plays first.
;; Assistance Received: None.
;; ********************************************************************* */
(defun tournamentControl (prevWinner scores)
	;; Get tournament scores.
	(let* ( (tournamentScore (calculateTournamentScore prevWinner scores)))
		;; Announce tournament scores.
		(format t "Tournament Scores: ~%")
		(announceTournamentScores (first tournamentScore) (first (rest tournamentScore)))
		(announceTournamentScores (first (rest (rest tournamentScore))) (first (rest (rest (rest tournamentScore)))))
		;; Ask user to play again.
		(let* ( (playAgain (readPlayAgain)))
			(cond (	(string= playAgain "Y")
					;; Previous winner plays first.
					(newRound tournamentScore (first prevWinner)))
				  (	(string= playAgain "N")
				  	;; Quit game.
					(Quit))))))
	
;; /* ********************************************************************* 
;; Function Name: calculateTournamentScore 
;; Purpose: Calculates tournament score by adding round score to the tournament score.
;; Parameters: 
;;			   roundScores, round scores.
;;			   tournamentScores, tournament scores.
;; Return Value: Returns new scores list containing the awarded difference in points to the tournament scores.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) If first player is computer, return new list object given that the first player is computer.
;;             2) If first player is human, return new list object given that the first player is human.
;;			   3) I unfortunately did not standardize the scores list, therefore I have to always check to see who the first player is and adjust accordingly.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun calculateTournamentScore (roundScores tournamentScores)
	(cond (	(string= (first roundScores) "COMPUTER")
			(list 'computer (+ (first (rest tournamentScores)) (first (rest roundScores))) 'human (first (rest (rest (rest tournamentScores)))) (+ 1 (first (rest (rest (rest (rest tournamentScores))))))))
		  (	(string= (first roundScores) "HUMAN")
			(list 'computer (first (rest tournamentScores)) 'human (+ (first (rest (rest (rest tournamentScores)))) (first (rest roundScores))) (+ 1 (first (rest (rest (rest (rest tournamentScores))))))))))

;; /* ********************************************************************* 
;; Function Name: playHuman 
;; Purpose: Logic for human player.
;; Parameters: 
;;			   players, list of players.
;;			   board, game board.
;;			   scores, current tournament scores.
;;			   playerColor, human player color.
;; Return Value: None.
;; Local Variables: 
;;			   coordinates, row and column positions of human player piece.
;; Algorithm: 
;;             1) Ask for player coordinates.
;;			   2) Ask for direction to move.
;;			   4) Validate coordinates and final coordinates.
;;			   5) Update board if valid, else ask again.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun playHuman (players board scores playerColor)
	(let*( (coordinates (append (readHumanRow) (readHumanColumn) ))
		;; get final coordinates
		(finalCoordinates (readHumanDirection coordinates))
		;; checks if the piece at coordinates is equal to the player color
		(isValidPiece (validPieceToMove board coordinates))
		;; checks if the piece at new coordinates is "+"
		(isValidDirection (validDirectionToMove board finalCoordinates)))
		(cond (	(AND (OR (string= isValidPiece playerColor) (string= isValidPiece (getSuperPieceForPlayerColor playerColor))) (OR (string= isValidDirection (getSuperPieceForPlayerColor (getOppositePlayerColor playerColor))) (OR (string= isValidDirection "+") (string= isValidDirection (getOppositePlayerColor playerColor)))))
				(playRound players (updateBoard board coordinates finalCoordinates (list isValidPiece)) 'computer scores))
			  (t
				(princ "Not a valid move. Try again.") 
				(playRound players board 'human scores)))))

;; /* ********************************************************************* 
;; Function Name: rev 
;; Purpose: Reverses a list.
;; Parameters: 
;;			   list, a list to reverse.
;; Return Value: None.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) If list is null, return empty list.
;;			   2) Recursively append the rest of the list to the first of the list.
;; Assistance Received: Recieved help on stackoverflow.
;;	https://stackoverflow.com/questions/34422711/reversing-list-in-lisp
;; ********************************************************************* */	
(defun rev (list)
	(cond (	(null list) 
			())
		  (t 
		  	(append (rev (rest list)) (list (first list))))))

;; /* *********************************************
;; Source Code for board model and display.
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
;;             1) Recusive function where base case is when column index is 0.
;;			   2) Continue to loop through the function passing each row until column index is 0.
;;			   4) If row index is one, populate the entire row with "W" pieces.
;;			   5) If row is second, given certain columns , place a "W" piece.
;;			   6) If row is last row, populate entire row with "B" pieces.
;;			   7) If row is second to last, given certain columns, place a "B" piece.
;; Assistance Received: none 
;; ********************************************************************* */
(defun makeRowForBoard (column row boardSize)
	(cond (	(= column 0)
			()	)
			;; First row is white.
		  (	(= row 1)
				(append (list "W")
				(makeRowForBoard (- column 1) row boardSize))	)
			;; Place white pieces on second row.
		  (	(and (= row 2) (OR (= column 1) (= column boardSize)))
				(append (list "W")
				(makeRowForBoard (- column 1) row boardSize))	)
			;; Place black pieces on last row
		  (	(= row boardSize)
				(append (list "B")
				(makeRowForBoard (- column 1) row boardSize))	)
			;; Place black pieces on second to last row
		  (	(and (= row (- boardSize 1)) (OR (= column 1) (= column boardSize)))
				(append (list "B")
				(makeRowForBoard (- column 1) row boardSize))	)
			;; Place regular + pieces
		  (t 
			(append (list "+")
			(makeRowForBoard (- column 1) row boardSize)))))

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
;;             1) Populate each row of the board and append it to the board list.
;;			   2) While board size is not zero, append makeBoard function output to the board.
;;			   4) Decrement board size while appending output to board.
;; Assistance Received: none 
;; ********************************************************************* */
(defun makeBoard (boardSize constSize)
	(cond (	(= boardSize 0)
			()	)
		  (t 
			(append (makeBoard (- boardSize 1) constSize)
			(list (makeRowForBoard constSize boardSize constSize))))))

;; /* ********************************************************************* 
;; Function Name: displayBoard 
;; Purpose: Prints board with coordinate grid to standard output.
;; Parameters: 
;;             board, board object.
;;			   boardindex, initialized at 0. Increments with each pass.
;;			   boardlength, constant length of the board.
;; Return Value: Board to standard output.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Recursive function that loops through each row in board and prints it. 
;;			   2) If there is no more row, print South and West compasses.
;;		   	   3) If the board index is zero, print the North compass. And increment board index.
;;			   4) Print the row and row number. Increment the board index.
;;			   5) Using tail recursion, print the column numbers. 
;;			   6) Using tail recursion, if there are no more column numbers, print the East compass.
;; Assistance Received: none 
;; ********************************************************************* */
(defun displayBoard (board boardindex boardlength)
	(cond 
			;; If there is no more board left, print compasses South and West.
		  (	(= (length board) 0)
			(format t "~A ~%" "S")  
			(format t "~A  " "W"))
			;; If the the board is starting to print (boardindex = 0), then print North compass.
		  (	(= boardindex 0)
			(format t "~D ~%" 'N)
			;; Call displayBoard.
			(displayBoard board (+ boardindex 1) boardlength)	)
			;; Print the row for the board, row #.
		  (t 
			(format t "~D ~A ~%" boardindex (first board))
			(displayBoard (rest board) (+ boardindex 1) boardlength)
			;; Print column #.
			(format t "~D " (length board))
			;; If there are no more columns left, print East compass.
			(cond (	(= (length board) boardlength)
					(format t "~D ~%" 'E))))))

;; /* ********************************************************************* 
;; Function Name: filterRows 
;; Purpose: Returns a list containing a row from the board given the row number.
;; Parameters: 
;;             board, board object.
;;			   boardlength, constant length of the board.
;;			   row, the row number of the row to return.
;; Return Value: List of the board at the given row number.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the length of the board is equal to the row number, return the row.
;;			   2) Else call function and decrement one row list from the board.
;; Assistance Received: none 
;; ********************************************************************* */
(defun filterRows (board boardlength row)
	(cond (	(= (length board) (- boardlength row) )
			(first board)	)
		  (t 
		  	(filterRows (rest board) boardlength row))))

;; /* ********************************************************************* 
;; Function Name: filterColumns 
;; Purpose: Returns a list containing a column from the board given the column number.
;; Parameters: 
;;             row, row list.
;;			   boardlength, constant length of the board.
;;			   column, the column number of the row to return.
;; Return Value: List of the column at column number.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the length of the row is equal to the column number, return the column.
;;			   2) Else call function and decrement one column list from the row.
;; Assistance Received: none 
;; ********************************************************************* */
(defun filterColumns (row boardlength column)
	(cond (	(= (length row) (- boardlength column) )
			(first row))
		  (t (filterColumns (rest row) boardlength column))))

;; /* ********************************************************************* 
;; Function Name: validPieceToMove 
;; Purpose: Checks if a given piece at coordinates can be moved. Returns piece color at coordinates. Validation is done at function that calls.
;; Parameters: 
;;             board, board object.
;;			   coordinates, list containing row and column of piece.
;; Return Value: Returns the piece at coordinates. 
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Check if the row or column is less than zero. IF it is, return a X signalling that it is not a valid piece to move.
;;			   2) Check if the row or column is greater than the length of the board. IF it is, return a X signalling that it is not a valid piece to move.
;;			   3) Filter the columns and rows to return the piece located at that coordinate.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validPieceToMove (board coordinates)
	(cond ;; Check if row or coordinate is less than zero.
		  (	(OR (<= (first coordinates) 0) (<= (first (rest coordinates)) 0))
			'x)
		  ;; Check if row or coordinate is greater than legth of board.
		  (	(OR (> (first coordinates) (length board)) (> (first (rest coordinates)) (length board)))
			'x)
		  ;; Filter columns and row to return the piece at the provided coordinates.
		  (t
			(filterColumns (filterRows board (+ (length board) 1) (first coordinates)) (+ (length board) 1) (first (rest coordinates))))))

;; /* ********************************************************************* 
;; Function Name: validDirectionToMove 
;; Purpose: Checks if the coordinates provided are a valid place to move by returning the piece located at that coordinate.
;; Parameters: 
;;             board, board object.
;;			   finalCoordinates, list containing row and column of place to move to.
;; Return Value: Returns the piece at finalCoordinates in board.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Check if the row or column is less than zero. If it is, return a X signalling that it is not a valid piece to move to.
;;			   2) Check if the row or column is greater than the length of the board. IF it is, return a X signalling that it is not a valid piece to move to.
;;			   3) Filter the columns and rows to return the piece located at that coordinate.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validDirectionToMove (board finalCoordinates)
	(cond ;; Check if coordinate is less than zero.
		  (	(OR (<= (first finalCoordinates) 0) (<= (first (rest finalCoordinates)) 0))
			'x)
		  ;; Check if coordinate is greater than length of the board.
		  (	(OR (> (first finalCoordinates) (length board)) (> (first (rest finalCoordinates)) (length board)))
			'x)
		  ;; Return piece located at the coordinate.
		  (t
		   	(filterColumns (filterRows board (+ (length board) 1) (first finalCoordinates)) (+ (length board) 1) (first (rest finalCoordinates))))))

;; /* ********************************************************************* 
;; Function Name: updateColumn 
;; Purpose: Updates the piece at a given column index of a row. 
;; Parameters: 
;;             row, row list.
;;			   boardlength, length of the board.
;;			   columnIndex, index of piece to update.
;;			   piece, piece that will replace existing piece at columnIndex.
;;			   finalCoordinates, list containing row and column of place to move to.
;; Return Value: Returns a row list with the updated piece at the specific column index.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the column index equals the length of the row, append the new peice to the rest of the row.
;;			   2) If not, call the function recursively while prepending the first of the row using head recursion.
;; Assistance Received: none 
;; ********************************************************************* */
(defun updateColumn (row boardlength columnIndex piece)
	(cond ;; Found columnIndex
		  ( (= (length row) (- boardlength columnIndex) )
			(append piece (rest row)))
		  ;; Loop through the remaning row. Prepend first of the row using head recursion.
		  (t 
		  	(cons (first row) (updateColumn (rest row) boardlength columnIndex piece)))))

;; /* ********************************************************************* 
;; Function Name: updateRow 
;; Purpose: Updates the piece at a given column index of a row. 
;; Parameters: 
;;             board, board object.
;;			   boardlength, length of the board.
;;			   rowIndex, index of row to update.
;;			   row, row that will replace row and rowIndex.
;; Return Value: Returns the board object with the updated board.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the row index equals the length of the board, append the new row to the rest of the board.
;;			   2) If not, call the function recursively while prepending the first of the board using head recursion.
;; Assistance Received: none 
;; ********************************************************************* */
(defun updateRow (board boardlength rowIndex row)
	(cond ;; Found row at row index. Append row to the rest of the board.
		  ( (= (length board) (- boardlength rowIndex) )
			(append row (rest board)))
		  ;; Recursively call the function with the rest of the board. Using head recursion, prepend the first board.
		  (t 
		  	(cons (first board) (updateRow (rest board) boardlength rowIndex row)))))

;; /* ********************************************************************* 
;; Function Name: updateCoordinates 
;; Purpose: Holds logic to update coordinates.
;; Parameters: 
;;             board, board object.
;;			   row, row number of piece to update.
;;			   column, column number of piece to update.
;;			   piece, piece that will replace existing piece.
;; Return Value: Returns new board with updated piece at coordinates.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Call updateRow.
;; Assistance Received: none 
;; ********************************************************************* */
(defun updateCoordinates (board row column piece)
	(updateRow board (+ (length board) 1) row (list (updateColumn (filterRows board (+ (length board) 1) row) (+ (length board) 1) column piece))))

;; /* ********************************************************************* 
;; Function Name: updateBoard 
;; Purpose: Holds logic to update board. It will update new coordinate and remove old coordinate.
;; Parameters: 
;;             board, board object.
;;			   oldCoordinates, list containing old row and old column of piece.
;;			   newCoordinates, list containing new row and new column of piece.
;;			   piece, piece that will replace existing piece.
;; Return Value: Returns new board with updated pieces at coordinates.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Call updateCoordinates.
;; Assistance Received: none 
;; ********************************************************************* */
(defun updateBoard (board oldCoordinates NewCoordinates piece)
	;; Update new coordinate and remove old coordinate.
	(updateCoordinates (updateCoordinates board (first NewCoordinates) (first (rest NewCoordinates)) (checkSuperPiece (length board) piece newCoordinates)) (first oldCoordinates) (first (rest oldCoordinates)) (list "+")))

;; /* ********************************************************************* 
;; Function Name: checkSuperPiece 
;; Purpose: Checks if the piece at coordinate is eligible to become a super piece.
;; Parameters: 
;;             boardlength, length of the board.
;;			   piece, piece to check eligibility for upgrade.
;;			   coordinate, coordinate of the piece.
;; Return Value: If the piece can be upgraded, returns upgraded super piece. If not, returns regular piece.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the piece is white, check if the piece reached the black side of the board. If so, return the super piece of that piece.
;;             2) If the piece is black, check if the piece reached the white side of the board. If so, return the super piece of that piece.
;;			   3) If the piece is not eligible to be upgraded to super piece or is already super piece, return the piece.
;; Assistance Received: none 
;; ********************************************************************* */
(defun checkSuperPiece(boardlength piece coordinate)
	(cond ;; Check if the white piece can be upgraded.
		  (	(AND (string= (first piece) "W") (= (first coordinate) boardlength))
			(list (getSuperPieceForPlayerColor (first piece))))
	      ;; Check if the black piece can be upgraded.
		  (	(AND (string= (first piece) "B") (= (first coordinate) 1))
			(list (getSuperPieceForPlayerColor (first piece))))
		  ;; Default action to return piece.
		  (t 
		  	piece)))

;; /* *********************************************
;; Source Code to ask the human player for input
;; ********************************************* */

;; /* ********************************************************************* 
;; Function Name: validYesNoPlayFile 
;; Purpose: Checks if parameter choice is either Y or N. If not, call original function again.
;; Used to read human input for loading an existing game.
;; Parameters: 
;;             choice, string for human input.
;; Return Value: choice.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If choice is "Y", return choice.
;;			   2) If choice is "N", return choice.
;;			   3) Else call readPlayFromFile() again to read user input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validYesNoPlayFile (choice)
	(cond ( (string= choice "Y")
			choice	)  
		  ( (string= choice "N")
			choice	) 
		  (t 
			(readPlayFromFile) )) )

;; /* ********************************************************************* 
;; Function Name: validYesNoPlayFile 
;; Purpose: Checks if parameter choice is either Y or N. If not, call original function again. 
;; Used for reading human input for playing game again.
;; Parameters: 
;;             choice, string for human input.
;; Return Value: choice.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If choice is "Y", return choice.
;;			   2) If choice is "N", return choice.
;;			   3) Else call readPlayAgain() again to read user input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validPlayAgain (choice)
	(cond ( (string= choice "Y")
			choice	)  
		  ( (string= choice "N")
			choice	) 
		  (t 
			(readPlayAgain))))

;; /* ********************************************************************* 
;; Function Name: validBoardSize 
;; Purpose: Validates human input for board size. If size is correct, return the size. Else, call readBoardSize again.
;; Parameters: 
;;             choice, string for human input.
;; Return Value: choice.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If choice matches a board size, return the board size.
;;			   3) Else call readBoardSize() again to read user input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validBoardSize (choice)
	(cond ( (string= choice "5")
			5	)
		  ( (string= choice "7")
			7	)
		  ( (string= choice "9")
			9	)
		  ( t 
			(readBoardSize))))

;; /* ********************************************************************* 
;; Function Name: validMenu 
;; Purpose: Validates menu choice. If correct, will return the choice. Else, will call readMenu again.
;; Parameters: 
;;             choice, string for human input.
;;			   currentTurn, string that is the current turn. Is included in recursive call to readMenu.
;; Return Value: List containing choice.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If choice matches a menu choice, return the list of that choice. Ideally, should return atom. Made it return a list as it was coded when I just started LISP.
;;			   2) If choice does not match, call readMenu again.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validMenu (choice currentTurn)
	(cond ( (string= choice "1")
			(list 'save)  )
		  ( (string= choice "2")
			(list 'play)  )
		  ( (string= choice "3")
			(list 'help)  )
		  ( (string= choice "4")
			(list 'quit)  )
		  ( t 
			(readMenu currentTurn) )) )

;; /* ********************************************************************* 
;; Function Name: validHumanDirection 
;; Purpose: Validates human input for direction to move piece.
;; Parameters: 
;;             choice, string for human input.
;;			   row, row number of starting position.
;;             column, column number of start position.
;; Return Value: List containing coordinate (row,column) of the direction chosen.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If choice matches a direction, return a list containing the row and column coordinates of that coordinate.
;;			   2) If choice does not match, call readHumanDirection again with coordinates.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validHumanDirection (row column choice)
	(cond ( (string= choice "NW")
			(append (list (- row 1)) (list (- column 1))))
		  ( (string= choice "NE")
		  	(append (list (- row 1)) (list (+ column 1))))
		  ( (string= choice "SE")
		  	(append (list (+ row 1)) (list (+ column 1))))
		  ( (string= choice "SW")
		  	(append (list (+ row 1)) (list (- column 1))))
		  (t 
		  	(readHumanDirection (append (list row) (list column))))))

;; /* ********************************************************************* 
;; Function Name: validColor 
;; Purpose: Validates choice for player color.
;; Parameters: 
;;             choice, string for human input.
;; Return Value: List containing (human humanColor computer computerColor).
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If choice matches a color, return a list containing (human humanColor computer computerColor)
;;			   2) If choice does not match, call readHumanColor again.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validColor (choice)
	(cond ( (string= choice "W")
			;; Human will be white. Computer will be black.
			(append (append (list 'w) (list 'computer) (list 'b)))	)
		  ( (string= choice "B")
		  	;; Human will be black. Computer will be white.
		 	(append (append (list 'b) (list 'computer) (list 'w)))	)
		  (t 
		  	(readHumanColor))))

;; /* ********************************************************************* 
;; Function Name: readPlayFromFile 
;; Purpose: Reads input from human to play a game from file.
;; Parameters: 
;;             None.
;; Return Value: Output from validYesNoPlayFile. Which will containg Y or N.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Call function to validate input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readPlayFromFile ()
	(princ "Do you want to start a game from a file? (Y/N) ")
	(terpri)
	(validYesNoPlayFile (read-line)))

;; /* ********************************************************************* 
;; Function Name: readFileName 
;; Purpose: Reads input from human to play a game from file.
;; Parameters: 
;;             None.
;; Return Value: Output from validFile. Which will contain filename or nil if file does not exist.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Call function to validate input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readFileName()
	(princ "Name of game file: ")
	(terpri)
	(validFile (read-line)))

;; /* ********************************************************************* 
;; Function Name: readSaveFileName 
;; Purpose: Reads input from human to save game to file.
;; Parameters: 
;;             None.
;; Return Value: String containing user input.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Read input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readSaveFileName()
	(princ "Name of the save file: ")
	(terpri)
	(read-line))

;; /* ********************************************************************* 
;; Function Name: readBoardSize 
;; Purpose: Reads input from human for board size.
;; Parameters: 
;;             None.
;; Return Value: Output from validBoardSize which will contain the board size as an atom.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Call function to validate input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readBoardSize ()
	(princ "Enter size of board (5/7/9): ")
	(terpri)
	(validBoardSize (read-line)))

;; /* ********************************************************************* 
;; Function Name: readMenu 
;; Purpose: Reads input from human for menu.
;; Parameters: 
;;             None.
;; Return Value: Output from validMenu which will contain the user choice.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Call function to validate input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readMenu (currentTurn)
	(terpri)
	(princ "1. Save the game.")
	(terpri)
	(princ "2. Make a move.")
	(terpri)
	;; If current turn is human, allow human to ask for help.
	(cond (	(string= currentTurn 'human)
			(princ "3. Ask for help.")
			(terpri)))
	(princ "4. Quit the game.")
	(terpri)
	(validMenu (read-line) currentTurn))

;; /* ********************************************************************* 
;; Function Name: readHumanColor 
;; Purpose: Reads input from human for player color..
;; Parameters: 
;;             None.
;; Return Value: Output from validColor which will contain the user choice.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Call function to validate input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readHumanColor ()
		(princ  "What color will you play? (W/B)")
		(terpri)
		(validColor (read-line)))

;; /* ********************************************************************* 
;; Function Name: validHumanRow 
;; Purpose: Validates input for human row.
;; Parameters: 
;;             coordinate, contains the row coordinate.
;; Return Value: List containing row coordinate.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Convert string to integer. 
;;			   2) If integer is number, then return integer. 
;;			   3) Else, call readHumanRow again.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validHumanRow (coordinate)
	;; Boolean for if the coordinate is a number.
	(let* ( (isNumber (numberp (ignore-errors (parse-integer coordinate)))))
	
	;; Check if coordinate is a number.
	(cond ( (eq isNumber nil)
			(princ "Invalid row number.")
			(terpri)
			(readHumanRow))
		  (t
			(list (parse-integer coordinate))))))

;; /* ********************************************************************* 
;; Function Name: readHumanRow 
;; Purpose: Reads input from human for row to move.
;; Parameters: 
;;             None.
;; Return Value: Output from validHumanRow which will contain the row number.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Call function to validate input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readHumanRow ()
	(princ "Enter row of piece to move: ")
	(terpri)
	(validHumanRow (read-line)))

;; /* ********************************************************************* 
;; Function Name: validHumanColumn 
;; Purpose: Validates input for human column.
;; Parameters: 
;;             coordinate, contains the column coordinate.
;; Return Value: List containing column coordinate.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Convert string to integer. 
;;			   2) If integer is number, then return integer. 
;;			   3) Else, call readHumanRow again.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validHumanColumn (coordinate)
	;; Boolean for if the coordinate is a number.
	(let* ( (isNumber (numberp (ignore-errors (parse-integer coordinate)))))
	
	;; Check if coordinate is a number.
	(cond ( (eq isNumber nil)
			(princ "Invalid column number.")
			(terpri)
			(readHumanColumn))
		  (t
			(list (parse-integer coordinate))))))

;; /* ********************************************************************* 
;; Function Name: readHumanColumn 
;; Purpose: Reads input from human for column to move.
;; Parameters: 
;;             None.
;; Return Value: Output from validHumanColumn which will contain the column number.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Call function to validate input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readHumanColumn ()
	(princ "Enter column of piece to move: ")
	(terpri)
	(validHumanColumn (read-line)))

;; /* ********************************************************************* 
;; Function Name: readHumanDirection 
;; Purpose: Reads input from human for which direction to move piece.
;; Parameters: 
;;             None.
;; Return Value: Output from validHumanDirection which will contain the coordinates of the direction that the piece will move to.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Call function to validate input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readHumanDirection (coordinates)
	(princ "Enter direction to move (NW/NE/SE/SW): ")
	(terpri)
	(validHumanDirection (first coordinates) (first (rest coordinates)) (read-line)))

;; /* ********************************************************************* 
;; Function Name: readPlayAgain 
;; Purpose: Reads input from human for if to play game again. 
;; Parameters: 
;;             None.
;; Return Value: Output from validPlayAgain which will contain the user choice.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Ask user for input.
;;			   2) Call function to validate input.
;; Assistance Received: none 
;; ********************************************************************* */
(defun readPlayAgain ()
	(princ "Do you want to play again? (Y/N): ")
	(terpri)
	(validPlayAgain (read-line)))

;; /* *********************************************
;; Source Code for serialization 
;; ********************************************* */

;; /* ********************************************************************* 
;; Function Name: validFile 
;; Purpose: Checks if file with fileName exists.
;; Parameters: 
;;             fileName, name of the file to open for serialization..
;; Return Value: FileName if file exists, or nil if file does not exist.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Use probe-file to check for file.
;; Assistance Received: none 
;; ********************************************************************* */
(defun validFile (fileName)
	(probe-file fileName))

;; /* ********************************************************************* 
;; Function Name: fileColorToGameColor 
;; Purpose: Given a color from the file, convert it to B or W.
;; Parameters: 
;;             color, player color described in the file.
;; Return Value: Atom representing player color - either B or W.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If color is "BLACK", then return B.
;;             2) If color is "WHITE", then return W.
;; Assistance Received: none 
;; ********************************************************************* */
(defun fileColorToGameColor (color)
	(cond (	(string= color "BLACK")
			'b)
		  ( (string= color "WHITE")
			'w)))

;; /* ********************************************************************* 
;; Function Name: convertBoardRow 
;; Purpose: For each coordinate in the board, convert board from file into game.
;; Parameters: 
;;             row, one row from the board.
;; Return Value: List containing game pieces for the row.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If length of row is zero, return empty list.
;;             2) If piece at first of row is "B", return a list with "B" and call the function recursively to continue looping through the row.
;;			   3) Continue to check for pieces and looping through row until the row is empty.
;;			   4) A list containing all of the appropriate game pieces will be appended and returned.
;; Assistance Received: none 
;; ********************************************************************* */
(defun convertBoardRow (row)
	(cond ( (= (length row) 0)
			())
		  ( (string= (first row) "B")
			(append (list "B") (convertBoardRow (rest row))))
		  ( (string= (first row) "BB")
			(append (list "b") (convertBoardRow (rest row))))
		  ( (string= (first row) "W")
			(append (list "W") (convertBoardRow (rest row))))
		  ( (string= (first row) "WW")
			(append (list "w") (convertBoardRow (rest row))))
		  ( (string= (first row) "O")
			(append (list "+") (convertBoardRow (rest row))))))

;; /* ********************************************************************* 
;; Function Name: fileBoardToGameBoard 
;; Purpose: For each row in the file board, convert the row into the appropriate row in game. Return the list of rows as board to be used in game.
;; Parameters: 
;;             board, board uploaded from game file.
;; Return Value: List of lists of game pieces representing the board.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Recursively loop through the board.
;;             2) If there is no more board left, return empty list.
;;			   3) Call convertBoardRow to load the row and append it to the recursive fileBoardToGameBoard call.
;;			   4) Returns the board.
;; Assistance Received: none 
;; ********************************************************************* */
(defun fileBoardToGameBoard (board)
	(cond ( (= (length board) 0)
			())
		  (t 
			(append (list (convertBoardRow (first board))) (fileBoardToGameBoard  (rest board))))))

;; /* ********************************************************************* 
;; Function Name: convertBoardRowToFile 
;; Purpose: Convert the board row to a row that is suitable for file serialization.
;; Parameters: 
;;             row, row to be converted.
;; Return Value: Updated row with pieces that match serialization pieces.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the length of the row is zero, return empty list.
;;             2) For each first piece of the row, append the appropriate serialized piece. And call function with the rest of the row.
;; Assistance Received: none 
;; ********************************************************************* */
(defun convertBoardRowToFile (row)
	(cond ( (= (length row) 0)
			())
		  ( (string= (first row) "B")
			(append (list "B") (convertBoardRowToFile (rest row))))
			;; Super piece.
		  ( (string= (first row) "b")
			(append (list "BB") (convertBoardRowToFile (rest row))))
		  ( (string= (first row) "W")
			(append (list "W") (convertBoardRowToFile (rest row))))
			;; Super piece.
		  ( (string= (first row) "w")
			(append (list "WW") (convertBoardRowToFile (rest row))))
			;; Empty piece.
		  ( (string= (first row) "+")
			(append (list "O") (convertBoardRowToFile (rest row))))))

;; /* ********************************************************************* 
;; Function Name: gameBoardToFileBoard 
;; Purpose: Convert the board to a bard that is suitable for file serialization.
;; Parameters: 
;;             board, board to be converted.
;; Return Value: Updated board with pieces that match serialization pieces.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If the length of the board is zero, return empty list.
;;             2) Append output from convertBoardRowToFile using head recursion to current function until there is no more board left.
;; Assistance Received: none 
;; ********************************************************************* */
(defun gameBoardToFileBoard (board)
	(cond ( (= (length board) 0)
			())
		  (t 
			(append (list (convertBoardRowToFile (first board))) (gameBoardToFileBoard  (rest board))))))

;; /* ********************************************************************* 
;; Function Name: gameColorToFileColor 
;; Purpose: Convert color piece format in game to one suitable for file serialization.
;; Parameters: 
;;             color, color to convert.
;; Return Value: Color of the piece using serialization format.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) If color is "B" return string "Black".
;;             2) If color is "W" return string "White".
;; Assistance Received: none 
;; ********************************************************************* */
(defun gameColorToFileColor (color)
	(cond (	(string= color 'b)
			"BLACK")
		  ( (string= color 'w)
			"WHITE")))

;; /* ********************************************************************* 
;; Function Name: saveToFile 
;; Purpose: Saves state of game to file.
;; Parameters: 
;;             fileName, name of file to save to.
;;			   players, list holding each player and its player color
;;			   board, list holding game board
;; 			   currentTurn, atom holding next player.
;;  		   scores, list holding each player's scores.
;; Return Value: None.
;; Local Variables: 
;;             None.
;; Algorithm: 
;;             1) Use with-open-file to output to file given file name.
;;             2) Write to file using format stream.
;; Assistance Received: none 
;; ********************************************************************* */
(defun saveToFile(fileName players board currentTurn scores)
	(with-open-file (stream fileName :direction :output :if-exists :supersede)
		(format stream "( ~%")
		(format stream "; Round: ~%")
		(format stream "~S ~%" (first (rest (rest (rest (rest scores))))))
		(format stream "; Computer Score: ~%")
		(format stream "~S ~%" (first (rest scores)))
		(format stream "; Computer Color: ~%")
		(format stream "~A ~%" (gameColorToFileColor (getPlayerColor players 'computer)))
		(format stream "; Human Score: ~%")
		(format stream "~S ~%" (first (rest (rest (rest scores)))))
		(format stream "; Human Color: ~%")
		(format stream "~A ~%" (gameColorToFileColor (getPlayerColor players 'human)))
		(format stream "; Board: ~%")
		(format stream "~A ~%" (gameBoardToFileBoard board))
		(format stream "; Next Player: ~%")
		(format stream "~S ~%" currentTurn)
		(format stream ")")))

;; /* ********************************************************************* 
;; Function Name: openFile 
;; Purpose: If file name is invalid, quit game.
;; Parameters: 
;;             fileName, name of file to save to.
;; Return Value: List of players, board, next player, and scores.
;; Local Variables: 
;;             file, file stream object.
;;			   roundNum, round number.
;;			   computerScore, computer score.
;;			   computerColor, computer color.
;;			   humanScore, human score.
;;			   humanColor, human color.
;;			   board, the game board.
;;			   nextPlayer, the next player.
;; Algorithm: 
;;             1) Checks if fileName is nil, if so, then quit game.
;;			   2) Open file using with-open-file.
;;			   3) Save file stream as local variable.
;;			   4) Read each variable from file stream into local variables.
;;			   5) Return list of players, board, next player, and scores.
;; Assistance Received: none 
;; ********************************************************************* */
(defun openFile(fileName)

	;; If file is invalid, then quit the game. 
	(cond ( (eq fileName nil)
			(princ "Could not open file.")
			(Quit)))

	;; Open file.
	(with-open-file (stream fileName :direction :input :if-does-not-exist nil)
		;; Save file object as file.
		(let* ( (file (read stream nil))
				(roundNum (first file))
				(computerScore (first (rest file)))
				(computerColor (first (rest (rest file))))
				(humanScore (first (rest (rest (rest file)))))
				(humanColor (first (rest (rest (rest (rest file))))))
				(board (first (rest (rest (rest (rest (rest file)))))))
				(nextPlayer (first (rest (rest (rest (rest (rest (rest file)))))))))

			;; Debugging output.
			;; (format t "Round Number: ~D ~%" roundNum)
			;; (format t "Computer Score: ~D ~%" computerScore)
			;; (format t "Computer Color: ~D ~%" (fileColorToGameColor computerColor))
			;; (format t "Human Score: ~D ~%" humanScore)
			;; (format t "Human Color: ~D ~%" (fileColorToGameColor humanColor))
			;; (format t "Board: ~S ~%" (fileBoardToGameBoard board))
			;; (format t "Next Player: ~D ~%" nextPlayer)

			;; Make players list. Append Board to it. Append next player. Append scores.
			(append
				(append 
					(append 
						;; Convert color of pieces in file to appropriate names used in game. ("WHITE" becomes "W")
						(list (list 'computer (fileColorToGameColor computerColor) 'human (fileColorToGameColor humanColor))) 
							;; Convert file board into game board.
							(list (fileBoardToGameBoard board)))
								(list nextPlayer))
									(list 'computer computerScore 'human humanScore roundNum)))))

;; /* *********************************************
;; Source Code to help the computer win the game
;; ********************************************* */

;; /* ********************************************************************* 
;; Function Name: getClosestOpponent 
;; Purpose: Finds the first opponent piece relative and returns its coordinates.
;; Parameters: 
;;			   board, unnested board list.
;;			   boardlength, length of the board.
;;			   opponentColor, color of the opponent to find.
;;			   index, used as counter. TODO: refactor this code to get rid of this counter parameter.
;; Return Value: Coordinates with row and column of the closest opponent.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) If the opponent is white, loop through the board until the first white piece is found. Return these coordinates.
;;			   2) If the opponent is black, loop through the board until the first black piece is found. Return these coordinates.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun getClosestOpponent (board boardlength opponentColor index)	
	(cond ;; If the opponent is white.
		  (	(string= opponentColor "W")
			(cond ;; If the piece is white, return the coordinates.
			   	  (	(OR (string= (first board) "W") (string= (first board) "w"))
					(list (- (+ boardlength 1) (ceiling index boardlength)) (- (+ boardlength 1) (cond ((= (rem index boardlength) 0) boardlength) (t (rem index boardlength))))))
				  ;; Call function again with the rest of the board and increment index.
				  (t 
					(getClosestOpponent (rest board) boardlength opponentColor (+ index 1)))))
		  ;; If the opponent is black.
		  ( (string= opponentColor "B")
			(cond ;; If the piece is black, return the coordinates.
			  	  (	(OR (string= (first board) "B") (string= (first board) "b"))
					(list (ceiling index boardlength) (cond ((= (rem index boardlength) 0) boardlength) (t (rem index boardlength)))))
				  ;; Call function again with the rest of the board.
				  (t 
					(getClosestOpponent (rest board) boardlength opponentColor (+ index 1)))))))

;; /* ********************************************************************* 
;; Function Name: playDefenseEast 
;; Purpose: Decision-making logic for blocking an opponent piece using pieces located on the east.
;; Parameters: 
;;			   board, board object.
;;			   opponentCoordinates, list containing coordinates of row and column of opponent piece.
;;			   playerColor, player color.
;; Return Value: Returns a list containing the original coordinates, final coordinates, and direction to play. Returns empty list if no piece can be blocked from east.
;; Local Variables: 
;;			   validFinalCoordinate, holds the piece located at the position that would block opponent piece from the east.
;;			   blockFromEast, holds piece located East of the opponent.
;;			   blockFromSouthEast, holds piece located South East of the opponent.
;;			   blockFromSouth, holds piece located South of the opponent.
;;			   blockFromNorth, holds piece located North of the opponent.
;;			   blockFromNorthEast, holds piece located North East of the opponent.
;;			   finalCoordinates, list that includes row and column of final coordinate to move to.
;; Algorithm: 
;;             1) Check if the player color is black or white.
;;			   2) Get piece located at coordinates that will block opponent piece.
;;			   3) Get piece located at coordinates east of opponent piece.
;;			   4) Get piece located at coordinates southeast of opponent piece.
;;			   5) Get piece located at coordinates south of opponent piece.
;;			   6) Get coordinates at location that will block opponent piece.
;;			   7) If the piece located at coordinates that will block opponent piece is taken, return nil.
;;			   8) Check each piece located at coordinates located eastward of opponent piece.
;;			   9) If piece can be moved to the final coordinate, return a list containing original coordinates, final coordinates, and direction to play. 
;;			   10) Returns empty list if no piece can be blocked from east.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun playDefenseEast(board opponentCoordinates playerColor)
	;; Computer is Black.
	(cond (	(string= playerColor "B")
				(let* (	(validFinalCoordinate (validDirectionToMove board (list (+ (first opponentCoordinates) 1) (+ (first (rest opponentCoordinates)) 1)) ))
						;; check for available piece in E
						(blockFromEast (validPieceToMove board (list (first opponentCoordinates) (+ (first (rest opponentCoordinates)) 2))))
						;; check for available piece in SE
						(blockFromSouthEast (validPieceToMove board (list (+ (first opponentCoordinates) 2) (+ (first (rest opponentCoordinates)) 2))))
						;; check for available piece in S
						(blockFromSouth (validPieceToMove board (list (+ (first opponentCoordinates) 2) (first (rest opponentCoordinates)) )))
						;; coordinates
						(finalCoordinates (list (+ (first opponentCoordinates) 1) (+ (first (rest opponentCoordinates)) 1))))
				;; Check if the final coordinate is able to moved to, if not return nil.
				(cond (	(string/= validFinalCoordinate "+")
						nil)
					  (
						;; Return original coordinate and final coordinate - else send nil.
						(cond (	(string= blockFromSouthEast "B")
								(list (list (+ (first opponentCoordinates) 2) (+ (first (rest opponentCoordinates)) 2)) finalCoordinates "northwest"))
							  (	(string= blockfromSouth "B")
								(list (list (+ (first opponentCoordinates) 2) (first (rest opponentCoordinates))) finalCoordinates "northeast"))
							  (	(string= blockFromEast "B")
								(list (list (first opponentCoordinates) (+ (first (rest opponentCoordinates)) 2)) finalCoordinates "southeast"))
							  (t 
								nil))))))

	;; Computer is White.
		  (	(string= playerColor "W")
				(let* (	(validFinalCoordinate (validDirectionToMove board (list (- (first opponentCoordinates) 1) (+ (first (rest opponentCoordinates)) 1)) ))
						;; check for available piece in E
						(blockFromEast (validPieceToMove board (list (first opponentCoordinates) (+ (first (rest opponentCoordinates)) 2))))
						;; check for available piece in NE
						(blockFromNorthEast (validPieceToMove board (list (- (first opponentCoordinates) 2) (+ (first (rest opponentCoordinates)) 2))))
						;; check for available piece in N
						(blockFromNorth (validPieceToMove board (list (- (first opponentCoordinates) 2) (first (rest opponentCoordinates)) )))
						;; coordinates
						(finalCoordinates (list (- (first opponentCoordinates) 1) (+ (first (rest opponentCoordinates)) 1))))

				;; Check if the final coordinate is able to moved to, if not return nil.
				(cond (	(string/= validFinalCoordinate "+")
						nil)
					  (	
						;; Return original coordinate and final coordinate - else send nil.
						(cond (	(string= blockFromNorthEast "W")
								(list (list (- (first opponentCoordinates) 2) (+ (first (rest opponentCoordinates)) 2)) finalCoordinates "southwest"))
							  (	(string= blockFromNorth "W")
								(list (list (- (first opponentCoordinates) 2) (first (rest opponentCoordinates))) finalCoordinates "southeast"))
							  (	(string= blockFromEast "W")
								(list (list (first opponentCoordinates) (+ (first (rest opponentCoordinates)) 2)) finalCoordinates "northwest"))
							  (t 
								nil))))))))

;; /* ********************************************************************* 
;; Function Name: playDefenseWest 
;; Purpose: Decision-making logic for blocking an opponent piece using pieces located on the west.
;; Parameters: 
;;			   board, board object.
;;			   opponentCoordinates, list containing coordinates of row and column of opponent piece.
;;			   playerColor, player color.
;; Return Value: Returns a list containing the original coordinates, final coordinates, and direction to play. Returns empty list if no piece can be blocked from west.
;; Local Variables: 
;;			   validFinalCoordinate, holds the piece located at the position that would block opponent piece from the west.
;;			   blockFromWest, holds piece located West of the opponent.
;;			   blockFromSouthWest, holds piece located South West of the opponent.
;;			   blockFromSouth, holds piece located South of the opponent.
;;			   blockFromNorthWest, holds piece located North West of the opponent.
;;			   blockFromNorth, holds piece located North of the opponent.
;;			   finalCoordinates, list that includes row and column of final coordinate to move to.
;; Algorithm: 
;;             1) Check if the player color is black or white.
;;			   2) Get piece located at coordinates that will block opponent piece.
;;			   3) Get piece located at coordinates west of opponent piece.
;;			   4) Get piece located at coordinates southwest of opponent piece.
;;			   5) Get piece located at coordinates south of opponent piece.
;;			   6) Get coordinates at location that will block opponent piece.
;;			   7) If the piece located at coordinates that will block opponent piece is taken, return nil.
;;			   8) Check each piece located at coordinates located westward of opponent piece.
;;			   9) If piece can be moved to the final coordinate, return a list containing original coordinates, final coordinates, and direction to play. 
;;			   10) Returns empty list if no piece can be blocked from west.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun playDefenseWest(board opponentCoordinates playerColor)
	;; Computer is Black.
	(cond (	(string= playerColor "B")	
				(let* (	(validFinalCoordinate (validDirectionToMove board (list (+ (first opponentCoordinates) 1) (- (first (rest opponentCoordinates)) 1)) ))
						;; check for available piece in W
						(blockFromWest (validPieceToMove board (list (first opponentCoordinates) (- (first (rest opponentCoordinates)) 2))))
						;; check for available piece in SW
						(blockFromSouthWest (validPieceToMove board (list (+ (first opponentCoordinates) 2) (- (first (rest opponentCoordinates)) 2))))
						;; check for available piece in S
						(blockFromSouth (validPieceToMove board (list (+ (first opponentCoordinates) 2) (first (rest opponentCoordinates)) )))
						;; coordinates
						(finalCoordinates (list (+ (first opponentCoordinates) 1) (- (first (rest opponentCoordinates)) 1))))
				;; Check if the final coordinate is able to moved to, if not return nil.
				(cond (	(string/= validFinalCoordinate "+")
						nil)
					  (
						;; Return original coordinate and final coordinate - else send nil.
						(cond (	(string= blockFromSouthWest "B")
								(list (list (+ (first opponentCoordinates) 2) (- (first (rest opponentCoordinates)) 2)) finalCoordinates "northeast"))
							(	(string= blockfromSouth "B")
								(list (list (+ (first opponentCoordinates) 2) (first (rest opponentCoordinates))) finalCoordinates "northwest"))
							(	(string= blockFromWest "B")
								(list (list (first opponentCoordinates) (- (first (rest opponentCoordinates)) 2)) finalCoordinates "southeast"))
							(t 
								nil))))))

	;; Computer is White.
		  (	(string= playerColor "W")
				(let* (	(validFinalCoordinate (validDirectionToMove board (list (- (first opponentCoordinates) 1) (- (first (rest opponentCoordinates)) 1)) ))
						;; check for available piece in W
						(blockFromWest (validPieceToMove board (list (first opponentCoordinates) (- (first (rest opponentCoordinates)) 2))))
						;; check for available piece in NW
						(blockFromNorthWest (validPieceToMove board (list (- (first opponentCoordinates) 2) (- (first (rest opponentCoordinates)) 2))))
						;; check for available piece in N
						(blockFromNorth (validPieceToMove board (list (- (first opponentCoordinates) 2) (first (rest opponentCoordinates)) )))
						;; coordinates
						(finalCoordinates (list (- (first opponentCoordinates) 1) (- (first (rest opponentCoordinates)) 1))))

				;; Check if the final coordinate is able to moved to, if not return nil.
				(cond (	(string/= validFinalCoordinate "+")
						nil)
					  (
						;; Return original coordinate and final coordinate - else send nil.
						(cond (	(string= blockFromNorthWest "W")
								(list (list (- (first opponentCoordinates) 2) (- (first (rest opponentCoordinates)) 2)) finalCoordinates "southeast"))
							  (	(string= blockFromNorth "W")
								(list (list (- (first opponentCoordinates) 2) (first (rest opponentCoordinates))) finalCoordinates "southwest"))
							  (	(string= blockFromWest "W")
								(list (list (first opponentCoordinates) (- (first (rest opponentCoordinates)) 2)) finalCoordinates "northeast"))
							  (t 
								nil))))))))

;; /* ********************************************************************* 
;; Function Name: getRandomPiece 
;; Purpose: Select piece located at index of list. Assumption is index is randomly chosen.
;; Parameters: 
;;			   listOfPieces, list of pieces to pick from.
;;			   index, index to select from list of pieces.
;; Return Value: Return list containing row and column of random piece.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) If index is zero, return first of list which is piece coordinates.
;;			   2) Else, call function again and decrement index.
;; Assistance Received: None.
;; ********************************************************************* */
(defun getRandomPiece(listOfPieces index)
;; Returns random piece coordinates
	(cond (	(= index 0)
			(first listOfPieces))
		  (t 
			(getRandomPiece (rest listOfPieces) (- index 1)))))

;; /* ********************************************************************* 
;; Function Name: randomPiece 
;; Purpose: Selects random index within a list of pieces.
;; Parameters: 
;;			   listOfPieces, list of player pieces.
;; Return Value: Returns index of a list of pieces.
;; Local Variables: 
;;			   randomSeed, stores random state needed to seed randomness.
;; Algorithm: 
;;             1) Use random function with length of list to get random index.
;; Assistance Received: None.
;; ********************************************************************* */
(defun randomPiece(listOfPieces)
	(let* ( (randomSeed (make-random-state t)))
		(random (length listOfPieces) randomSeed)))

;; /* ********************************************************************* 
;; Function Name: getFriendlyPieces 
;; Purpose: Create list of available pieces that the player controls.
;; Parameters: 
;;			   board, an unnested board list.
;;			   boardlength, length of board.
;;			   playerColor, color of the player.
;;			   index, index of piece in board. TODO: Refactor code to do recursive call without this parameter.
;; Return Value: Returns a list of available players pieces' coordinates.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) If board is empty, return empty list.
;;			   2) If first location in board matches player color, append its coordinates to a list.
;;			   3) If not, call function again and with the rest of the board.
;; Assistance Received: None.
;; ********************************************************************* */
(defun getFriendlyPieces(board boardlength playerColor index) 
	(cond (	(eq (first board) nil)
			())
			;; If piece matches player color, append its coordiants to the list.
		  ( (OR (string= (first board) playerColor) (string= (first board) (getSuperPieceForPlayerColor playerColor)))
			(append (list (list (ceiling index boardlength) (cond ((= (rem index boardlength) 0) boardlength) (t (rem index boardlength)))))
			(getFriendlyPieces (rest board) boardlength playerColor (+ index 1))))
			;; Increment index and call again with rest of the board.
		  (t
		  	(getFriendlyPieces (rest board) boardlength playerColor (+ index 1)))))

;; /* ********************************************************************* 
;; Function Name: makeAttackDecision 
;; Purpose: Decision-making logic for advancing a player piece forward.
;; Parameters: 
;;			   board, board object.
;;			   playerColor, player color.
;; 			   friendlyPiece, coordinates of piece to move forward
;; Return Value: Returns a list containing the original coordinates, final coordinates, and direction to play. Returns empty list if piece cannot move forward.
;; Local Variables: 
;;			   validNorthWest, holds piece located northwest of the player piece.
;;			   validNorthEast, holds piece located northeast of the player piece.
;;			   coordiantesNorthEast, holds coordinates of piece located northeast of player piece.
;;			   coordiantesNorthWest, holds coordinates of piece located northwest of player piece.
;;			   validSouthWest, holds piece located southwest of the player piece.
;;			   validSouthEast, holds piece located southeast of the player piece.
;;			   coordiantesSouthEast, holds coordinates of piece located southeast of player piece.
;;			   coordiantesSouthWest, holds coordinates of piece located southwest of player piece.
;; Algorithm: 
;;             1) Check if the player color is black or white.
;;			   2) Get pieces located forward of friendly piece.
;;			   3) Get coordinates of pieces located forward of friendly piece.
;;			   4) If places of forward coordinates are taken, piece cannot be moved so return empty list.
;;			   5) Get coordinates at location that will block opponent piece.
;;			   6) If piece can be moved forward, return list containing original location of piece, final location of piece, and direction.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun makeAttackDecision(board playerColor friendlyPiece)
	(cond (	(string= playerColor "B")
			(let* (	;; Valid direction to move northeast.
					(validNorthEast (validDirectionToMove board (list (- (first friendlyPiece) 1) (+ (first (rest friendlyPiece)) 1)) ))
					;; Valid direction to move northwest.
					(validNorthWest (validDirectionToMove board (list (- (first friendlyPiece) 1) (- (first (rest friendlyPiece)) 1)) ))
					;; Northeast coordinates.
					(coordinatesNorthEast (list (- (first friendlyPiece) 1) (+ (first (rest friendlyPiece)) 1)))
					;; Northwest coordinates
					(coordinatesNorthWest (list (- (first friendlyPiece) 1) (- (first (rest friendlyPiece)) 1))))

			;; Check if the final coordinate is able to moved to, if not return nil.
			(cond (	(AND (string/= validNorthEast "+") (string/= validNorthWest "+"))
					nil)
				  (
					;; Return original coordinate and final coordinate - else send nil.
					(cond (	(string= validNorthEast "+")
							(list friendlyPiece coordinatesNorthEast "northeast"))
						  (	(string= validNorthWest "+")
							(list friendlyPiece coordinatesNorthWest "northwest")))))))
		;; Computer is White.
		  (	(string= playerColor "W")
		  	(let* (	;; Valid direction to move southeast.
					(validSouthEast (validDirectionToMove board (list (+ (first friendlyPiece) 1) (+ (first (rest friendlyPiece)) 1)) ))
					;; Valid direction to move southwest.
					(validSouthWest (validDirectionToMove board (list (+ (first friendlyPiece) 1) (- (first (rest friendlyPiece)) 1)) ))
					;; Southeast coordinates.
					(coordinatesSouthEast (list (+ (first friendlyPiece) 1) (+ (first (rest friendlyPiece)) 1)))
					;; Southwest coordinates
					(coordinatesSouthWest (list (+ (first friendlyPiece) 1) (- (first (rest friendlyPiece)) 1))))

			;; Check if the final coordinate is able to moved to, if not return nil.
			(cond (	(AND (string/= validSouthEast "+") (string/= validSouthWest "+"))
					nil)
				  (
					;; Return original coordinate and final coordinate - else send nil.
					(cond (	(string= validSouthEast "+")
							(list friendlyPiece coordinatesSouthEast "southeast"))
						  (	(string= validSouthWest "+")
							(list friendlyPiece coordinatesSouthWest "southwest")))))))))

;; /* ********************************************************************* 
;; Function Name: playCapture 
;; Purpose: For the available list of pieces, check nearby coordiantes for pieces that can be captured. Return coordinate of piece to capture.
;; Parameters: 
;;			   board, game board.
;;			   playerColor, color of the player.
;;			   listOfPieces, list of available pieces.
;; Return Value: Coordinates of the piece to capture.
;; Local Variables: 
;;			   northWest, piece located northwest of the super piece.
;;			   northEast, piece located northeast of the super piece.
;;			   southWest, piece located southWest of the super piece.
;;			   southEast, piece located southeast of the super piece.
;; Algorithm: 
;;             1) Save coordinates of each available direction of the super piece.
;;			   2) If nearby coordinate can be captured, return coordinate.
;; Assistance Received: None.
;; ********************************************************************* */
(defun playCapture(board playerColor listOfPieces)
	(let* ( (northWest (validDirectionToMove board (list (- (first (first listOfPieces)) 1) (- (first (rest (first listOfPieces))) 1))))
			(northEast (validDirectionToMove board (list (- (first (first listOfPieces)) 1) (+ (first (rest (first listOfPieces))) 1))))
			(southWest (validDirectionToMove board (list (+ (first (first listOfPieces)) 1) (- (first (rest (first listOfPieces))) 1))))
			(southEast (validDirectionToMove board (list (+ (first (first listOfPieces)) 1) (+ (first (rest (first listOfPieces))) 1)))))
		  ;; Check to move NorthWest
	(cond (	(string=  northWest (getOppositePlayerColor playerColor))
		  	(list (first listOfPieces) (list (- (first (first listOfPieces)) 1) (- (first (rest (first listOfPieces))) 1)) "northwest"))
		  ;; Check to move NorthEast
		  (	(string=  northEast (getOppositePlayerColor playerColor))
		  	(list (first listOfPieces) (list (- (first (first listOfPieces)) 1) (+ (first (rest (first listOfPieces))) 1)) "northeast"))
		  ;; Check to move SouthWest
		  (	(string=  southWest (getOppositePlayerColor playerColor))
		  	(list (first listOfPieces) (list (+ (first (first listOfPieces)) 1) (- (first (rest (first listOfPieces))) 1)) "southwest"))
		  ;; Check to move SouthEast
		  (	(string=  southEast (getOppositePlayerColor playerColor))
		  	(list (first listOfPieces) (list (+ (first (first listOfPieces)) 1) (+ (first (rest (first listOfPieces))) 1)) "southeast"))
		  (	(not (eq (rest listOfPieces) nil))
		  	(playCapture board playerColor (rest listOfPieces)))
		  (t 
		  	()))))
		  
;; /* ********************************************************************* 
;; Function Name: checkCapture 
;; Purpose: Loops through list of available pieces and returns a list of super pieces.
;; Parameters: 
;;			   board, game board.
;;			   playerColor, color of the player.
;;			   listOfPieces, list of available pieces.
;; Return Value: List of coordinates that are super pieces.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) For each avilable piece, check if the available piece is a super piece. 
;;			   2) If piece is a super piece, return the list.
;;			   3) If there are not super pieces, return an empty list.
;; Assistance Received: None.
;; ********************************************************************* */
(defun checkCapture(board playerColor listOfPieces)
	;; No available super pieces.
	(cond (	(eq (first listOfPieces) nil)
			())
		;; Piece is a super piece.
		  (	(string= (validPieceToMove board (first listOfPieces)) (getSuperPieceForPlayerColor playerColor))
			(append (list (first listOfPieces)) (checkCapture board playerColor (rest listOfPieces))))
		;; Continue to check list of available pieces.
		  (t
			(checkCapture board playerColor (rest listOfPieces)))))

;; /* ********************************************************************* 
;; Function Name: playRetreat 
;; Purpose: Randomy moves piece backwards into retreat.
;; Parameters: 
;;			   board, game board.
;;			   playerColor, color of the player.
;;			   listOfPieces, list of available pieces.
;; Return Value: Coordinates of the piece to move backward.
;; Local Variables: 
;;			   coordinates, coordinates of piece to move forward.
;; Algorithm: 
;;             1) Randomy pick a piece and move it into retreat.
;; Assistance Received: None.
;; ********************************************************************* */
(defun playRetreat(board playerColor listOfPieces)
	;; Randomly pick a piece.
	(let* ( (coordinates (makeAttackDecision board (getOppositePlayerColor playerColor) (getRandomPiece listOfPieces (randomPiece listOfPieces)))))
		;; If piece cannnot move backward, try another piece.
		(cond (	(eq coordinates nil)
		 		(playRetreat board playerColor (rest listOfPieces)))
				;; Return coordinate of piece to move backward.
			  (t 
			   	coordinates))))

;; /* ********************************************************************* 
;; Function Name: checkRetreat 
;; Purpose: Loop through available pieces and check if each can piece can move forward. If none can move forward, then a piece must go in retreat.
;; Parameters: 
;;			   board, game board.
;;			   playerColor, color of the player.
;;			   listOfPieces, list of available pieces.
;; Return Value: Nil if pieces do not have to go into retreat. T if a piece must go into retreat.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) For each coordinate, check if piece can move forward.
;;			   2) If none of the pieces can move forward, then return T. This means that a piece must go in retreat.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun checkRetreat(board listOfPieces playerColor)
	;; If no pieces can go forward, do retreat.
	(cond (	(eq (first listOfPieces) nil)
			t)
			;; Check if piece can move forward.
		  (	(not (eq (makeAttackDecision board playerColor (first listOfPieces))  nil))
			nil)
			;; Check other pieces.
		  (t
			(checkRetreat board (rest listOfPieces) playerColor))))

;; /* ********************************************************************* 
;; Function Name: playAttack 
;; Purpose: Gets random coordinates from available list of pieces and then moves piece forward.
;; Parameters: 
;;			   board, game board.
;;			   playerColor, color of the player.
;;			   listOfPieces, list of available pieces.
;; Return Value: Coordinates of the piece to move forward.
;; Local Variables: 
;;			   coordinates, coordinates of piece to move forward.
;; Algorithm: 
;;             1) Get coordinate of random piece to move forward.
;;			   2) If piece can move forward, then return coordinate. Else pick another random piece to move forward.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun playAttack(board playerColor listOfPieces)
	;; Move random piece forward.
	(let* ( (coordinates (makeAttackDecision board playerColor (getRandomPiece listOfPieces (randomPiece listOfPieces)))))
		;; If piece cannot be moved forward, then recursively call function again to pick another random piece.
		(cond (	(eq coordinates nil)
		 		(playAttack board playerColor listOfPieces))
			  (t 
			   	coordinates))))

;; /* ********************************************************************* 
;; Function Name: displayDefense 
;; Purpose: Announces computer decision to play defensively by blocking a human piece.
;; Parameters: 
;;			   originalCoordinates, original coordinates of the piece.
;;			   finalCoordinates, final coordinates of the piece.
;;			   direction, direction that the piece is moving to.
;; Return Value: None.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) Announce that the computer will the original piece at a certain direction.
;;			   2) Announce the reason as well as the final coordinates.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun displayDefense (originalCoordinates finalCoordinates direction)
	(format t "The computer moved the piece at (~S,~S) ~A. ~%" (first originalCoordinates) (first (rest originalCoordinates)) direction)
	(format t "It wanted to block the human piece by moving the piece to (~S,~S). ~%" (first finalCoordinates) (first (rest finalCoordinates))))

;; /* ********************************************************************* 
;; Function Name: displayAttack 
;; Purpose: Announces computer decision to play offensively by advancing a piece.
;; Parameters: 
;;			   originalCoordinates, original coordinates of the piece.
;;			   finalCoordinates, final coordinates of the piece.
;;			   direction, direction that the piece is moving to.
;; Return Value: None.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) Announce that the computer will the original piece at a certain direction.
;;			   2) Announce the reason as well as the final coordinates.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun displayAttack (originalCoordinates finalCoordinates direction)
	(format t "The computer moved the piece at (~S,~S) ~A. ~%" (first originalCoordinates) (first (rest originalCoordinates)) direction)
	(format t "It wanted to advance the piece to (~S,~S). ~%" (first finalCoordinates) (first (rest finalCoordinates))))

;; /* ********************************************************************* 
;; Function Name: displayCapture 
;; Purpose: Announces computer decision to capture a piece.
;; Parameters: 
;;			   originalCoordinates, original coordinates of the piece.
;;			   finalCoordinates, final coordinates of the piece.
;;			   direction, direction that the piece is moving to.
;; Return Value: None.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) Announce that the computer will the original piece at a certain direction.
;;			   2) Announce the reason as well as the final coordinates.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun displayCapture (originalCoordinates finalCoordinates direction)
	(format t "The computer moved the piece at (~S,~S) ~A. ~%" (first originalCoordinates) (first (rest originalCoordinates)) direction)
	(format t "It wanted to capture the human piece at (~S,~S). ~%" (first finalCoordinates) (first (rest finalCoordinates))))

;; /* ********************************************************************* 
;; Function Name: displayRetreat 
;; Purpose: Announces computer decision to retreat a piece.
;; Parameters: 
;;			   originalCoordinates, original coordinates of the piece.
;;			   finalCoordinates, final coordinates of the piece.
;;			   direction, direction that the piece is moving to.
;; Return Value: None.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) Announce that the computer will the original piece at a certain direction.
;;			   2) Announce the reason as well as the final coordinates.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun displayRetreat (originalCoordinates finalCoordinates direction)
	(format t "The computer moved the piece at (~S,~S) ~A. ~%" (first originalCoordinates) (first (rest originalCoordinates)) direction)
	(format t "It wanted to retreat the piece to (~S,~S). ~%" (first finalCoordinates) (first (rest finalCoordinates))))

;; /* ********************************************************************* 
;; Function Name: displayHelpDefense 
;; Purpose: Announces the recommendation to human that they should play defensively by blocking a computer piece
;; Parameters: 
;;			   originalCoordinates, original coordinates of the piece.
;;			   finalCoordinates, final coordinates of the piece.
;;			   direction, direction that the piece is moving to.
;; Return Value: None.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) Announce that the computer will the original piece at a certain direction.
;;			   2) Announce the reason as well as the final coordinates.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun displayHelpDefense (originalCoordinates finalCoordinates direction)
	(format t "It is suggested to move the piece at (~S,~S) ~A. ~%" (first originalCoordinates) (first (rest originalCoordinates)) direction)
	(format t "This will block the computer piece by moving your piece to (~S,~S). ~%" (first finalCoordinates) (first (rest finalCoordinates))))

;; /* ********************************************************************* 
;; Function Name: displayHelpAttack 
;; Purpose: Announces the recommendation to human that they should play offensively by advancing their piece.
;; Parameters: 
;;			   originalCoordinates, original coordinates of the piece.
;;			   finalCoordinates, final coordinates of the piece.
;;			   direction, direction that the piece is moving to.
;; Return Value: None.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) Announce that the computer will the original piece at a certain direction.
;;			   2) Announce the reason as well as the final coordinates.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun displayHelpAttack (originalCoordinates finalCoordinates direction)
	(format t "It is suggested to move the piece at (~S,~S) ~A. ~%" (first originalCoordinates) (first (rest originalCoordinates)) direction)
	(format t "This will advance the piece to (~S,~S). ~%" (first finalCoordinates) (first (rest finalCoordinates))))

;; /* ********************************************************************* 
;; Function Name: displayHelpCapture 
;; Purpose: Announces the recommendation to human that they should capture a computer piece.
;; Parameters: 
;;			   originalCoordinates, original coordinates of the piece.
;;			   finalCoordinates, final coordinates of the piece.
;;			   direction, direction that the piece is moving to.
;; Return Value: None.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) Announce that the computer will the original piece at a certain direction.
;;			   2) Announce the reason as well as the final coordinates.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun displayHelpCapture (originalCoordinates finalCoordinates direction)
	(format t "It is suggested to move the piece at (~S,~S) ~A. ~%" (first originalCoordinates) (first (rest originalCoordinates)) direction)
	(format t "This will capture the computer piece at (~S,~S). ~%" (first finalCoordinates) (first (rest finalCoordinates))))

;; /* ********************************************************************* 
;; Function Name: displayHelpRetreat 
;; Purpose: Announces the recommendation to human that they should retreat.
;; Parameters: 
;;			   originalCoordinates, original coordinates of the piece.
;;			   finalCoordinates, final coordinates of the piece.
;;			   direction, direction that the piece is moving to.
;; Return Value: None.
;; Local Variables: 
;;			   None.
;; Algorithm: 
;;             1) Announce that the computer will the original piece at a certain direction.
;;			   2) Announce the reason as well as the final coordinates.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun displayHelpRetreat (originalCoordinates finalCoordinates direction)
	(format t "It is suggested to move the piece at (~S,~S) ~A. ~%" (first originalCoordinates) (first (rest originalCoordinates)) direction)
	(format t "This will retreat the piece to (~S,~S). ~%" (first finalCoordinates) (first (rest finalCoordinates))))

;; /* ********************************************************************* 
;; Function Name: playComputer 
;; Purpose: Holds logic containing decision-making of computer strategy.
;; Parameters: 
;;             players, players list containing players and their colors.
;;			   board, contains board object.
;;			   currentTurn, atom representing player turn.
;;			   scores, contains computer and human tournament scores.
;;			   playerColor, color of the player.
;;			   opponentColor, color of the opponent player.
;; Return Value: none.
;; Local Variables: 
;;             opponentCoordinates, list of coordinates of the closest opponent.
;;			   listOfPieces, list of computer pieces' coordinates.
;;		   	   blockEast, output containing decision-making to block opponent piece from east.
;;		   	   blockWest, output containing decision-making to block opponent piece from west.
;;			   shouldRetreat, T or nil notifying computer to retreat or not.
;;			   retreat, output containing decision-making to retreat.
;;			   shouldCapture, T or nil notifying computer to capture a piece or not.
;;		       capture, output containing decision-making to retreat.
;;			   attack, output containing decision-making to move forward.
;; Algorithm: 
;;             1) Load local variables for computer's decision making. 
;;			   2) Check if piece can block opponent.
;;			   3) Check if piece must retreat. If so, get retreat strategy.
;;			   4) Check if piece can capture. If so, get capture strategy.
;;			   5) Get position to move to if piece must be moved forward.
;;			   6) Once all variables loaded, do decision making strategy.
;;			   7) If computer can capture, then update board and end turn.
;;			   8) If computer can block piece from the east, then update board and end turn.
;;			   9) If computer can block piece from the west, then update board and end turn.
;;			   10) If computer must retreat, then update board and end turn.
;;			   11) If computer can move forward, then update board and end turn.
;; Assistance Received: none 
;; ********************************************************************* */
(defun playComputer (players board scores playerColor opponentColor)
	;; Get coordinates fo closest opponent.
	(let* ( 
		(opponentCoordinates 
			(cond ((string= opponentColor "W")
					(getClosestOpponent (rev (flatten board)) (length board) opponentColor 1))
					((string= opponentColor "B")
					(getClosestOpponent (flatten board) (length board) opponentColor 1))))
		;; List of computer pieces.
		(listOfPieces (getFriendlyPieces (flatten board) (length board) playerColor 1))
		
		;; Strategy: Check if can capture, then block, then retreat, then play forward.
		;; Coordinates either contain the piece to move, and the final destination. OR coordiantes contain NIL which means that piece should not be moved according to that strategy.

		;; Coordinates if piece will be moved to block piece on the east.
		(blockEast (playDefenseEast board opponentCoordinates playerColor))
		;; Coordinates if piece will be moved to block piece on the west.
		(blockWest (playDefenseWest board opponentCoordinates playerColor))
		;; Check if computer should retreat.
		(shouldRetreat (checkRetreat board listofPieces playerColor))
		;; Coordinates of piece to retreat.
		(retreat (cond ((eq shouldRetreat t) (playRetreat board playerColor listOfPieces)) (t ())))
		;; Check if computer should capture.
		(shouldCapture (checkCapture board playerColor listOfPieces))
		;; Coordiantes of piece to capture.
		(capture (cond ((not (eq shouldCapture nil)) (playCapture board playerColor shouldCapture)) (t ())))
		;; ;; Coordinates of forward advance.
		(attack (cond ((eq shouldRetreat nil) (playAttack board playerColor listOfPieces)) (t ()))))

		(cond 	
				;; Check to capture piece.
			  (	(AND (not (eq shouldCapture nil)) (not (eq capture nil)))
				(displayCapture (first capture) (first (rest capture)) (first (rest (rest capture))))
				(playRound players (updateBoard board (first capture) (first (rest capture)) (list (validPieceToMove board (first capture)))) 'human scores))
				
				;; Check to block piece from east.
			  (	(not (eq blockEast nil))
				(displayDefense (first blockEast) (first (rest blockEast)) (first (rest (rest blockEast))))
				(playRound players (updateBoard board (first blockEast) (first (rest blockEast)) (list (validPieceToMove board (first blockEast)))) 'human scores))
				
				;; Check to block piece from west.
			  (	(not (eq blockWest nil))
				(displayDefense (first blockWest) (first (rest blockWest)) (first (rest (rest blockWest))))
				(playRound players (updateBoard board (first blockWest) (first (rest blockWest)) (list (validPieceToMove board (first blockWest)))) 'human scores))
				
				;; Check to retreat.
			  (	(eq shouldRetreat t)
				(displayRetreat (first retreat) (first (rest retreat)) (first (rest (rest retreat))))
				(playRound players (updateBoard board (first retreat) (first (rest retreat)) (list (validPieceToMove board (first retreat)))) 'human scores))
				
				;; Play by moving forward.
			  (t
				(displayAttack (first attack) (first (rest attack)) (first (rest (rest attack))))
				(playRound players (updateBoard board (first attack) (first (rest attack)) (list (validPieceToMove board (first attack)))) 'human scores)))))

;; /* ********************************************************************* 
;; Function Name: playHelp 
;; Purpose: Logic for the round. Alternates each player for the turn and holds board state.
;; Parameters: 
;;             players, players list containing players and their colors.
;;			   board, contains board object.
;;			   currentTurn, atom representing player turn.
;;			   scores, contains computer and human tournament scores.
;;			   playerColor, color of the player.
;;			   opponentColor, color of the opponent player.
;;			   currentTurn, current player.
;; Return Value: none.
;; Local Variables: 
;;             opponentCoordinates, list of coordinates of the closest opponent.
;;			   listOfPieces, list of player pieces' coordinates.
;;		   	   blockEast, output containing decision-making to block opponent piece from east.
;;		   	   blockWest, output containing decision-making to block opponent piece from west.
;;			   shouldRetreat, T or nil notifying player to retreat or not.
;;			   retreat, output containing decision-making to retreat.
;;			   shouldCapture, T or nil notifying player to capture a piece or not.
;;		       capture, output containing decision-making to retreat.
;;			   attack, output containing decision-making to move forward.
;; Algorithm: 
;;             1) Get the coordinates fo the closest opponent.
;;			   2) Get a list of coordinates of player pieces.
;;			   3) Check if piece can block opponent.
;;			   3) Check if piece must retreat. If so, get retreat strategy.
;;			   4) Check if piece can capture. If so, get capture strategy.
;;			   5) Get position to move to if piece must be moved forward.
;;			   6) Once all variables loaded, do decision making strategy.
;;			   7) If player can capture, then update board and end turn.
;;			   8) If player can block piece from the east, then update board and end turn.
;;			   9) If player can block piece from the west, then update board and end turn.
;;			   10) If player must retreat, then update board and end turn.
;;			   11) If player can move forward, then update board and end turn.
;; Assistance Received: none 
;; ********************************************************************* */
(defun playHelp (players board scores playerColor opponentColor currentTurn)
	(let* ( 
		;; Coordinates of the closest opponent. Used for blocking opponent piece.
		(opponentCoordinates 
			(cond (	(string= opponentColor "W")
					(getClosestOpponent (rev (flatten board)) (length board) opponentColor 1))
				  (	(string= opponentColor "B")
					(getClosestOpponent (flatten board) (length board) opponentColor 1))))
		
		;; List of player pieces.
		(listOfPieces (getFriendlyPieces (flatten board) (length board) playerColor 1))

		;; Strategy: Check if can capture, then block, then retreat, then play forward.
		;; Coordinates either contain the piece to move, and the final destination. OR coordiantes contain NIL which means that piece should not be moved according to that strategy.

		;; Coordinates if piece will be moved to block piece on the east.
		(blockEast (playDefenseEast board opponentCoordinates playerColor))
		;; Coordinates if piece will be moved to block piece on the west.
		(blockWest (playDefenseWest board opponentCoordinates playerColor))
		;; Check if piece should be retreated.
		(shouldRetreat (checkRetreat board listofPieces playerColor))
		;; Coordinates of piece to retreat.
		(retreat (cond ((eq shouldRetreat t) (playRetreat board playerColor listOfPieces)) (t ())))
		;; Check if piece should be captured.
		(shouldCapture (checkCapture board playerColor listOfPieces))
		;; Coordinates of piece to capture.
		(capture (cond ((not (eq shouldCapture nil)) (playCapture board playerColor shouldCapture)) (t ())))
		;; Coordiantes of piece to move forward.
		(attack (cond ((eq shouldRetreat nil) (playAttack board playerColor listOfPieces)) (t ()))))

			;; Capture piece.
		(cond (	(AND (not (eq shouldCapture nil)) (not (eq capture nil)))
				(displayHelpCapture (first capture) (first (rest capture)) (first (rest (rest capture)))))
			;; Block from east.
			  (	(not (eq blockEast nil))
				(displayHelpDefense (first blockEast) (first (rest blockEast)) (first (rest (rest blockEast)))))
			;; Block from west.
			  (	(not (eq blockWest nil))
				(displayHelpDefense (first blockWest) (first (rest blockWest)) (first (rest (rest blockWest)))))
			;; Retreat.
			  (	(eq shouldRetreat t)
				(displayHelpRetreat (first retreat) (first (rest retreat)) (first (rest (rest retreat)))))
			;; Attack forward.
			  (t
				(displayHelpAttack (first attack) (first (rest attack)) (first (rest (rest attack)))))))	
	;; Return back to playRound logic.
	(playRound players board 'human scores))

;; /* *********************************************
;; Source Code for main round and tournament logic.
;; ********************************************* */

;; /* ********************************************************************* 
;; Function Name: playRound 
;; Purpose: Logic for the round. Alternates each player for the turn and holds board state.
;; Parameters: 
;;             players, players list containing players and their colors.
;;			   board, contains board object.
;;			   currentTurn, atom representing player turn.
;;			   scores, contains computer and human tournament scores.
;; Return Value: none.
;; Local Variables: 
;;             choice, user choice for the menu.
;;			   playerColor, current player's color.
;;			   opponentColor, opponent player's color.
;; Algorithm: 
;;             1) Announce current player.
;;			   2) Display the board.
;;			   4) Check if there is a winner (game condition has been met.)
;;			   5) Display menu.
;;			   6) Read input from user for menu choice.
;;			   7) If user selected to save game, then save game and quit.
;;			   8) If user selected to play game, then play game.
;;			   9) If user selected help mode, then call help function.
;;			   10) If user selected to quit, then quit game.
;; Assistance Received: none 
;; ********************************************************************* */
(defun playRound (players board currentTurn scores)
	;; Announce the current player. 
	(format t "It is ~A's turn. ~%" currentTurn)

	;; Display Board.
	(displayBoard board 0 (length board))
	
	;; Check if there is a winner.
	(cond 	((eq (checkwinner board) t)
				(let* ((roundScores (getWinner board players)))
					(tournamentControl roundScores scores))))
					
	;; Check if computer will quit. Computer quits if the points spread is >20.
	(cond (	(>= (abs (- (first (rest (rest (rest scores)))) (first (rest scores)))) 20)
			(format t "Computer quiting game. Deducting 5 points from computer for quiting. ~%")
			(announceTournamentScores 'human (first (rest (rest (rest scores)))))
			(announceTournamentScores 'computer (- (first (rest scores)) 5))
			(Quit)))
	
	;; Display Menu.
	(let*( 	(choice (readMenu currentTurn))
			(playerColor (getPlayerColor players currentTurn))
			(opponentColor (getOpponentColor players currentTurn)))

	;; Player chose to save game.
	(cond (	(string= (first choice) 'save)
			(saveToFile (readSaveFileName) players board currentTurn scores)
			(Quit))
	;; Player chose to play game.
		  (	(string= (first choice) 'play)
		  	;; Human is playing.
			(cond (	(string= currentTurn "HUMAN")
					(playHuman players board scores playerColor))
			;; Computer is playing.
				  (	(string= currentTurn "COMPUTER")
					(playComputer players board scores playerColor opponentColor))))		
	;; Player chose help mode.
		 (	(string= (first choice) 'help)
			(playHelp players board scores playerColor opponentColor currentTurn))
	;; Player chose to quit.
		 (	(string= (first choice) 'quit)
			(format t "Quiting game. Deducting 5 points for quiting. ~%")
			(announceTournamentScores 'human (- (first (rest (rest (rest scores)))) 5))
			(announceTournamentScores 'computer (first (rest scores))) 
			(Quit)))))

;; /* ********************************************************************* 
;; Function Name: loadGame 
;; Purpose: Starts round from a game file. Loads existing tournament.
;; Parameters: 
;;			   None.
;; Return Value: None.
;; Local Variables: 
;;			   fileName, name of game file to be read.
;;			   gameSave, contents of the game file.
;; Algorithm: 
;;             1) Read the name of the game file.
;;			   2) Parse file.
;;			   3) Start new round using game file.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun loadGame()
	(let* (	(fileName (readFileName))
			(gameSave (openFile fileName)))
			;; Start round from file save.
			(playRound (first gameSave) (first (rest gameSave)) (first (rest (rest gameSave))) (rest (rest (rest gameSave))))))

;; /* ********************************************************************* 
;; Function Name: initGame 
;; Purpose: Starts new tournament and game.
;; Parameters: 
;;			   None.
;; Return Value: None.
;; Local Variables: 
;;			   boardSize, the user-input for board size.
;;			   board, board list generated using board size.
;;			   players, holds players and their player color.
;; Algorithm: 
;;             1) Read the board size from user.
;;			   2) Generate the board.
;;			   3) Let the first player choose their player color.
;;			   4) Announce players and colors.
;;			   5) Call playRound function to play the round.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun initGame()
	(let* (	
		;; User is asked for board size at the start of round.
		(boardSize (readBoardSize))
		;; Creates board using n size.
		(board (makeBoard boardSize boardSize))
		;; Choose first player and board.
		(players (chooseColor (choosefirstPlayer))))
		;; Announce players and their colors.
		(format t "~A is ~A. ~%" (first players) (first (rest players)))
		(format t "~A is ~A. ~%" (first (rest (rest players))) (first (rest (rest (rest players)))))
		;; Play round.
		(playRound players board (first players) (list 'computer 0 'human 0 1))))

;; /* ********************************************************************* 
;; Function Name: newRound 
;; Purpose: Starts new round in the tournament.
;; Parameters: 
;;			   scores, tournament scores from overall game.
;;			   firstPlayer, winner of the last round.
;; Return Value: None.
;; Local Variables: 
;;			   boardSize, the user-input for board size.
;;			   board, board list generated using board size.
;;			   players, holds players and their player color.
;; Algorithm: 
;;             1) Read the board size from user.
;;			   2) Generate the board.
;;			   3) Let the first player choose their player color.
;;			   4) Announce players and colors.
;;			   5) Call playRound function to play the round.
;; Assistance Received: None.
;; ********************************************************************* */	
(defun newRound(scores firstPlayer)
	(let* (	
		;; User is asked for board size at the start of round.
		(boardSize (readBoardSize))
		;; Creates board using n size.
		(board (makeBoard boardSize boardSize))
		;; Create player object.	
		(players (cond ((string= firstPlayer "COMPUTER")
						(chooseColor (list 'computer)))
					   (t 
						(chooseColor (list 'human))))))
		
		;; Announce players and colors.
		(format t "~A is ~A. ~%" (first players) (first (rest players)))
		(format t "~A is ~A. ~%" (first (rest (rest players))) (first (rest (rest (rest players)))))
		;; Play round.
		(playRound players board firstPlayer scores)))

;; /* ********************************************************************* 
;; Function Name: startTournament 
;; Purpose: Starts entire kono tournament. Asks user to start new game or load from file.
;; Parameters: 
;;			   None.
;; Return Value: None.
;; Local Variables: 
;;			   fileChoice, either 'Y' or 'N' for whether game should be loaded from file
;; Algorithm: 
;;             1) Ask user if they want to load game from file.
;;			   2) If yes, then load game.
;;			   3) If no, start new game.
;; Assistance Received: None.
;; ********************************************************************* */
(defun startTournament ()
	;; Ask user for starting a new game or load a previous one from file.
	(let* ( (fileChoice (readPlayFromFile)))
		(cond (	(string= fileChoice "Y")
			 	(loadGame))
			  (	(string= fileChoice "N")
				(initGame)))))

(startTournament)