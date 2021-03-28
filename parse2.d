import std.stdio;
import std.string;
import std.conv;

int findNext(int start, string line) {
	int i = start;
	char c, last;
	while((start < line.length
		&& i < line.length) || line[i].isDigit 
}

string[] splitUp(string line) {
	// for the add numbers at the start
	string[] lines;
	char[] newl;
	while(line[i].isDigit() || line[i] == ' ') {
		newl ~= line[i];
		i++;
	}
	lines = newl.to!(int[])();
}

void main() {
	string line;
	string[] commands;
	while(true) {
		line = readln().strip();
		commands = line.splitUp();
	}
}
