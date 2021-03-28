import std.stdio;

void main(string[] args) {
	auto data="I went for a walk and  fell down a hole!";
	if (args.length > 1) {
		import std.string;
		data = args[1 .. $].join;
	}
	for(int i; i < data.length; i++)
		if (data[i] == ' ')
			continue;
		else
			write(data[i]);

	writeln("");
	foreach (d; data)
		if (d == ' ')
			continue;
		else
			write(d);
}
