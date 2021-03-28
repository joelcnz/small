import std.stdio;
import std.string;
import std.array;
import std.algorithm;
//import std.conv;

void main() {
  dchar w_sonderzeichen= '\u20ac';    // Euro Zeichen
  writefln("w_sonderzeichen = %s ",w_sonderzeichen) ;

	auto names = 
			"Alef Bet Gimel Dalet He Vav Zayen Het Tet Yod Final_Kaf ".split ~
			"Kaf Lamed Final_Mem Mem Final_Nun Nun Samekh Ayin Final_Pe ".split ~
			"Pe Final_Tsadi Tsadi Qof Resh Shin Tav".split;

	names = names.map!( a => replace(a, "_", " ")).array;

	writeln(names.length, " Names");
	dchar start='\u05D0'; // Alef
	int i=0;
	version(all) {
		foreach (dchar letter; start .. start + cast(dchar)names.length) {
			stdout.writefln("%12s [%s] %s", names[i++], letter,  cast(int)letter - cast(int)start + 1);
		}
	}
	version(none) {
		writeln("א");
		foreach(dchar l; 'א'  .. 'ת' + cast(dchar)1)
			writeln(l);
	}
}

// And the iron rusts and the grass and bushes grow up around in and out of the machinary left for dead, yes, they were always dead from the beginning
