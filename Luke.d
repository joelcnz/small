// moveu.d
import std.stdio: writeln;
import std.process: system;
import core.thread: Thread;
import std.datetime: dur;

string[] getInput(ref TextBool txtboo) {
	with(txtboo) {
		lines = [
		" Happy",
		"Birthday",
		"Luke! :-)"
		];
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

	while(! txtboo.doExecute) {
		lines = txtboo.getInput();
	}

	version(Windows)
		system("cls"); // need some thing else other than system
	else 
	system("clear");
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
		Thread.sleep(dur!"msecs"(450));
		version(Windows)
			system("cls");
		else system("clear");
	}
}
