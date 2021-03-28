import std.stdio: writeln, readln, File;
import std.conv: to, text;
import std.string: format, chomp, split, strip;
import std.algorithm: sort, map, filter;
import std.range: array, iota;
import std.file: dirEntries, SpanMode, slurp;

struct Person {
	string name;
	int age;
	
	string toString() const {
		import std.string: format;
		return format("Name: %10s, Age: %s", name, age);
	}
}

void main() {
	string input;
	Person[] ppl;
	string[] words;
	writeln;
	writeln("~= Welcome to Input Sort =~");
	writeln;
	do {
		writeln("Enter 'h' for help");
		
		words = readln.chomp.split;
		if (words.length) {
			input = words[0];
		} else {
			input = "h";
		}
		
		if (input == "h") {
			writeln("q - quit program,\n" ~
					"add - enter ex 'add Joel 35 Lahtrell 4'\n" ~
					"s - show\n" ~
					"sort ([as]sending or [de]scending) and with (name, length, or age)\n" ~
					"clear\n" ~
					"cat\n" ~
					"load (filename) - append\n" ~
					"save (filename)\n" ~
					"wipe #.. (even more than one)");
		}
		
		if (input == "wipe") {
			bool notItemCount() { return ppl.length == 0; }
			if (notItemCount) {
				writeln("No items to wipe!");
				continue;
			}
			int index;
			ppl.
			map!((a) {
				writeln(index++, '-', a);

				return a;
			}).
			array;
			
			try {

				auto sel = readln.strip;
				foreach_reverse(i; 0 .. ppl.length) {
					second: foreach(num; sel.split.to!(int[]))
						if (num == i) {
							ppl = ppl[0 .. i] ~ ppl[i + 1 .. $];
							break second;
						}
				}
			} catch(Exception e) {

				writeln("Invalid input! Aborting..");
			}
		}
		
		if (input == "cat") {

			writeln;
			writeln("Choose:");
			filter!`endsWith(a.name, ".isd")`(dirEntries(".",SpanMode.shallow)).
			map!((a) { writeln(a[2..$ - 4]); return a; } ).
			array;
		}
		
		if (input == "load" && words.length == 2) {

			auto fileName = words[1];
			enum DATA_TYPE {STRINGD, INTD}
			foreach(data; slurp!(string, int)(fileName ~ ".isd", "%s, %s")) {
				ppl ~= Person(data[DATA_TYPE.STRINGD], data[DATA_TYPE.INTD]);
			}
			
			version(old) {
				auto file = File(words[1] ~ ".txt");
				foreach(line; file.byLine) {
					words = line.split;
					break;
				}
				input = "add";
				words = "dummy" ~ words;
			}
		}
		
		if (input == "save" && words.length == 2) {
			auto file = File(words[1] ~ ".isd", "w");
			foreach(psn; ppl)
				file.writeln(format("%s, %s", psn.name, psn.age));
		}
		
		if (input == "clear") {
			ppl.length = 0;
		}
		
		if (input == "sort") {
			if (words.length > 1) {
				
				auto jfind(T)(T[] haystack, T needle) {

					import std.range: empty, front, popFront;
					for(; ! haystack.empty; haystack.popFront) {
						if (haystack.front == needle)
							return true;
					}

					return false;
				}
				
				version(none) {
					auto jfind(string[] haystack, string needle) {
						foreach(word; haystack)
							if (word == needle)
								return true;
						return false;
					}
				}

				if (jfind!string(words, "de")) { //#Not sure on assending and descending -- assensing from less to more
					
					if (jfind(words, "age")) {
						
						ppl.
						sort!"a.age > b.age";
					} else if (jfind(words, "name")) {

						ppl.
						sort!"a.name.toLower > b.name.toLower";
					} else if (jfind(words, "length")) {
							ppl.
							sort!"a.name.length > b.name.length";
					}
				}
				
				if (jfind(words, "as")) {
					
					if (jfind(words, "age")) {
						
						ppl.
						sort!"a.age < b.age";
					} else if (jfind(words, "name")) {

						ppl.
						sort!"a.name.toLower < b.name.toLower";
					} else if (jfind(words, "length")) {
						
						ppl.
						sort!"a.name.length < b.name.length";
					}
				}
			} 
		}
		
		if (input == "s") {
			ppl.
			map!((a) { writeln(a); return a; }).
			array;
		}
		
		if (input == "add" && words.length > 1) {
			auto bits = words;
			
			try {
				iota(1, bits.length, 2).
				map!((a) {
					ppl ~= Person(bits[a], bits[a+1].to!int);
				
					return a;
				}).
				array;
			} catch(Exception e) {
				writeln("Bad input!");
			}
		}
	} while(input != "q");
}
