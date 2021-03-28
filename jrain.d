void main(string[] args) {
	string name;
	if (args.length == 1)
		name = "Joel";
	else
		name = args[1];
	import std.stdio;
	
	void jrain(in string prog) {
		writeln("./", prog, " ", name);
	}
	
	jrain("tables");
	jrain("sums");
	jrain("takeaways");
}