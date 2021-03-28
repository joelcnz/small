void main() {
	int number = 20;
	enum Light {OFF, ON}
	Light[] lights;
	lights.length = number; // all off
	string line;
	foreach(i; 0 .. number) {
		int nc; // nuber candatate(sp)
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(lights[nc] == Light.ON);
		lights[nc] = Light.ON;
		import std.string;
		line ~= format("%s ", nc + 1);
		if (line.length > 3 * 10 || i == number - 1) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}
}
