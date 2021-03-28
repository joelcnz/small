// See http://forum.dlang.org/thread/sdtjcnqqmbozclaejtft@forum.dlang.org
//#here's the place we fix the problem
import std.array, std.stdio;

 void main () {
   // Converting to "array" borks the thing
   import std.algorithm : map;
   auto names = File("names.txt")
       .byLine!(char,char)(KeepTerminator.no, ',')
       .map!idup //#here's the place we fix the problem
       .array;
   
	names
		.map!((a) { a.writeln; return a; })
		.array;
 }
 
