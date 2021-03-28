// stuck
enum Side {DOWN, UP}

struct Card(T) {
	Side side;
	T number; 
}

void main() {
	int number = 30;
	import std.stdio;
		
	writeln("Count spotting each number 1 - ", number);
	Card!(int)[] cards;
	cards.length = number;

	void doRndNum(T)(T idx, ref Card!(T)[] cards) {
		T nc;
		do {
			import std.random;
			nc = cast(T)uniform(0, cards.length);
		} while(cards[nc].side == Side.UP);
		cards[nc].side = Side.UP;
		import std.conv;
		cards[idx].number = nc + 1;
	}

	foreach(i; 0 .. number) {
		doRndNum!int(i, cards);
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