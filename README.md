# PI!  
 > *Now in a memorization console game (with up to 10000 digits!)*
 > 
 > (Also, there's only a Windows version as of right now 🤷)

You can build yourself a Linux version, idk (I didn't test to see if the game works on it).

### How to build?

Inside `pi_libraries/Makefile`, change the `LUASRCDIR` variable to wherever the Lua src files are on your computer.  
On Windows, you need to manually make the `bin` and `obj` directories inside of `pi_libraries`.
Then, from `pi_libraries`, execute `make all` and you're good to go.

You can also use Code::Blocks to compile everything (Idk why'd you do this, tho).  
The .cbp file is included. So, just select the "all" target and build.
