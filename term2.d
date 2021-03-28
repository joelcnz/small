import terminal;

void main() {
    import std.stdio, std.conv;
	import std.string;
	auto terminal = Terminal(ConsoleOutputType.linear);
	string line;
	while(line != "q") {
        line = terminal.getline("your prompt ('q' to quit): ");
    	writeln("\n" ~ line);
	}
}
