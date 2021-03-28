/+

sample.txt

house(sp)
cat and(sp) dog
rock shoe

./spellscan sample word

house(sp)
and(sp)

./spellscan sample context

house(sp)
cat and(sp) dog

+/
import std.stdio;
import std.file;
import std.algorithm;
import std.conv;
import std.string;
import lets = std.ascii;
import std.path : buildPath, setExtension;

void main(string[] args) {
	if (args.length == 1) {
		writeln("Help:\n",
				"./spellscan <file name> word - eg. './spellscan Hold word'\n",
				"./spellscan <file name> context");
		return;
	}
	
	args[1] = args[1].setExtension("txt");
	if (! args[1].exists) {
		writeln(args[1], " - does not exist!");
		return;
	}
	
	enum DisplayType {word, context}
	DisplayType displayType;
	
	if (args.length >= 3) with (DisplayType) {
		switch(args[2]) {
			default:
				writeln("Start again, but this time enter either 'word', or 'context' with the rest\n",
						"(eg. './spellscan Hold context')");
				return;
			case    "word": displayType = word; break;
			case "context": displayType = context; break;
		}
	}
	
	string[] result;
	
	foreach(cline; File(args[1]).byLine) { //char[]
		int start, end;
		end = cast(int)cline.indexOf("(sp)");
		if (end > 0) {
			auto line = cline.to!string;
			final switch(displayType) with(DisplayType) {
				case word:
					end += 3;
					int i = end - 5; // 'house (sp)' - works even with the gap
					while(i >= 0) {
						scope(exit)
							start = i + 1;
						char chr = line[i];
						import std.ascii: letters;
						import std.algorithm: canFind;

						if ((letters ~ `-.'`).canFind(chr)) // is it a letter, dash, dot or single quote
							i -= 1;
						else
							break;
					}
					result ~= line[start .. end + 1 - 4]; // '- 4' to truncate '(sp)'
				break;
				case context:
					result ~= line;
				break;
			} // switch
		} // if (end
	} // foreach
	
	result.each!(a => writeln(a));
}
