//#second
//Org: d.D.Learn 27.7.2011 - Diego Canuhé
// Bye,
// bearophile
/+
 + It's a dmd bug, and I think it's already in Bugzilla. This is workaround code: - Bearophile said
 +/

//version = First;
version = Second;

import std.stdio;

struct Vecf(uint n) {
    int x;
    Vecf opBinary(string op)(Vecf other) if (op == "+" || op == "-") {
        mixin("return Vecf(this.x " ~ op ~ " other.x);");
    }
}

version( First )
	void main() {
		alias Vecf!1 V;
		auto v1 = V(3);
		auto v2 = V(5);
		auto r = V(-2);
		assert( v1.opBinary!"-"( v2 ) == r );
		assert( v1 - v2 == r );
	}

//#second
struct S {
  void opDispatch(string s, T)(T i)
  {
    writefln("S.opDispatch('%s', %s)", s, i);
  }
}

class C {
  void opDispatch(string s)(int i) {
    writefln("C.opDispatch('%s', %s)", s, i);
  }
}

struct D {
  template opDispatch(string s) {
    enum int opDispatch = 8;
  }
}

version( Second )
	void main() {
	  S s;
	  s.opDispatch!("hello")(7);
	  s.explore(7);

	  auto c = new C();
	  c.rubbish(8);

	  D d;
	  writefln("d.marbles = %s", d.marbles);
	  assert(d.shoes == 8);

	  writefln("d.BombsAndCraters = %s", d.BombsAndCraters );
	  assert(d.BombsAndCraters == 8);
	}
