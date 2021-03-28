enum Side {DOWN, UP}

struct Card {
	Side side;
	int number;
}

void main() {
	int number = 30;
	Card[] cards;
	cards.length = number; // cards all facing up with this
	string line;
	
	foreach(i; 0 .. number) {
		int nc; // number candidate
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(cards[nc].side == Side.UP);
		cards[nc].number = nc + 1;
		cards[nc].side = Side.UP;
		import std.string;
		line ~= format("%s ", cards[nc].number);
		if (line.length > 3 * 10 || i == number - 1) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}
}