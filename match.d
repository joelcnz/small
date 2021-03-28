//#this probably works
immutable W = 5, H = 5;

void main() {
	import std.stdio;
	
	int[][] places;
	char[][] backs;
	
	
	places.length = H;
	backs.length = H;
	foreach(ref p; places) {
		p.length = W;
	}
	foreach(ref b; backs) {
		b.length = W;
	}
	
	foreach(y; 0 .. H)
		foreach(x; 0 .. W)
			backs[y][x] = '1';

	void test() {
		places[H - 1][W - 1] = 'X';
	}
	debug test;
	
	
	void set(int x, int y, int value) {
		places[y][x] = value;
	}
	
	int get(int x, int y) {
		return places[y][x];
	}
	
	foreach(i; 0 .. 2) {
		foreach(i2; 0 .. (W * H) / 2) {
			int x, y;
			do {
				import std.random;
				x = cast(int)uniform(0, W);
				y = cast(int)uniform(0, H);
				} while(get(x, y) != 0);
			set(x,y,i2);
		}
	}
	
	import std.stdio;
	import std.string;
	string input;
	
	struct Card {
		int x, y;
	}
	Card[2] cards;

	do {
		draw(places, backs);
		writeln("Clear if not match");
		
		// 'x' is for showing the fronts of the cards
		foreach(i; 0 .. 2) {
			immutable fs = `writeln("(%s)", i == 0 ? "first" : "second" );`;
			mixin(fs);
			
			input = readln.chomp;
			
			if (input.length == 2) {
				import std.conv;
				import std.string;
				
				input = input[0] ~ " " ~ input[1];
				int x, y;
				
				y = input.split[1].to!int - 1;
				x = input.split[0].to!int - 1;
				backs[y][x] = 'x';
			
				cards[i] = Card(x,y);
			}
			
			draw(places, backs);
			mixin(fs);

			if (readln.chomp == "q")
				return;
		} // foreach

		if (cards[0].x != cards[1].x || cards[0].y != cards[1].y)
		//if (cards[0] != cards[1]) //#this probably works
			backs[cards[0].y][cards[0].x] = 'x',
			backs[cards[1].y][cards[1].x] = 'x';

	} while(input != "q");
	writeln("Quitting..");
}

void draw(int[][] places, char[][] backs) {
	import std.stdio;
	import std.process;
//	system("clear");

	foreach(y; 0 .. H) {
		foreach(x; 0 .. W) {
			if (backs[y][x] == 'x') // covered
				writef("%2s ", places[y][x]);
			else // if backs[y][x] == '1'
				writef("## ");
		}
		writeln;
	}
}
