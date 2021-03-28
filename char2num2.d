//See also numral.d
// ./cf char2num2
// See aswell - "char2num2 history.txt"
import std.stdio, std.string, std.conv, std.ascii, std.array, std.file : append;

import jmisc;

struct ChrNum {
	string input;
	string comment;
}

void main(string[] args) {	
	if (args.length == 1)
		return;
	auto input = args[1 .. $].join(" ");
	//auto input = args[1];
	

	writeln;
	input.takeTwo;
	input.doASCIIvalues;
	input.a1b2A10B20;
	input.doa1b2A31B30;
	input.A6B12Etc;
	writeln;
}

void update(in string str) {
	append("char2num2 history.txt",jm_upDateStatus(str));
}

void doASCIIvalues(string input, string comment = "") {
	int total = 0;
	import std.range;
	input = input.tee!(a => total += a).to!string;
	update(format(`ASCII: "%s" - %d%s`, input, total, comment.length ? " - " ~ comment : ""));
}

void A6B12Etc(string input, string comment = "") {
	int total = 0;
	foreach( c; input )
		total += (1 + ( std.ascii.toLower(c) - 'a' ) ) * 6;
	update(format(`A=6, B=12 etc..: "%s" - %d%s`, input, total, comment.length ? " - " ~ comment : ""));
}

void takeTwo(string input, string comment = "") {
	ulong[char] tiles; // map value (key and value -- name[key] = value;
	long total;

	foreach(element; "A1 B3 C3 D2 E1 F4 G2 H4 I1 J8 K5 L1 M3 N1 O1 P3 Q10 R1 S1 T1 U1 V4 W4 X8 Y4 Z10".split())
		tiles[element[0]] = to!ulong(element[1 .. $]);

	bool minus = false;
	foreach(t; input.toUpper) {
		switch(t) {
			default: continue;
			case 'A': .. case 'Z':
				total += (minus == false ? tiles[t] : -tiles[t]);
				break;
			case '-': minus = true; break;
			case '+': minus = false; break;	
		}
	}
	update(format(`Take Two: "%s" - %s%s`, input, total, comment.length ? " - " ~ comment : ""));
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

	update(text(`a=1, b=2.. A=10, B=20: "`, input, `" - `, total, comment.length ? " - " ~ comment : ""));
}

void doa1b2A31B30(string input, string comment = "") {
	int total;
	foreach(i; input)
		total += i - 'a' + 1;

	update(text(`a=1, b=2.. A=-31, B=-30..: "`, input, `" - `, total, comment.length ? " - " ~ comment : ""));
}
