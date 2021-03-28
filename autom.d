// 29 3 2017
// Use: https://ideone.com/77f3tL
void main() {
	import std.stdio, std.conv, std.string, std.range;
 
 	writeln("Welcome to draw and quit:");
	bool done = false;
	do {
		immutable s = readln;
		if (s.strip != "") {
			switch(s.split[0]) {
				default: writeln(s.chomp); break;
				case "draw":
					if (s.split.length <= 1) {
						writeln("Invalid. Eg. 'draw box 3 3', or 'draw line 40'");
						break;
					}
					switch(s.split[1]) {
						default:
							writeln("Invalid. Eg. 'draw box 3 3', or 'draw line 40'");
						break;
						case "box":
							if (s.split.length != 4) {
								writeln("Invalid input");
								break;	
							}
							try {
								foreach(y; 0 .. s.split[3].to!int)
									writeln("#".replicate(s.split[2].to!int));
							} catch(Exception e) {
								writeln("Invalid input");
							}
						break;
						case "line":
						if (s.split.length != 3) {
							writeln("Invalid input");
							break;	
						}
						try {
							writeln("#".replicate(s.split[2].to!int));
						} catch(Exception e) {
							writeln("Invalid input");
						}
						break;
					}
				break;
				case "quit":
					done = true;
				break;
			}
		} else {
			writeln("Invalid input..");
		}
	} while(! done);
}
