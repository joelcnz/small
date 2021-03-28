enum Side {DOWN, UP}

struct Card {
	int num;
	Side side;
}

void main() {
	int number = 18;
	import std.stdio;
	writeln("Search for each number in order from 1 to ", number);
	Card[] cards;
	cards.length = number;
	string collection;
	foreach(idx, card; cards) {
		int nc; // number candidat(sp)
		do {
			import std.random;
			nc = cast(int)uniform(0, number);
		} while(cards[nc].side == Side.UP);
		cards[nc].side = Side.UP;
		card.num = nc + 1;
		
		import std.string;
		collection ~= format("%s ", card.num);
		if (collection.length + 3 >  3 * 10 || idx == number - 1) {
			import std.stdio;
			writeln(collection);
			collection.length = 0;
		}
	}
}
