//19 Oct 2012 - What about stuff like 'lt50', though it's not adding any task stuff
//#a hack
/+
eg.
Change:
32 st"8 30 0" c"got up this time a third time in a row."

to:
32
st"8 30 0"
c"got up this time a third time in a row."
+/
import std.stdio;
import std.string;
import std.file;
import std.ascii;

//version = DUnit;

version(DUnit)
	import dunit;


version(DUnit) {
	void main() {
		dunit.runTests_Tree();
	}
} else {
	void main() {
	//	writeln("Note: The angle brackets are added.");
		foreach(char[] line; File("jtaskconv.txt","r").byLine)
			foreach(seg; separateCommands(line.idup))
				//writeln('<', seg, '>');
				writeln(seg);
	}
}

version(DUnit)
class Test {
	mixin TestMixin;
	
	void _test1() {
		foreach(char[] line; File("jtaskconv.txt","r").byLine)
			foreach(seg; separateCommands(line.idup))
				writeln('<', seg, '>');
	}
	
	void _test2() {
		foreach(line; `56 c"cat house"|lt10 c"hey man"|v c"dog kennel" 30 c"What is thirty?" 20 v`.split("|"))
			foreach(seg; separateCommands(line))
				writeln('<', seg, '>');
	}
	void test3() {
		string test =
			`20\`
			`c"I went for a walk" st"12 0 0"`;
		foreach(line; test.split(`\`))
			foreach(seg; separateCommands(line))
				writeln('<', seg, '>');			
	}
}

	//Maybe more line.lengths evaluations that are ever true
	string[] separateCommands(string line) {
		line ~= " "; //#a hack
		
		enum Switch {alphaNum, space, quote};
		
		string[] result;
		string command;
		Switch sw = Switch.alphaNum;
		bool done = false;
		int st = 0, ed = 0;
		char c;
		while(! done) {
			if (ed == line.length)
				break;
			c = line[ed];
			with(Switch)
				final switch(sw) {
					case alphaNum:
						if (c == '"') {
							sw = Switch.quote;
							ed++;
						} else
							if (ed == line.length || ! c.isAlphaNum() || c == ' ') {
								result ~= line[st .. ed];
								st = ed + 1;
								
								if (ed == line.length)
									done = true;
								else
									if (c == ' ')
										sw = Switch.space;
							}
							else
								ed++;
					break;
					case space:
						if (ed == line.length)
							break;
						if (c.isAlphaNum() || c == '"')
							st = ed,
							sw = Switch.alphaNum;
						ed++;
					break;
					case quote:
						if (c == '"' || ed == line.length) {
							if (ed < line.length)
								result ~= line[st .. ed + 1],
								st = ed + 1,
								sw = Switch.space;
						version(none) {// does not reach
							if (1==2) {}  // dummy
							else
								writeln("Warning: no ending quote"),
								result ~= line[st .. $] ~ `"`,
								done = true;
						} // version
						}
						ed++;
					break;
				}
		}
		
		return result;
	}

/+
# - task number character
S - statement
' ' - gap
58 c"working on jtask code reference"
## SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

c"It's a messy busnes."
SSSSSSSSSSSSSSSSSSSSSSS

24 sd"30 9 2012" st"8 30 0"
## SSSSSSSSSSSSS SSSSSSSSSS ?
 
32
 +/

/+
string[] separateCommands(string str) {
	debug
		writeln("\nIn separateCommands function: str = <", str, '>');
	string[] result;
	bool inKey = true, tNumber = true; // tNumber = task Number
	string seg;
	foreach(i, c; str) {
		debug
			writeln("in foreach loop:");
		// turn off task number gathering if at the start of the line, it is on, and it's not a number
		if (i == 0 && tNumber && ! c.isDigit) {
			debug
				writeln("turning task number gathering off");
			tNumber = false;
		}
		// if task number switch is on
		if (tNumber) {
			debug
				writeln("in task number gathering");
			// if character is a space or is the letter is at the last position then turn off task number switch
			// else gather character
			if (! c.isDigit || i == str.length - 1) {
				debug
					writeln("turning off task number gathering.");
				tNumber = false;
				if (seg.length)
					result ~= seg ~ (c.isDigit ? c ~ "" : ""),
					seg.length = 0;
			}
			else {
				seg ~= c;
				debug
					writeln("Add character: ", c);
			}
		} else {
			if (inKey) { // in key
				if (c != ' ')
					seg ~= c;
				if (c == '"')
					inKey = false;
			} else { // in data
				seg ~= c;
				if (c == '"')
					result ~= seg,
					seg.length = 0,
					inKey = true,
					tNumber = true;
			}
		}
	}
	debug
		writeln("Leaving separateCommands: result = ", result);

	return result;
}
+/
