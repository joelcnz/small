//#how does map work?
import std.stdio;
import std.algorithm: reduce, max, map;

//import anothermodule; //only with rdmd

//import jeca.all;

string echo(in string str) {
	return `writeln("` ~ str ~ `");` ~ str;  
}

void main() {
//	Init([""]);
//	Deinit;
	
	writeln( "Times on 1, 2, 3: ", reduce!"a*b"([1, 2, 3])); // fine, translates to 1 * 2 * 3

	string[2][] results;
	results ~= ["foo", ""];
	results ~= ["foobars", ""];
	results ~= ["foobar", ""];

	size_t len;
	foreach (res; results) {
		len = max(len, res[0].length);
	}
 
	//#how does map work?
	// a[0] -> "foo", "foobars" etc
// 	writeln( `reduce!max(map!"a[0].length"(results)): `, reduce!max(map!"a[0].length"(results)) );
	
	mixin(echo("writeln(reduce!max(map!`a[0].length`(results)));"));
 	
 //	len = reduce!`max(a, b[0].length)`(0, results); 
 	writeln( len );
 	
 	//#trying rdmd
// 	printFromAnotherModule;
}
