//#this next line doesn't look right
//#Thing, the first character doesn't get removed
import std.stdio;
import std.string;
import std.file: write, read;
import std.process;
import std.ascii: toUpper;
import std.conv;

//version = Testing;

/*
nevcnz d Got up late. Got a programmingThingSetupWithHelp,AlsoGotSomeThingWorkingThatIWantedForAWhile.I'mAboutToTrySomeDrivingInTheDriveway.
d nevcnz Does this text fit into one message? Does this text fit into one message? Does this text fit into one message? Does this text fit into one message?
*/
//const orgText = "i went for a walk and fell down a holeddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd";
//const orgText = "The police are trying to get a hold of Tim. They found his wallet. Can you help? He has to come in to get it, so they know it's the right person.";

/**
 * 1. Take a certin(sp) text file that's too big to fit in one twitter message.
 * 
 * 2. Count the spaces to see if can make it fit.
 * 
 * 3. Starting from the end of the message remove spaces and capitalize the words with the removed spaces.
 * 
 * 4. Open a new text file and fill it with the shortened message.
 * 
 * Note: See _notes.txt for more information
 */
void main(string[] args) {
	const openInTextFile = `c:\jpro\mp.exe twittersource.txt`;
	system( openInTextFile );
	
	string orgText = cast(string)read("twittersource.txt");
	
	// Count the spaces
	auto text = orgText.dup; // char[], not string
	auto i = cast(int)text.length - 1;
	auto numToRemove = cast(int)text.length - 140;
	int spaces; // the two spaces at the start are not counted (eg. "D nevcnz ...") dont want to remove them!
	import std.algorithm;
	spaces = -2 + count(text, ' '); //-2 for dXnevcnzX...
	
	// Is there enough spaces for it to work?
	writeln ("spaces: ", spaces, " numToRemove: ", numToRemove);
	if (numToRemove > spaces) {
		system ("echo Not enough spaces. Abort.");
		system ("pause");
		return;
	}
	
	// removed minnumin(sp) number of spaces and do capitalizing(sp)
	bool inword = false;
	//#Thing, the first character doesn't get removed
	while (numToRemove > 0) {
		@property bool endOfWord() { return (inword == true && i >= 0 && text[i] == ' ' && i + 1 < text.length); }
		//#this next line doesn't look right
		@property bool passedFrstLet() { return i == -1; }
		if (endOfWord || passedFrstLet) {
			text[i+1] = cast(char)toUpper( text[ i+1 ] );
			
			inword = false;
			text = text[0 .. i] ~ text[i+1 .. $];
			--numToRemove;
		}
		if (i >= 0 && text[i] != ' ')
			inword = true;
		--i;
	}
	write("twitterresault.txt", cast(char[])text);
	system( "twitterresault.txt" );
	system( "pause" );
}
