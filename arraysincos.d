import std.math;

void main() {
	float[2][] result = new float[2][](360);
	float x = 50;
	foreach(i; 0 .. 360){
		result[i] = [sin(x), cos(x)];
	}
	import std.stdio;
	foreach(a; 0 .. 360)
		writeln(result[a], ' '); //[0, 0] etc
	writeln('<', result[359][0], ", ", result[359][1], '>');
}
