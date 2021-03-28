
void main() {
	int space = -1;

	int[] arr;
	arr.length = 30;
	arr[] = -1;
	
	void getFiltNum(int i) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, arr.length);
		} while(arr[nc] != space);
		arr[nc] = i + 1;
	}
	
	foreach(i; 0 .. arr.length) {
		getFiltNum(cast(int)i);
	}
	
	import std.conv;
	string line;
	foreach(i, itm; arr) {
		line ~= itm.to!string ~ " ";
		if (line.length > 3 * 10 || i == arr.length - 1) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}			
	}
}
