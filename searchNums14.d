void main() {
	int number = 20;
	
	enum Side {DOWN, UP}
	struct Card {
		Side side;
		int number;
	}
	Card[] cards;
	cards.length = number;
	string line;
	foreach(int i; 0 .. number) {
		int can; // candiate
		do {
			import std.random;
			can = cast(int)uniform(0, number);
		} while(cards[can].side == Side.UP);
		cards[can].number = can + 1;
		cards[can].side = Side.UP;

		import std.conv;
		line ~= cards[can].number.to!string ~ " ";

		import std.stdio;
		if (line.length > 3 * 10 || i == number - 1)  {
			import std.stdio;
			writeln(line);
			line.length = 0;
		}
	}
}