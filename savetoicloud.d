import std;

void main(string[] args) {
	immutable string[] sourceFiles = ["_notessmall.txt", // ~/jpro/dpro2/small
			"../_notes.txt", // ~/jpro/dpro2 
			"/Users/joelchristensen/Documents/Hold.txt"];
	immutable dest = "/Users/joelchristensen/Library/Mobile Documents/com~apple~TextEdit/Documents/";
	if (args.length > 1)
		writeln("Mock copying:");
	foreach(source; sourceFiles) {
		writeln(source, " to ", dest ~ source.baseName);
		if (args.length == 1)
			copy(source,  dest ~ source.baseName);
	}
}
