/+
import std.stdio: writeln, File;
import std.file, std.conv;
imprt std.traits; // not used

int makecol(int r, int g, int b) {
	return r * 256 * 256 + g * 256 + b; // make a number, dont quote me, I just chucked it in.
}

class ColourClass {
	int red;
	int blue;
	this() {
		red = makecol(255, 0, 0);
		blue = makecol(0, 0, 255);
	}
}

void main() {
	auto Colour = new ColourClass;

	enum age = 31, name = "Joel";
	writeln(age, " ", name);
	
	enum eWord : string {stone = "rock", cat = "tiger"}
	writeln(eWord.rock, " - ", to!string( eWord.rock ), " : ", eWord.cat, " - ", to!string( eWord.cat ) );
	
	writeln("Red: ", Colour.red, " blue: ", Colour.blue);

	auto f = File("enumcolsfile.txt", "w");
	f.writeln(name, " ", age);
	f.writeln(eWord.rock, " ", eWord.cat);
	f.close;
}
+/
