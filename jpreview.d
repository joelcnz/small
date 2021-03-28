//#has a gap for some lists
//#add
//#new
//#unfinished
//#OS X
//#untested

/*
files:
jpreview.d
./jpreview
fingerbookmark.txt
previewbookmark.txt
bookmarks.txt
*/

import std.stdio; //: writeln, readln;
import std.string; //: strip, indexOf, chomp;
import std.file; //: dirEntries, SpanMode;
import std.algorithm;
import std.process;
import std.conv: to;
import std.array;

import arsdterminal, jmisc;

//extern(C) char* readline(const(char)* prompt);
//extern(C) void add_history(const(char)* prompt);

//pragma(lib, "readline");
//pragma(lib, "curses");

void main() {
	
	string[] list;
	
	auto files = dirEntries(".", SpanMode.shallow).
				filter!`endsWith(a.name,".d")`.
				array.
				sort!"a.toLower < b.toLower";

	foreach(string name; files) {
		list ~= name;
	}
	
	int fingerHold;
	try {
		fingerHold = "fingerbookmark.txt".readText.chomp.to!int;
	} catch(Exception e) {
		writeln("Fatal finger hold error: ", e.msg);
		return;
	}
	
	//char* rline;
	auto terminal = Terminal(ConsoleOutputType.linear);
	string input;
	bool done;
	int i;
	try {
		i = "previewbookmark.txt".readText.chomp.to!int;
	} catch(Exception e) {
		writeln("Fatal bookmark error: ", e.msg);
		return;
	}
	void saveBookMark() {
		File("previewbookmark.txt", "w").write(i);
	}
	scope(exit)
		saveBookMark;
	bool drawSoureFlag = true;
	do {
		auto fileName = list[i];
		if (drawSoureFlag == true) {
			import std.range: repeat;
			auto wing = '='.repeat(20);
			writeln('\n', wing, " (", i, ") ", fileName[2..$], ' ', wing);
			//writeln(fileName.readText);
			foreach(n, line; fileName.readText.split('\n'))
				writefln("[%03s] %s",n + 1, line);
			saveBookMark;
		}
		writeln("=== help 'h' - (", i, ") ", " fingerHold: ", fingerHold, " ", fileName[2..$], " Total: ", list.length); //#add bytes, , " bytes");
		write("D>"); stdout.flush; input = terminal.getline;
		writeln;
		string key;
		string[] args;
		if (input.length)
			key = input.split[0],
			args = input.split[1..$];
		
		drawSoureFlag = false;
		
		switch(key) {
			default:
				writeln(key, " - undefined key");
			break;
			case "h", "help":
				writeln("q - quit\n" ~
						"enter - next file\n" ~
						"'-' - previous file\n" ~
						"dmd - compile current code\n" ~
						"run - execuite current program\n" ~
						"rdmd - compile execute\n" ~
						"open - open current file in a editor\n" ~
						"vim - edit the source file (macOS)\n" ~
						"nano - another edit the source file (macO)\n" ~
						"ge - edit with Geany (Windows)\n" ~
						"skip/s #\n" ~
						"get (filename)\n" ~
						"schList (phrase) search lists all found\n" ~
						"sch (phrase) - search through file names\n" ~
						"add - bookmark\n" ~
						"ren (from) (to)\n" ~
						"bookmarks\n" ~
						"c - show current source file\n" ~
						"unittest\n" ~
						"ter - terminal input\n" ~
						"sav - save a finger\n" ~
						"showsav - show save finger\n" ~
						"delete - delete file\n" ~
						"mv (filename.d) - rename\n" ~
						"* - marked ones are WIP\n" ~
						"list (eg j*.d)\n" ~
						"cf - compile with jmisc");
			break;
			case "showsav":
				writeln("fingerHold number: ", fingerHold);
			break;
			case "cf":
				wait(spawnShell(format("./cf %s", fileName[2 .. $ - 2])));
			break;
			case "list":
				writeln("List:");
				string iFilter = input[5 .. $];
				string[] jfiles;
				foreach(string name; dirEntries(".", SpanMode.shallow).
					array.
					sort!"a.toLower < b.toLower") {
					if (wildMatch("./" ~ iFilter,  name)) {
						jfiles ~= name[2 .. $];
					}
				}
				alias jwrite = std.stdio.write;
				int columns = 6;
				done1: for(int i1; i1 < jfiles.length; i1 += columns) {
					for(int j; j < columns; j += 1) {
						if (i1 + j == jfiles.length)
							break done1;
						auto name = jfiles[i1 + j];
						jwrite(name, " ".replicate(name.length < 20 ? 20 - name.length : 0));
					}
					writeln;
				}
				writeln; //#has a gap for some lists
			break;
			case "delete":
				if (i + 1 < list.length)
					list = list[0 .. i] ~ list[i + 1 .. $];
				else
					list.length -= 1;
				remove(fileName);
				writeln("File: ", fileName, " removed!");
				drawSoureFlag = true;
			break;
			case "get":
				auto name = input[4..$];
				writeln('|', name, ".d|");

				int iq = -1;
				loop2: foreach(idx, s; list) {
					if (s[2..$ - 2] == name) {
						iq = i = cast(int)idx;
						drawSoureFlag = true;
						break loop2;
					}
				}
				
				if (iq == -1)
					writeln("Not found");
			break;
			case "sch":
				auto find = input[4 .. $];
				
				writeln;
				foreach(idx, s; list) {
					import std.array;
					string st = readText(s);
					if (st.indexOf(find) != -1) {
						i = cast(int)idx;
						immutable powerLine = "=".replicate(7);
						writeln(powerLine, " File: ", s[2 .. $], ' ', powerLine, "\n", readText(s));
						writeln;
					}
				}
			break;
			case "schList":
				auto find = input[8 .. $];
				foreach(idx, s; list)
					if (s.indexOf(find) != -1)
						writeln(idx, " - ", s[2..$]);
			break;
			case "unittest":
				wait(spawnShell(format("dmd -unittest -run %s", fileName[2..$-2])));
			break;
			case "sav":
			File("fingerbookmark.txt", "w").write(i);
				writeln("fingerbookmark saved at ",i);
				fingerHold  = i;
			break;
			case "c":
				if (input.length == 1 && input[0] == 'c') {
					drawSoureFlag = true;
				}
			break;
			case "ter":
				write("Terminal>"); stdout.flush; wait(spawnShell(readln.strip));
			break;
			case "bookmarks":
				writeln("List of book marks:");
				foreach(bkmk; File("bookmarks.txt").byLine)
					writeln(bkmk);
			break;
			case "mv":
				writeln("Do rename..");
				auto s = input.split; // split them up (s[1] s[2])
				if (s.length == 2 ) {
					wait(spawnShell(format("mv %s %s", list[i], s[1]))); //#OS X
					writeln(format("mv %s %s", list[i], s[1]));
					list[i] = fileName = s[1];
					writeln("Current name is changed ", " from", list[i], " to ", s[1]);
					list[i] = "./" ~ list[i];
					//list = list[0..i] ~ list[i + 1 .. $]; //#untested
					drawSoureFlag = true;
				}
			break;
			case "s":
				import std.conv: to;
				if (! args.length) {
					writeln("No oprends!");
					break;
				}
				i = args[0].to!int;
				drawSoureFlag = true;
			break;
			case "skip":
				import std.conv: to;
				if (! args.length) {
					writeln("No oprends!");
					break;
				}
				i = args[0].to!int;
				drawSoureFlag = true;
			break;
			case "dmd":
				wait(spawnShell("dmd " ~ fileName[2..$]));
			break;
			case "run":
				string str;
				str = args.join(" ");
				writeln(str);
				wait(spawnShell(fileName[0..$-2] ~ " " ~ str));
			break;
			case "rdmd":
				wait(spawnShell("rdmd " ~ fileName[2..$] ~ " " ~ args.join(" ")));
			break;
			case "open":
				wait(spawnShell("open " ~ fileName[2..$]));
			break;
			case "vim":
				writeln(`Editing file with vim \/`);
				wait(spawnShell("vim " ~ fileName[2..$]));
				writeln("Done with Vim editing..");
			break;
			case "nano":
				writeln(`Editing file with nano \/`);
				wait(spawnShell("nano " ~ fileName[2..$]));
				writeln("Done with Nano editing..");
			break;
			case "geany":
				writeln(`Editing file with Geany \/`);
				wait(spawnShell("ge " ~ fileName[2..$]));
				writeln("Done with Geany editing..");
			break;
			case "add":
				scope(exit) {
					writeln(fileName[2..$]," bookmark added to list.");
				}
				append("bookmarks.txt", fileName[2..$] ~ "\n");
			break;
			case "":
				if (i + 1 < list.length)
					i++;
				else
					writeln("You have reached the end of the known world!");
				drawSoureFlag = true;
			break;
			case "-":
				i--;
				drawSoureFlag = true;
			break;
			case "q":
				done = true; // see scope(exit) at top
			break;
		} // switch key		
	} while(! done);
}
