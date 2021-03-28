// Not working
// Org. › digitalmars.D.learn
// » std.array oddness
//#I don't know what this extra stuff is for?
import std.array, std.stdio;

 void main () {
   // Converting to "array" borks the thing
   import std.algorithm : map;
   auto names = File("names.txt")
//       .byLine!(char,char)(KeepTerminator.no, ',') //#I don't know what this extra stuff is for?
		.byLine
		.map!idup;

   foreach (i, name; names.array)
	   writeln(i, " - ", name);
 }
 
