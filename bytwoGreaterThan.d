// bytwoGreaterThan > z.txt
// 10 <enter>
// z.txt file has '0.5'
import std.stdio;

void main() {
	double number;
	writeln("Enter a number to be devided by 10:");
	readf(" %s", &number);
	
	writeln(number / 10);
}