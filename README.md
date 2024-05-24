# PI!  
 > *Now in a memorization console game (with up to 10000 digits!)*
 > 
 > (Also, there's only a Windows version as of right now because I'm already tired)

You can build yourself a linux version, idk (I didn't test to see if it works on linux).

Just make lua/Makefile and compile the .c files inside pi_libraries into DLLs.  
Place the lua executable and lua54.dll you get from the Makefile inside the main folder, and the compiled DLLs inside the pi_libraries/bin folder (I think. [Idk, I don't use linux]).
