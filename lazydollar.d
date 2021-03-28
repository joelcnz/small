//Org: a Turkish D book "D Programlama Dili"
//#note here
import std.stdio;
import std.random;

void printHello ( in  int number, lazy const  char [] greetings)
{
    foreach (i; 0 .. number) {
        writeln (greetings, " world!" );
    }
}

string someSuch()
{
    string [] greetings =
        [ "Hello" , "Hi" , "Good morning" , "Good evening" ];
	 //#note here
     return greetings [uniform (0 ,$)];
}

void main ()
{
    printHello (5, someSuch());
}
