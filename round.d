// Round floating point numbers
import std.algorithm, std.conv, std.functional,
    std.math, std.regex, std.stdio;

alias round = pipe!(to!real, std.math.round, to!string);
static reFloatingPoint = ctRegex!`[0-9]+\.[0-9]+`;

void main()
{
	example;
	
    // Replace anything that looks like a real
    // number with the rounded equivalent.
    stdin
        .byLine
        .map!(l => l.replaceAll!(c => c.hit.round)
                                (reFloatingPoint))
        .each!writeln;
}

string baz(Captures!(string) m) {
    import std.string : toUpper;
    return toUpper(m.hit);
}

void example() {
	// Capitalize the letters 'a' and 'r':
	auto s = replaceAll!(baz)("Strap a rocket engine on a chicken.",
	        regex("[ar]"));
	writeln(s); // "StRAp A Rocket engine on A chicken."
}