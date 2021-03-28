// Three way pool
void main(string[] args) {
	import std;
	
	if (args.length != 1 + 3) {
		writeln("Eg. ", args[0], " Joel Fraser Kate");
		return;
	}
	args.popFront;

	auto rnd = MinstdRand0(uniform(0, int.max));

	auto nums = iota(1,16).array.randomShuffle(rnd);
	int s;
	int i;
	do {
        wait(spawnProcess(["clear"]));
		writeln(args[i], " - hit return" );
		i += 1;
		readln;
		for(int a=s; a < s + 5; a += 1)
			write(nums[a], ' ');
		readln;
		writeln;
        wait(spawnProcess(["clear"]));
		s += 5;
	} while(s < 15);
}
