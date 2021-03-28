import std.stdio;
import std.algorithm;
import std.array;
import std.random;
import std.range;

void main() {
	//auto arr = new int[50];
	int[] arr; arr.length = 50;
	fill(arr, randomCover(iota(0,1024), rndGen));
	fill(arr[10..20], 7);
	
	foreach( num; arr )
		write( num, ' ' );
}
