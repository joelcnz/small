auto filt(T)(bool function(T) dg, T[] arr) {
	T[] arr2;
	import std.range: empty, popFront, front;
	for(; ! arr.empty; arr.popFront)
		if (dg(arr.front))
			arr2 ~= arr.front;
	return arr2;
}

void main() {
	import std.stdio: writeln;
	import std.algorithm: sort;
	writeln(filt!int(a => a < 40, [35, 38, 41, 32, 59, 68, 12, 21, 4]).sort!"a > b");
	writeln;
	
	import std.string: split;
	auto names = "Alan Christensen|Ria Christensen|Timothy Christensen|Joel Christensen|Joy Bryant|Jeremy Bryant".split("|");
	auto strFilt = filt!string(a => a[0] == 'J', names);
	auto str2Filt = filt!string(a => a.split[1][0] == 'C', names);
	auto str3Filt = filt!string(a => a.split[1][0] == 'B', names);
	
	foreach(name; strFilt)
		writeln(name);
	writeln;
	
	foreach(name; str2Filt)
		writeln(name);
	writeln;

	foreach(name; str3Filt)
		writeln(name);
	writeln;
}
