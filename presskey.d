// From D.learn: 3 June 2012
import std.stdio;
import std.c.stdio;  // I'm just using this for the printf

extern (C) void _STI_conio(); // initializes DM access ton conin, conout
extern (C) void _STD_conio(); // properly closes handles
extern (C) int kbhit();       // the conio function is in the DMD library
extern (C) int getch();       // as is his friend getch

void main() {
  int mychar;
   _STI_conio();
   while(!kbhit())
   {}
   mychar = getch();
   printf("%c\n",mychar);
   _STD_conio();
   
   writeln(getKeyboardInputChar());
}

char getKeyboardInputChar() {
  int mychar;
   _STI_conio();
   scope(exit)
	   _STD_conio();
   while(!kbhit())
   {}
   mychar = getch();
   
   return cast(char)mychar;
}

/+
//Org found on stackoverflow - http://stackoverflow.com/questions/5372646/get-single-keystroke-in-d2-phobos
//#getch & 0xFF get number instead of character
import std.stdio : writefln;

//extern(C) int kbhit();
extern(C) int getch();

void main()
{
	writefln( "Press any key to continue." );
    //while(!kbhit())
    {
        // keep polling
        // might use Thread.Sleep here to avoid taxing the cpu.
    }

    writefln("Key hit was %S.", cast(char)getch); //#getch & 0xFF get number instead of character
}
+/
