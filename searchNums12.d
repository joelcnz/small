version = something;

void main(string[] args) {
	int number = 20;
	if (args.length > 1) {
		import std.conv;
		number = args[1].to!int;
	}
	enum Card {BACK, FRONT}
	Card[] cards;
	int[] nums;
	cards.length = number;
	nums.length = number;
	string line;
	foreach(i; 0 .. cards.length) {
		int picker;
		do {
			import std.random;
			picker = cast(int)uniform(0, number);
		} while(cards[picker] == Card.FRONT);
		cards[picker] = Card.FRONT;
		nums[picker] = cast(int)i;

		import std.stdio;
		string line2;
		foreach(j; 0 .. number) {
			import std.conv;
			import std.string;
			line2 ~= (cards[j] == Card.BACK ? "##" : format("%02s", nums[j] + 1)); // print back or front of card
			line2 ~= (j != number - 1 ? " " : ""); // gap or so at the end
		}
	
		import std.stdio, std.range;
		write(line2 ~ "\r");
	   	stdout.flush;

		import core.thread;
		Thread.sleep(200.msecs);
	} // foreach
	
	import std.stdio;	
	writeln;
}
