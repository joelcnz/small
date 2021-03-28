//Org: Vijay Nayar 17 8 11 d.D.learn
// Not compile!
import std.stdio;
import std.format;
import core.vararg;

void sprintf(ref string s, ...) {
    void putc(dchar c) {
        s ~= c;
    }
    std.format.doFormat(&putc, _arguments, _argptr);
}

void main() {
	writefln("My items are %(%sJoel%).", [30,4,79]); // ["Hi ", "Hello ", "Hey "]);
	
	writefln("%2$s %1$s %1$s", 1, 2); // Mine
	
    string testString, testString2;
    // Remember the format string:
    //   % - begins format
    //   0 - use leading '0's
    //   6 - we want 6 total chars printed (includes one for decimal)
    //   . - indicate precision (numbers after decimal)
    //   2 - do not show anything less than 1 cent
    sprintf(testString, "Your change %s is $%06.2f.", "Bob", 12.3456);
    // Output:  "Your change Bob is $012.35."
    writeln(testString);
    
    //sprintf(testString2, "Your change %2$s is $%1$s.", 12.3456, "Bob");
	//writeln(testString);

}
