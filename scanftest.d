import std.stdio;
 
void main(string[] args) {
	writeln("Enter 4 time numbers (seconds):");
  int time = 0, x;
  for(int i = 0; i < 4; i++) {
    scanf(" %d", &x);
    time += x;
  }
  writefln("Minutes: %02s, and %02s seconds left.", time/60, time % 60);
}
