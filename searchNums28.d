// can't get it to work 3 Jan 2015 4:56pm
// 3 Jan 2015
enum Light {OFF, ON};

class Lantern {
	int _num;
	Light _light;
	
	this(Light light) {
		_light = Light.OFF;
	}
	
	Light checkLight() {
		return _light;
	}
	
	void setLight(Light light) {
		_light = light;
	}
	
	auto getNum() {
		return _num;
	}
	
	void setNum(int num) {
		_num = num;
	}
}

void main() {
	int number = 10;
	Lantern[] lanterns;
	lanterns.length = number;
	import std.range;

	foreach(ref a; lanterns) {
		a = new Lantern(Light.OFF);
	}

	foreach(i; 0 .. number) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(lanterns[nc].checkLight != Light.OFF);
		with(lanterns[nc])
			setLight = Light.ON, setNum = cast(int)i;
	}
	lanterns
	.map!((a) => a.setNum(a.getNum + 1));
	
	void print() {
		string line;
		foreach(i, l; lanterns) {
			import std.stdio, std.conv;
			line ~= (l.getNum).to!string ~ " ";
			if (line.length + 3 > 3 * 10 || i == number - 1) {
				writeln(line);
				line.length = 0;
			}
		}
	}
	print;
}
