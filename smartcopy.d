//#this gets through even with +5.seconds - (Potential copy("/Users/joelchristensen/jpro/dpro2/OtherPeoples/Foxid.wiki/Спрайты-и-анимации.md","/Volumes/PNY480/jpro/dpro2/OtherPeoples/Foxid.wiki/Спрайты-и-анимации.md"); - from time: 2020-Aug-29 19:12:34.2002462, to time + 100.msecs: 2020-Aug-29 19:12:34.3)
//Broken, timeLastModified on computer is different from on the SSD
//Errors on .Spotlight in 256 flash drive
//#if (folder not exist in gb2) create folder//#avoid crash
import std; //, jmisc;

immutable gb1 = "/Volumes/SAN256GB1/";
immutable gb2 = "/Volumes/SAN256GB2/";
immutable pny480dpro2Subs = "/Volumes/PNY480/jpro/dpro2/";

string dataFrom;
string dataTo;

int count;
string[] sourceDest;

void main(string[] args) {
	writeln("Please wait..");
	dataFrom = "/Users/joelchristensen/jpro/dpro2/";
	dataTo = pny480dpro2Subs;
	if (args.length == 2) {
		if (args[1] == "dpro2") {
			dataFrom = "/Users/joelchristensen/jpro/";
			dataTo = "/Volumes/PNY480/jpro/";
			collect(args[1]);
		}
		if (args[1] == "gb1") {
			dataFrom = dataFrom[0 .. dataFrom.length - 6];
			dataTo = gb1 ~ "jpro/";
			collect("dpro2");
		}
		doForReal;
		return;
	}

	//#avoid crash
//	foreach(folders; "Clips Snapshots Other SocialMedia FE Health Bible ToPrint Documents ForGary".split ~
//						"Audio ForAdams Pictures Select jpro".split)
//		collect(folders);
	
//	doForReal;
}

void doForReal() {
	writeln("Number: ", count);
	if (! count) {
		writeln("Folders upto date - no farther action required..");
		return;
	}
	writeln("Enter 'go' to do coping:");
	import std.algorithm : canFind;
	auto input = readln.chomp;
	if (input.canFind("go")) { // Used canFind after finding you could put 'go' and it wouldn't work because you typed stuff before that when it was running
		foreach(sd; sourceDest) {
			//#if (folder not exist in gb2) create folder
			writeln(`copy("`,dataFrom~sd, `","`, dataTo~sd, `");`);
			try {
				copy(dataFrom~sd, dataTo~sd);
			} catch(FileException fe) {
				writeln("File copy error (see above line, folder(s) need to be copied)- moving on..");
			}
		}
		writeln("Done coping..");
	} else
		writeln("No changes made..");
}

void collect(in string folder) {
	auto dsource = dirEntries(dataFrom~folder,"*",SpanMode.depth);
	auto ddest = dirEntries(dataTo~folder,"*",SpanMode.depth);

	string[] source,
			dest;
	foreach (string ds; dsource)
		source ~= ds.replace(dataFrom, "");
	foreach (string dd; ddest)
		dest ~= dd.replace(dataTo, "");

	foreach(s; source)
		if (! (dataFrom~s).isDir && ! (dataFrom~s).canFind("/.")) {
			if (! dest.canFind(s) ||
				(dataFrom~s).timeLastModified > (dataTo~s).timeLastModified + 100.msecs) {
			    writeln(`Potential copy("`,dataFrom~s, `","`, dataTo~s, `"); - from time: `, (dataFrom~s).timeLastModified, `, to time + 100.msecs: `, (dataTo~s).timeLastModified + 100.msecs);
				count += 1;
				sourceDest ~= s;
			}
		}
}
