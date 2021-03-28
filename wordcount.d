void main(string[] args) {
	auto text = "I went for a walk, and fell down a hole.";
	
	import std.string;
	
	if (args.length > 1)
		text = args[1 .. $].join(" ");
	
	import std.stdio;
	if (args.length == 1)
		writeln(text);
	auto wordCount = text.split(" ").length;
	writeln("Made up of ", wordCount," word",  wordCount != 1 ? "s" : "", ".");
}
