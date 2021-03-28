extern(C) char* readline(const(char)* prompt);
extern(C) void add_history(const(char)* prompt);

pragma(lib, "readline");
pragma(lib, "curses");

void main() {
    import std.stdio, std.conv;
	import std.string;
	char* line;
	string dline;
	while(dline != "q") {
        line = readline("your line: ");
		dline = line.to!string;
		
		if (dline.length) {
	    	writeln(dline);
			add_history(line);
		}
	}
}

/+
import terminal;

void main() {
    auto terminal = Terminal(ConsoleOutputType.linear);
    auto line = terminal.getline("your prompt: ");
    terminal.writeln("You wrote: ", line);
}
+/