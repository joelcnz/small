
import std.stdio;
import std.string;

enum DoneAction {cont, quit, anotherLoop};

alias toLower = std.uni.toLower;

void main() {
	// a = 1, b = 2, A = 10, B = 20
	if (Computea1b2A10B20() == DoneAction.quit)
		return;
	// a = 1, b = 2 etc
	if (Computea1b2 == DoneAction.quit)
		return;

	writeln( "Part One - (ASCII charactors to numbers):" );
	writeln("q - to continue to the next parse");
	foreach( card; "WINDOWS96-BILLGATES-JESUSCHRIST!-The Way".split("-")) {
		computeASCII( card );
		switch(card) {
			case "BILLGATES": " - Bill Gates III (add 3 to bigger number)".write; break;
			default: break;
		}
writeln();

	}
	while( computeASCII( stripRight( readln ) ) ) { writeln(); }

	writeln( "\nPart Two - (A = 6, B = 12 etc):" );
	foreach( card6; ["COMPUTER", "APPLE"] ) {
		card6.compute6;
	}
	writeln("q - to continue to the next parse");
	while(readln.stripRight.compute6) {}

	writeln("\n take two part (last) - (think scrabble)");
	foreach(token; ["Joel Ezra Christensen",
					"Christensen",
					"Katherine",
					"Alan Katherine",
					"Timothy Christensen"]) {
		takeTwo(token);
		switch(token) {
			default: writeln(); break;
			case "Timothy Christensen": " - his age when I first found this".writeln; break;
		}
	}
	writeln("q - quit whole program");
	while(readln.strip.takeTwo) {  writeln; }
}

auto computeASCII( string input ) {
	if ( input.length == 0 || input[0] == 'c' || input[0] == 'C')
		return true;
	if ( input[0] == 'q' || input[0] == 'Q' )
		return false;
	int total = 0;
	import std.range;
	input = input.tee!(a => total += a).to!string;
	
	writef( `This is the text: "%s" and this is the number from it %d`, input, total );

	return true;
}

auto compute6( string input ) {
	if ( input.length == 0 )
		return true;
	if ( input[0] == 'q' || input[0] == 'Q' )
		return false;
	writeln( "Uses lowerCase:" );
	int total = 0;
	foreach( c; input )
		total += (1 + ( c.toLower - 'a' ) ) * 6;
	writef( `This is the text: "%s" and this is the number from it %d`, input, total );
	writeln();

	return true;
}

import std.stdio, std.string, std.conv, std.ascii, std.array;

/+
Joel Ezra Christensen - 40
Alan Katherine - 20
Alan Christensen - 20
Timothy Christensen - 31 (found this at the time of being 31)
Katherine - 16
Christensen - 16
+/

bool takeTwo(string input) {
	if (input.length == 0)
		return true;
	if (input == "q")
		return false;

	ulong[char] tiles; // map value (key and value -- name[key] = value;
	
	foreach(element; "A1 B3 C3 D2 E1 F4 G2 H4 I1 J8 K5 L1 M3 N1 O1 P3 Q10 R1 S1 T1 U1 V4 W4 X8 Y4 Z10".split())
		tiles[element[0]] = to!ulong(element[1..$]);
	
	ulong total = 0;
	bool minus = false;
	foreach(t; input.toUpper()) {
		switch(t) {
			default: /+ continue +/ break;
			case 'A': .. case 'Z':
				total += (minus == false ? tiles[t] : -tiles[t]);
				break;
			case '-': minus = true; break;
			case '+': minus = false; break;	
		}
	}
	writef( `%s - %s`, total, input );

	return true;
}

int Computea1b2A10B20() {
	
	void computea1b2A10B20(string x) {
		long total;
		foreach(i; x) {
			if (i >= 'A' && i <= 'Z') {
				total += (i - 'A' + 1) * 10;
			} else {
				total += i - 'a' + 1;
			}
		}

		writeln(x, " - ", total);
	}

	writeln("compute a = 1, b = 2, etc. A = 10, B = 20 etc." ~
			" c - continue to the next one, q - quit:");
	foreach(card; "alan|ria|neville|attitude|mow lawn".split("|")) {
		computea1b2A10B20(card);
	}

	string card;
	int move = DoneAction.anotherLoop;
	while(move == DoneAction.anotherLoop) {
		card = readln[0..$-1];
		computea1b2A10B20(card);
			
		if ( card == "c")
			return DoneAction.cont;
		if (card == "q")
			return DoneAction.quit;
	}
	if (card == "q")
		return DoneAction.quit;
	else
		return DoneAction.cont;
}

int Computea1b2() {
	
	void computea1b2(string x) {
		long total;
		foreach(i; x)
			total += i - 'a' + 1;

		writeln(x, " - ", total);
	}

	writeln("compute a = 1 b = 2 (A = -31). c - continue to the next one, q - quit:");
	foreach(card; "alan ria neville Rhondda rhondda Joel attitude".split ~ "Joel play" ~ " play" ~ "mow lawn") {
		computea1b2(card);
	}

	string card;
	int move = DoneAction.anotherLoop;
	while(move == DoneAction.anotherLoop) {
		card = readln[0..$-1];
		computea1b2(card);
			
		if ( card == "c")
			return DoneAction.cont;
		if (card == "q")
			return DoneAction.quit;
	}
	if (card == "q")
		return DoneAction.quit;
	else
		return DoneAction.cont;
}
