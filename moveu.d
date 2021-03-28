// moveu.d
import std.stdio;
import std.process;
import core.thread;
import std.string;
import std.conv;

string[] getInput(ref TextBool txtboo) {
	with(txtboo) {
		doExecute = false;
	try {
		lines ~= readln()[0..$-1];
	} catch(Exception e) {
		writeln("That wont do!");
		lines = [];
	}

	if (lines[$-1] == "e" || lines[$-1] == "execute")
		lines = lines[0..$-1],
		doExecute = true;
	} // with

	return txtboo.lines;
}

struct TextBool {
	string[] lines;
	bool doExecute;
}

void main() {
	string[] lines;
	TextBool txtboo;
	writeln("Enter textual lines ready for animation involving it (execute to begin).");
	while(! txtboo.doExecute) {
		lines = txtboo.getInput();
	}

	system("clear"); // need some thing else other than system
	int yoff;
	bool down = true; // true going down
	while(true) {
		foreach(s; 0 .. yoff)
			writeln();
		foreach(ln; lines[0 .. $ - yoff]) {
			writeln(ln);
		}
		if (down) {
			yoff++;
			if (yoff == lines.length)
				down = false;
		} else 
		if (! down) {
			yoff--;
			if (yoff == 0)
				down = true;
		}
		Thread.sleep(dur!"msecs"(200));
		//executeShell("clear");	
		//system("clear");
		foreach(l; 0 .. 140)
			writeln();
	}
}
