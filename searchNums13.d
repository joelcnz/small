// Doesn't display any thing!
//#fail
void main() {
	int number = 30;
	enum Card {COVERED, SHOW}
	Card[] cards;
	cards.length = number;
	immutable(char)[] line;
	foreach(i; 0 .. number) {
		int current;
		do {
			import std.random;
			current = cast(int)uniform(0, number);
		} while(cards[current] == Card.SHOW);
		cards[current] = Card.SHOW;
	
		if (line.length + 3 > 10 * 3 || i == number - 1) {
			import std.stdio;
			import std.string;
			import core.thread;
			foreach(num; line.split) {
				Thread.sleep(150.msecs);
				line ~= format("%s ", current + 1);
				write(line); stdout.flush;
				write( "\r");
				if (line.length + 3 < 10 * 3) { //#fail
					line.length = 0;
				}
			}
		}
	}
}