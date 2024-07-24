#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "exports.h"
#define BUFFER_SIZE 4096


#ifdef __linux__
#	include <termios.h>
#	include <unistd.h>
static int getch(void)
{
	struct termios oldattr, newattr;
	int ch;
	tcgetattr( STDIN_FILENO, &oldattr );
	newattr = oldattr;
	newattr.c_lflag &= ~( ICANON | ECHO | ISIG);
	tcsetattr( STDIN_FILENO, TCSANOW, &newattr );
	ch = getchar();
	tcsetattr( STDIN_FILENO, TCSANOW, &oldattr );
	return ch;
}
#elif _WIN64
#	include <wchar.h>
#	include <windows.h>
#endif


int getInput(lua_State *L)
{
	char *input=malloc(sizeof(char)*BUFFER_SIZE);
	int len = 0;
#ifdef _WIN32
	fgets(input, BUFFER_SIZE, stdin);
	len = strlen(input)-1;
#else
	char chs[16] = {};
	int sel = 0;
	while (len<BUFFER_SIZE) {
		chs[0]=getch();
		switch (chs[0]) {
		case 27:
			int ch_index=3;
			chs[1]=getch();
			chs[2]=getch();
			if (chs[1]=='[') {
				TRYAGAIN:
				switch (chs[2]) {
				case 'A': case 'B': break;
				case 'C': if (sel<len) {
					if (chs[5]=='5') {
						int ntomv = 1;
						input[len]=0;
						while (!(input[sel+ntomv]==' '||ntomv+sel==len)) ntomv++;
						sel+=ntomv;
						printf("\x1b[%dC", ntomv);
						break;
					}
					sel++;
					printf("\x1b[C");
					} break;
				case 'D': if (sel>0) {
					if (chs[5]=='5') {
						int ntomv = 1;
						input[len]=0;
						while (!(input[sel-ntomv]==' '||sel-ntomv==0)) ntomv++;
						sel-=ntomv;
						printf("\x1b[%dD", ntomv);
						break;
					}
					sel--;
					printf("\x1b[D");
					} break;
				case 'H': if (sel>0) {
					printf("\x1b[%dD", sel);
					sel=0;
					} break;
				case 'F': if (sel<len) {
					printf("\x1b[%dC", len-sel);
					sel=len;
					} break;
				case '~': if (chs[3]=='3') {
					if (sel==len||len==0) break;
					if (chs[5]=='5') {
						int chrmvd = 1;
						while (!(input[sel+chrmvd]==' '||sel+chrmvd==len)) chrmvd++;
						len-=chrmvd;
						memcpy(input+sel, input+sel+chrmvd, len-sel);
						input[len]=0;
						if (sel) printf("\x1b[%dD", sel);
						printf("%s",input);
						for (int i=0; i<=chrmvd; i++) printf(" ");
						printf("\x1b[%dD", len-sel+chrmvd+1);
						break;
					}
					len--;
					memcpy(input+sel, input+sel+1, len-sel);
					input[len]=0;
					if (sel) printf("\x1b[%dD", sel);
					printf("%s ",input);
					printf("\x1b[%dD", len-sel+1);
					} break;
				default:
					chs[ch_index++]=chs[2];
					chs[2]=getch();
					goto TRYAGAIN;
				}
			}
			for (int i=0; i<16; i++) chs[i]=0;
			break;
		case 3: printf("\n"); exit(0);
		case 8: 
			if (sel==0||len==0) break;
			int chrmvd = 1;
			while (!(input[sel-chrmvd]==' '||sel-chrmvd==0)) chrmvd++;
			len-=chrmvd;
			if (sel<=len) memcpy(input+sel-chrmvd, input+sel, len-sel+1);
			input[len]=0;
			if (sel) printf("\x1b[%dD", sel);
			sel-=chrmvd;
			printf("%s",input);
			for (int i=0; i<=chrmvd; i++) printf(" ");
			printf("\x1b[%dD", len-sel+chrmvd+1);
			break;
		case 127:
			if (sel==0||len==0) break;
			len--;
			if (sel<=len) memcpy(input+sel-1, input+sel, len-sel+1);
			input[len]=0;
			printf("\x1b[%dD", sel--);
			printf("%s ",input);
			printf("\x1b[%dD", len-sel+1);
			break;
		case '\n': 
			printf("\n");
			goto EXIT_LOOP;
			break;
		default:
			if (chs[0]<31) break;
			if (len>0&&sel<len) {
				if (sel) printf("\x1b[%dD", sel);
				memcpy(input+sel+1, input+sel, len++-sel);
				input[len]=0;
				input[sel]=chs[0];
				printf("%s ",input);
				printf("\x1b[%dD", len-sel);
				sel++;
				break;
			}
			printf("%c",chs[0]);
			input[sel]=chs[0];
			sel++;
			len++;
			break;
		}
	}
	EXIT_LOOP:
#endif
	input=realloc(input, sizeof(char)*(len+1));
	input[len]=0;
	lua_pushstring(L, input);
	return 1;
}

int luaopen_getUserInput(lua_State *L)
{
	lua_pushcfunction(L, getInput);
	return 1;
}
