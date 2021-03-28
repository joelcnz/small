// the flash drive has to be called "iUSB' and plugged in. iPhone USB (one end pluggs into the phone, also, the other end into a USB port or MicroUSB port)

void main() {
	import std.stdio;
	import std.file;
	
	immutable sourceDocument = "../../../Documents/Hold.txt";
	immutable destDocuments = ["../Jyble/Hold.txt", "/Volumes/iUSB/Documents/Bible/Hold.txt"];

	if (sourceDocument.exists) {
		foreach(hold; destDocuments) {
			if (! hold.exists)
				writeln(hold, " - does not exist..");
			else {
				copy(sourceDocument, hold);
				writeln(hold, " - updated");
			}
		}
	} else {
		writeln("Couldn't find: ", sourceDocument);
	}
}
