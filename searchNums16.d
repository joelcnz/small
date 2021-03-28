enum Side {DOWN, UP}

struct Card {
	Side side;
	int number; 
}

void main() {
	int number = 30;
	Card[] cards;
	cards.length = number;

	void doRndNum(int idx, ref Card[] cards) {
		int nc;
		do {
			import std.random;
			nc = cast(int)uniform(0, cards.length);
		} while(cards[nc].side == Side.UP);

		cards[nc].side = Side.UP;
		cards[idx].number = nc + 1;
	}

	foreach(i; 0 .. number) {
		doRndNum(i, cards);
	}
	
	string line;
	foreach(i, card; cards) {
		import std.string;
		line ~= format("%s ", card.number);
		if (line.length > 3 * 10 || i == number - 1) {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}
}