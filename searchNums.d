/**
Search the numbers 1 - 30 by finding 1 then 2 etc

Not working properly!
*/

import std.stdio;
import std.random;
import std.range;

void main(string[] args) {

	if (args.length > 1 && args[1] == "new") {
		bool[1 + 60 + 1] nums;
		writeln("Search count: 1 - ", nums.length - 2);
		string line;
		writeln(`writeln(`);
		foreach(i; iota(1, nums.length - 1)) {
			int rc;
			do {
				rc = cast(int)uniform(1, nums.length - 1);
			} while(nums[rc] == true);

			import std.string;
			
			auto newLineQ = (line.length + 3 > 30 || i == nums.length - 2);
			line ~= format("%s%s", rc, (newLineQ ? "" : " "));
			nums[rc] = true;
		
			if (newLineQ) {
				writeln(`"` ~ line ~ `\n"`);
				line.length = 0;
			}
		}
		writeln(`);`);
	} else {
		writeln("26 14 19 11 54 25 23 27 30 28 
42 57 31 8 34 40 13 46 47 60 
36 53 5 3 55 29 33 9 51 18 38 
17 12 39 44 2 10 21 58 59 56 
20 16 22 35 7 50 32 48 24 49 
41 4 52 43 37 6 15 1 45");
	}
}
