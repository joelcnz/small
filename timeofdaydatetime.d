//#example is wrong in the manuel
import std.datetime;

void main() {
	assert(TimeOfDay(13, 30, 33).toISOExtString() == "13:30:33"); //#example is wrong in the manuel
}
