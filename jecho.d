//#executeShell(line); does nothing!
//#I don't think this would work!
//#should collect the program folders with isDir and stuff

import std.stdio;
import std.string;
import std.range;
import std.conv;
import std.file;
import std.path;
import std.process;

alias join = std.string.join;

void jwriteln(U...)(U args) {
	string result;

	foreach(a; args) {
		result ~= to!string(a);
	}

	actions ~= result;

	if (replay)
		writeln(result);
}

bool replay;
string[] replayLines;
string[] actions;

void main() {
	writeln("Welcome to JECho prompt\nHit [H] then hit [enter] for help");

	bool done;
	while(! done) {
		string line;
		
		if (replay) {
			if (! replayLines.empty) {
				line = replayLines.front;
				replayLines.popFront();
			} else {
				replay = false;
			}
		}
		else
			line = chomp(readln());
		string[] segs = line.split;

		jwriteln(line);
		if (!segs.empty) {
			switch(segs[0]) {
				case "h", "H":
					writeln("exit/q/quit - to exit program");
					writeln("replay");
					writeln("run <arguments>");
				break;
				default:
					//executeShell(line); //#executeShell(line); does nothing!
					//system(line);
					wait(spawnShell(line));
				break;
				case "replay":
					actions.popBack();

					replayLines.length = 0;
					string fileName = "jechoScript.txt";
					if (segs.length > 1)
						fileName = segs[1];
					foreach(fline; File(fileName, "r").byLine())
						replayLines ~= fline.to!string;
					replay = true;
				break;
				case "exit", "q", "quit":
					writeln("Have a good day..");
					File("jechoScript.txt", "w").write(actions.join("\n"));
					done = true;
				break;
				case "cd":
					if (segs.length > 1 && exists(segs[1]) && isDir(segs[1])) {
						chdir(segs[1]);
						writeln(segs[1]);
					} else {
						writeln(segs[1] ~ " directory not found");
					}
				break;
				case "run":
					if (segs.length > 1) {
						bool notFound = true;
						
						// check in bin\Debug folders
						foreach(check; "Balliters Pops Abc5 BibleGate VersePrompt".split) { //#should collect the program folders with isDir and stuff
							string path = buildPath("..",check,"bin","Debug");
							version(Windows) {
								string pre = "";
								string ext = ".exe";
							}
							version(OSX) {
								string pre = "./";
								string ext = "";
							}
							if (exists(buildPath(path, segs[1]~ext))) {
								notFound = false;
								chdir(path);
								//system(pre~segs[1]);
								wait(spawnShell(pre~segs[1]));
								chdir(buildPath("..".repeat(3).array ~ "small")); //#I don't think this would work!
								writeln("Welcome back to JECho.");
							}
						}
						
						if (notFound) {
							writeln("The program you seek, does not exist!");
						}
					}
				break;
			}
		}
	}
}
