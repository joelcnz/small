import std.stdio;
import std.string;
import std.conv;
import std.algorithm;

void main() {
	string s = "1+2+3+4+5+6+7+8+9+10+11";

	s = s.replace("+", " ");
	s.writeln;
	writeln(reduce!"a + b"(0, s.split.to!(int[])), " ", "The numbers added together. - 11 letters in Christensen");
//	s.split("+").writeln;
}