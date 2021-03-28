#!rdmd
//shebang not seem to work in OSX anyway
//See: http://forum.dlang.org/thread/uygomtzokcmxsmjdwfng@forum.dlang.org

import std.stdio, std.typetuple;
import std.typecons;

auto saveAll(Stuff...)(Stuff stuff) {
     Stuff ret = stuff;
     foreach(ref v; ret)
		 static if (is(typeof(ret[0]) == string))
			 v ~= " - string";
	 	else
        	 ++v;

     return tuple(ret);
}


void foo(Stuff...)(Stuff stuff) {
     bar(stuff.saveAll.expand); // process and bar for print out
}

void bar(Stuff...)(Stuff stuff) {
     foreach (v; stuff)
         v.writeln;
}

void main() {
	foreach (T; TypeTuple!(int, string, bool, int)) {
		write( typeid( T ) );
		T val;
		static if ( is( T : int ) && !is(T : bool) ) {
			val = 3 + 7;
			writeln( " eg. 3 + 7 = ", val );
		} else
		static if ( is( T == bool ) ) {
			val = false;
			writeln( " eg. old = ", val );
		} else
		static if ( is( T == string ) ) {
			val = "Have a nice day";
			writeln( ` eg. var  = "Have a nice day"; - "`, val, `"` );
		}
	}

	writeln();
	foreach(V; tuple(0, false, "nop"))
		writeln(typeof(V).stringof, " - ", V);

     foo(1, 3, 5);
	 foo("1","3","5");
}
