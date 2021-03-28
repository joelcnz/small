// Bethia Enright
import std.stdio, std.string, std.conv, std.ascii, std.array;

struct ChrNum {
	string input;
	string comment;
}

void main(string[] args) {
	if (args.length == 1) {
		foreach(chrNum; [ChrNum("Bethia Christensen", "I 1st noticed this when that age."),
						ChrNum("Bethia Enright Christensen"),
						ChrNum("Joel Christensen"),
						ChrNum("Bethia Enright"),
						ChrNum("Joel and Bethia Christensen", "(7x7=49) 7 is the number for Spiritual perfection for" ~
							" each of us!"),
						ChrNum("Bethia Christensen - Enright", "My house number"),
						ChrNum("Joel Bethia kiss", "My favourite number"),
						ChrNum("Joel Ezra Christensen"),
						ChrNum("Alan Katherine"),
						ChrNum("Alan Christensen"),
						ChrNum("Timothy Christensen","found this at the time of him being 31"),
						ChrNum("Katherine"),
						ChrNum("Christensen"),
		]) {
			chrNum.input.takeTwo(chrNum.comment);
		}
		
		foreach(chrNum; [ChrNum("Joel Bethia kiss", "(7 is spiritual perfection, 17 is the 7th prime number, 10 is " ~
								 " ordinal perfection, both together, are the perfection of spiritual order. " ~
								 "See Rom 8:35-39, a list of 7 then list of 10)"),
						  ChrNum("Joel and Bethia Christensen"),
						  ChrNum("BETHIA!", "the number on the number plate on my 1st car"),
						  ChrNum("WINDOWS96"),
						  ChrNum("BILLGATES", "Bill Gates III (add 3)"),
						  ChrNum("JESUSCHRIST!"),
						  ChrNum("The Way")]) {
			chrNum.input.doASCIIvalues(chrNum.comment);
		}
		
		foreach(chrNum; [ChrNum("Joel wants Bethia heart", "240 Amstrad 8 bit computer character is an up arrow " ~
								"- 1111000 (Noticed the 2 11's beside each other being one, and the other half, nothing)"),]) {
			chrNum.input.a1b2A10B20(chrNum.comment);
		}
		
		foreach(chrNum; [ChrNum("Joel"),
						 ChrNum("Bethia Enright"),
						 ChrNum("play","Main number of screens in my Explore games"),
						 ChrNum(" play","notice the space"),
						 ChrNum("Bethia","7x7"),
						 ChrNum("Joel loves Bethia","my birthday is on the fourth month"),
						 ChrNum("Joel Bethia married"),
						 ChrNum("Joel Bethia kiss"),
						 ChrNum("alan"),
						 ChrNum("ria"),
						 ChrNum("neville"),
						 ChrNum("Rhondda"),
						 ChrNum("rhondda"),
						 ChrNum("Joel"),
						 ChrNum("attitude")]) {
			chrNum.input.doa1b2A31B30(chrNum.comment);
		}
		
		foreach(chrNum; [ChrNum("computer"), ChrNum("apple")])
			chrNum.input.A6B12Etc(chrNum.comment);
		
		return;
	}
	
	auto input = args[1 .. $].join(" ");

	writeln;
	input.takeTwo;
	input.doASCIIvalues;
	input.a1b2A10B20;
	input.doa1b2A31B30;
	input.A6B12Etc;
	writeln;
}

void doASCIIvalues(string input, string comment = "") {
	int total = 0;
	import std.range;
	input = input.tee!(a => total += a).to!string;
	writefln( `ASCII: "%s" - %d%s`, input, total, comment.length ? " - " ~ comment : "");
}

void A6B12Etc(string input, string comment = "") {
	int total = 0;
	foreach( c; input )
		total += (1 + ( std.ascii.toLower(c) - 'a' ) ) * 6;
	writefln(`A=6, B=12 etc..: "%s" - %d%s`, input, total, comment.length ? " - " ~ comment : "");
}

void takeTwo(string input, string comment = "") {
	ulong[char] tiles; // map value (key and value -- name[key] = value;
	int total;

	foreach(element; "A1 B3 C3 D2 E1 F4 G2 H4 I1 J8 K5 L1 M3 N1 O1 P3 Q10 R1 S1 T1 U1 V4 W4 X8 Y4 Z10".split())
		tiles[element[0]] = to!ulong(element[1..$]);

	bool minus = false;
	foreach(t; input.toUpper) {
		switch(t) {
			default: /+ continue +/ break;
			case 'A': .. case 'Z':
				total += (minus == false ? tiles[t] : -tiles[t]);
				break;
			case '-': minus = true; break;
			case '+': minus = false; break;	
		}
	}
	writefln(`Take Two: "%s" - %s%s`, input, total, comment.length ? " - " ~ comment : "");
}

void a1b2A10B20(string input, string comment = "") {
	int total;

	foreach(i; input) {
		if (i >= 'A' && i <= 'Z') {
			total += (i - 'A' + 1) * 10;
		} else {
			total += i - 'a' + 1;
		}
	}

	writeln(`a=1, b=2.. A=10, B=20: "`, input, `" - `, total, comment.length ? " - " ~ comment : "");
}

void doa1b2A31B30(string input, string comment = "") {
	int total;
	foreach(i; input)
		total += i - 'a' + 1;

	writeln(`a=1, b=2.. A=-31, B=-30..: "`, input, `" - `, total, comment.length ? " - " ~ comment : "");
}
