void main() {
	int number = 30;
	int[] arr;
	arr.length = number;
	arr[] = int.max;
	foreach(i; 0 .. number) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(arr[nc] != int.max);
		arr[nc] = i + 1;
	}
	
	import std.stdio;
	string line;
//	line.length = 10 * 3;
	foreach(i; 0 .. number) {
		import std.conv;
		//line[i * 3 .. i * 3 + 3] = arr[i].to!string ~ " ";
		line ~= (arr[i] < 10 ? "0" : "") ~ arr[i].to!string ~ " ";
		if (line.length + 3 > 3 * 10 || i + 1 == number) {
			writeln(line);
			line.length = 0;
		}
	}
}
