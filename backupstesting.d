import std.stdio;
import std.file;

import jmisc;

void main(string[] args) {
	foreach(c; 0 .. 11)
		jm_backUp("path/backups.d");
}
