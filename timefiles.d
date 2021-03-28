//Note: should have a back up folder for use in each run

//Code started: 1.2.12

import std.stdio;
import std.file;
import std.datetime;
import std.range;
import std.algorithm;
import std.path;

/+
c:\jpro\dpro2\small\
a.d
b.d
d.d
g:\crate
a.d
b.d
c.d
d.d

c:\jpro\dpro2\small>timefile g:\crate
+/

struct StrTime {
	string name;
	SysTime time;
}

void main(string[] args) {
	if (args.length == 1 || !args[1].exists) { // exists includes folders
		writeln(`eg. 'timefiles g:\crate' to test and 'timefiles g:\crate -commit' to do`);
		return;
	}
	bool commit = false;
	if (args.length > 2 && args[2] == "-commit")
		commit = true; // up goes the commit flag
	auto flashFiles = getFiles(args[1]);
	StrTime[] hddFiles;
	// checks each file in the flash drive against each file on the current folder on the HDD, if the same name then add to HDD list
	// checks each file in the flash files to see if there's file of the same name in the HDD, and if so then add to the HDD list
	foreach(file; flashFiles) {
		if (exists(basename(file.name)))
			hddFiles ~= StrTime(basename(file.name), timeLastModified(basename(file.name))); // current file
	}
	writeln("flash:");
	display(flashFiles);
	writeln("\nhdd:");
	display(hddFiles);
	StrTime[] hddFilesChanged, flashFilesChanged;
	foreach(flash; flashFiles)
		foreach(hdd; hddFiles) {
			if (hdd.name == basename(flash.name)) {
				if (timeLastModified(hdd.name) > timeLastModified(flash.name, SysTime.min)) {
					if (commit == true)
						copy(hdd.name, flash.name);
					flashFilesChanged ~= flash;
				//} else if (timeLastModified(hdd.name, SysTime.min) < timeLastModified(flash.name)) {
				} else if (timeLastModified(flash.name, SysTime.min) < timeLastModified(hdd.name)) {
					if (commit == true)
						copy(flash.name, hdd.name);
					hddFilesChanged ~= hdd;
				}
			}
		}
	writeln(commit ? "\nChanged in flash drive:" : "\nWould be changed in flash drive:");
	display(flashFilesChanged);
	writeln(commit ? "\nChanged in hdd:" : "\nWould be changed in hdd:");
	display(hddFilesChanged);
	writeln();
}

void display(StrTime[] files) {
	foreach(file; files)
		writefln("%-20s (%s)", file.name, file.time);
}

StrTime[] getFiles(string path) {
	StrTime[] files;
	foreach(file; dirEntries(path,"*.{d,txt}",SpanMode.shallow)) {
		if (basename(file.name)[0] != '.') // horrible file names
			files ~= StrTime(file.name, timeLastModified(file.name));
	}
	return files;
}
