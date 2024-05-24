# PI!  
 > *Now in a memorization console game (with up to 10000 digits!)*
 > 
 > (Also, there's only a Windows version as of right now because I'm already tired)

You can build yourself a Linux version, idk (I didn't test to see if it works on it).

Inside pi_libraries/Makefile, change the LUASRCDIR variable to wherever the lua src files are on your computer. Then, from inside pi_libraries, execute `make all` and you're good to go.

You can also use Code::Blocks to compile everything (Idk why'd you do this, tho). The .cbp file is included. Just select the "all" target and build.
