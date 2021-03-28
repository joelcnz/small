import std.stdio;

void main() {
	auto empty = "";
	assert(empty !is null);
	assert(empty == null);
	auto my_entry=new Entry;
	my_entry.setText(empty);
}

class Entry {
	string text;
	void setText(string text ) {
		this.text=text;
		writefln("%s is set",text.stringof);
	}
}
