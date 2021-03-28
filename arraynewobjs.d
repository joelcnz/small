import std.stdio;

void main() {
	auto list = [ cast( A )new B("Mr B"), new C("Mr C"), new B("Mr B the younger") ];
	
	foreach(mr; list)
		writeln(mr.name);
}

abstract class A {
	string _name;
	
	string name() { return _name; }
	void name(string name0) { _name = name0; }
}

immutable ctor = "
	this(string name0) {
		_name = name0;
	}
";

class B : A { mixin(ctor); }

class C : A { mixin(ctor); }
