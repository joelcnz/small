import std.stdio;
import std.range;

void main() {
	auto arr1 = [1,2,3,4,5];
	auto arr2 = [6,7,8,9,10];

	typeof(arr1) result;
	foreach(a, b; lockstep(arr1, arr2))
	    	result ~= [a,b];

	assert(result == [1,6,2,7,3,8,4,9,5,10]);
}

