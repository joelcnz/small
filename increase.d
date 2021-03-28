import std.stdio;

void main() {
	int hour = 23, minute =  59, second = 59;
	int hours = 1, minutes = 1, seconds = 1;
	
	int inSeconds = hour * 60 * 60 + minute * 60 + second;
	
	inSeconds += hours * 60 * 60 + minutes * 60 + seconds;
	
	float newHours, newMinutes, newSeconds;
	
	newHours = inSeconds / (60 * 60); // is correct
	newMinutes = inSeconds / 60 - newHours * 60; // is also correct!
	newSeconds = inSeconds % 60; // is correct
	
	writefln("Start    time: %3s:%02s.%02s", hour,minute,second);
	writefln("Increase time: %3s:%02s.%02s", hours,minutes,seconds);
	writefln("Result   time: %3s:%02s.%02s", newHours, newMinutes, newSeconds);
	//assert(newHours == 3 && newMinutes == 7 && newSeconds == 11);
}
