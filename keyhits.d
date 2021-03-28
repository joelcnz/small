//http://forum.dlang.org/thread/im8cnf$ioe$1@digitalmars.com?page=1
import std.stdio : writefln;

extern(C) int kbhit();
extern(C) int getch();

void main()
{
   while(!kbhit())
   {
       // keep polling
       // might use thread.sleep here.
   }

   writefln("Key hit was %s.", cast(char)getch());
}
