//#taketwo start

>>2
possibles.sort!"a < b".uniq.writeln;

// or

dstring last;
auto differentFromLastPrint(dstring current) {
	if (current != last) {
		last = current;
		writeln(last);
	}
	
	return ""d;
}

possibles.sort!"a < b".map!((a) => differentFromLastPrint(a)).to!dstring;
<<2

>>1
import std.stdio, std.string, std.conv, std.ascii, std.array;

/+
Joel Ezra Christensen - 40
Alan Katherine - 20
+/

void main(string[] args) {
	if (args.length == 1) {
		writeln("No.. like this: Eg. ./taketwo FAKE MOUSE -JQV");
		return;
	}

	ulong[char] tiles; // map value (key and value -- name[key] = value;
//	auto data = "A1 B3 C3 D2 E1 F4 G2 H4 I1 J8 K5 L1 M3 N1 O1 P3 Q10 R1 S1 T1 U1 V4 W4 X8 Y4 Z10".split();

//	foreach(element; data)
	foreach(element; "A1 B3 C3 D2 E1 F4 G2 H4 I1 J8 K5 L1 M3 N1 O1 P3 Q10 R1 S1 T1 U1 V4 W4 X8 Y4 Z10".split())
		tiles[element[0]] = to!ulong(element[1..$]);

	ulong total = 0;
	bool minus = false;
	foreach(t; join(args[1..$]).toUpper()) {
		switch(t) {
			default: /+ continue +/ break;
			case 'A': .. case 'Z':
					total += (minus == false ? tiles[t] : -tiles[t]);
				break;
			case '-': minus = true; break;
			case '+': minus = false; break;	
		}
	}
	writeln("Total: ", total);
}
<<1

//#taketwo start
version(EvenNewer) {
	mixin(usage);
	immutable(ulong)[immutable(char)] tiles = [
	'A' : 1,
	'B' : 3,
	'C' : 3,
	'D' : 2,
	'E' : 1,
	'F' : 4,
	'G' : 2,
	'H' : 4,
	'I' : 1,
	'J' : 8,
	'K' : 5,
	'L' : 1,
	'M' : 3,
	'N' : 1,
	'O' : 1,
	'P' : 3,
	'Q' : 10,
	'R' : 1,
	'S' : 1,
	'T' : 1,
	'U' : 1,
	'V' : 4,
	'W' : 4,
	'X' : 8,
	'Y' : 4,
	'Z' : 10,
	];
	
	ulong total = 0;
	bool minus = false;
	foreach(l; join(args[1..$])) {
		char t = l;
		t = cast(char)toUpper(t);
		if (t == '-')
		minus = true;
		if (t in tiles)
		total += (minus == false ? tiles[t] : -tiles[t]);
	}
	writeln("Total: ", total);
}
version(Newer) {
	mixin(usage);
	ulong[string] tile;
	tile["A"]=1;
	tile["B"]=3;
	tile["C"]=3;
	tile["D"]=2;
	tile["E"]=1;
	tile["F"]=4;
	tile["G"]=2;
	tile["H"]=4;
	tile["I"]=1;
	tile["J"]=8;
	tile["K"]=5;
	tile["L"]=1;
	tile["M"]=3;
	tile["N"]=1;
	tile["O"]=1;
	tile["P"]=3;
	tile["Q"]=10;
	tile["R"]=1;
	tile["S"]=1;
	tile["T"]=1;
	tile["U"]=1;
	tile["V"]=4;
	tile["W"]=4;
	tile["X"]=8;
	tile["Y"]=4;
	tile["Z"]=10;
	
	ulong total;
	string chrs;
	foreach(arg; args[1..$]) 
	chrs ~= arg;
	foreach(input; chrs) {
		string key=to!string(toUpper(input));
		if (key in tile)
		total+=tile[key];
	}
	writeln("Total: ", total);
}
version(Older) {
	int total;
	foreach(n; args[1..$])
	total+=to!int(n);
	writeln("Total: ", total);
}
//taketwo end

// Scroll around with the cursor keys
/// key and direction set
immutable int g_keyDir[12] = [
		ALLEGRO_KEY_UP,0,-1,
		ALLEGRO_KEY_RIGHT,1,0,
		ALLEGRO_KEY_DOWN,0,1,
		ALLEGRO_KEY_LEFT,-1,0
];
foreach( mv; 0 .. g_keyDir.length ) {
	if ( key[ g_keyDir[ mv ] ] ) {
		g_srnPosx += g_keyDir[ mv + 1 ] * g_srnPosStepSize,
		g_srnPosy += g_keyDir[ mv + 2 ] * g_srnPosStepSize;
	}
	mv += 3 - 1;
}

//push objects, kind of. Fail, actually!
		foreach (s; sps)
			if (s !is this) {
				void clean() {
					rectfill(screen, cast(int)s.xpos, cast(int)s.ypos, cast(int)(s.xpos + s.width), cast(int)(s.ypos + s.height), 0);
				}
				// side ways
				if (_y + s.height >= s.ypos && _y <= s.ypos + height) {
					// right
					if (_x + width >= s.xpos && _x <= s.xpos + width / 2)
						clean, s.xpos = s.xpos + 1;
					// left
					if (_x >= s.xpos + s.width / 2 && _x <= s.xpos + s.width && _y + s.height >= s.ypos && _y <= s.ypos + height)
						clean, s.xpos = s.xpos - 1;
				}
				if (_x + width >= s.xpos && _x <= s.xpos + s.width) {
					// down
					if (_y + height / 2 >= s.ypos && _y <= s.ypos + s.height / 2)
						clean, s.ypos = s.ypos + 1;
				}
			}


// go through the alphabet
void loadAnimation(Done done) {
	char c = 'A';
	do {
		textprintf_ex(screen, font, SCREEN_W / 2, SCREEN_H / 2, Colour.amber, 0, toStringz(format(c)));
		if (c == 'Z')
			c = 'A';
		else
			c++;
		rest(10);
		if (key[KEY_ESC])
			done(true);
	} while (! done());
}
