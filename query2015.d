// 31 12 2014 - 1 1 2015 Well now it's 2015 and I can't fix my program. I'll go to Windows and play Battle Zone. I didn't win in that game either. I came second in Need for Speed Hot pursuit 2. Couldn't get Descent 2 to work on OS X Virtual Box, played a bit of Screamer though. I made it in a cone race, just, previously I didn't quite make it.
struct ToDo {
	string label;
	int timeMinutes;
	
 	string toString() const {
		import std.string;
		return format("%s - %s", timeMinutes, label);
	}
 }
 
 void main() {
	 ToDo[] todos;
	 auto rawData = "Shower|15|Battle Zone|30|Descent|20|Descent II|20|Free Online D book|30";

	import std.stdio;
	import std.string;
	writeln("Enter eg. 'Battle Zone|30' label and time in minutes:");
	rawData ~= "|" ~ readln.chomp;

	 import std.string;
	 auto data = rawData.split("|");
	 
	 import std.range;
	 import std.conv;
	 foreach1: foreach(i; iota(0, data.length, 2)) {
		 int line;
		 try {
			 if (data.length % 2 != 0) { line = __LINE__;
				 throw new Exception("Uneven number of operants!");
			 }
			 line = __LINE__; todos ~= ToDo(data[i], data[i+1].to!int);
		 } catch(Exception e) {
			 writeln("Error in line: ", line, " Exception ", e.toString);
			 todos ~= ToDo(data[i], -1);
			 break foreach1;
		 }
	 }
	 
	 import std.stdio;
	 writeln("Time in minutes, and thing to for the duration of that time \\/");
	 foreach(todo; todos) {
		 writeln(todo);
	 }
 }
 