Web App that tries to solve the game of Solitaire

My playground is a program which tries to solve the classic game of Solitaire using a Genetic Algorithm.

The rules of the game are as follows : The game begins with all dots placed on the board except the one in the middle. A move is made by taking a pawn, jumping over one of his neighbours and landing on an empty cell. The purpose is to play until only one pawn is remaining.

The algorithm that I use works like this : A population is created, each game is played in order to compute its "Fitness" (the number of moves that it was possible to make until the board was blocked). The playground then display s then the final position of the best game of the population.

The next generation is then created using biological ideas like "mating pool", "crossing-over" and even "mutation". To increase the diversity of the game, some stranger games are then added to the population. Some parameters can be adjusted using the sliders.

The following color code is used : A dark-blue cell means an empty one and, on the opposite, light-blue means occupied. A yellow one is a cell that could have made a move but the board was blocked. The red color indicates the starting cell of the last move, and the green color marks where it landed.


<img src="https://github.com/ArnaudPannatier/Solitaire-Playground/blob/master/img/capture.png" width="400">
