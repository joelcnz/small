//#hi's from Alan - if it worked
import std.stdio;

void main(string[] args) {
	IHi[] sibs;
	if (args.length == 1)
		args ~= "tar";
	foreach(id;args[1] ) {
		switch (id) {
			default:
			break;
			case 'r':
				sibs ~= new Ria;
			break;
			case 'a':
				sibs ~= new Alan;
			break;
			case 't':
				sibs ~= new Timothy;
			break;
		}
	}
	
	//#hi's from Alan - if it worked (not work)
	// how do you compare types when they only marked as super classes?
	foreach(s; sibs)
		s.hi();
}

interface IHi {
	void hi();
}

class Timothy: IHi {
	void hi() {
		writeln("Hi, Timothy!");
	}
}

class Alan: IHi {
	void hi() {
		writeln("Hi, Alan!");
	}
}

class Ria: IHi {
	void hi() {
		writeln("Hi, Ria!");
	}
}
