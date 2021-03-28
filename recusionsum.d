//Org: http://www.cs.umd.edu/class/spring2002/cmsc214/Tutorial/recursion.html - googled "understanding recursion"
import std.stdio;

void main() {
	writeln([1, 2, 3].sum(3));
}

int sum(int arr[], int pos) {
	static hit = 0;
	
	writeln("In sum function. Enter times ", ++hit);
	writeln(arr, " pos - ", pos);
	if (pos is 0) { // base case
		writeln("pos is 0");
		return 0;
	}
	else {
		writeln("pos > 0");
		// recursive call
		int smallResult = sum( arr, pos - 1 );

		// use solution of recursive call to solve this problem
		return smallResult + arr[ pos - 1 ];
	}
}
