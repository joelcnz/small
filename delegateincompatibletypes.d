import std.stdio;
import std.string;
import std.conv;

void main() {
	
	string doToUpper( string t ) pure {
		return t.toUpper;
	}
	
	string addStartNum( string t, int n ) pure {
		return "start-" ~ t ~ n.to!string;
	}
	
	auto s = [ "first", "last" ];
	foreach( i, p; [
		(string t) { return doToUpper( t ); },
		(string t) { return addStartNum(t, 32); } ] )
		  writeln( p(s[i]) );
}
