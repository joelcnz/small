//http://forum.dlang.org/search?q=threadmd5%3A9d580b4543a5f4f560554198c14dac03&search=Search
//#not work
import std.stdio;
import std.datetime;

void main() {
	StopWatch sw;
	sw.start;
	writeln("> Query took ", sw.peek()); //#not work
}
