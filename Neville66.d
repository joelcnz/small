//note was changed since his birthday
import std.stdio;
import core.thread;

const hpybdy = "Happy bithday Dad :-)";
const gr8dy = "Hope you're having a great day! :-)";
//const gr8dy = "Happy bithday Dad :-)";
//const hpybdy = "Hope you're having a great day! :-)";

string myFill(string other, char c, int count) {
	if (count < 1)
		return other ~ ' ';

	char[] filling;
	filling.length = count;
	filling[] = c;

	return other ~ filling.idup;
}

void main() {
	int x = 0;
	bool dir = true;
	while(1 == 1) {
		foreach(w; 0 .. x)
			write(' ');
		if (dir == true)
			write(hpybdy.myFill(' ', gr8dy.length - hpybdy.length) ~ '\r');
		else
			write(gr8dy.myFill(' ', hpybdy.length - gr8dy.length) ~ '\r');
		stdout.flush;
		if (dir == true) {
			x++;
			if (x > 40)
				dir = false;
		}
		if (dir == false) {
			x--;
			if (x < 1)
				dir = true;
		}
		Thread.sleep(dur!("msecs")(1_000 / 6)); //#a better short pause
	}
}
