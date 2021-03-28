//Org: http://www.drdobbs.com/architecture-and-design/function-purity-and-immutable-data-struc/240169087

struct T {
  immutable(int)* p = null;
  this(immutable(int)* q) pure {
    p = q;
  }
}
 
void foo() {
  immutable int y;
  immutable(T) p1 = T(&y);
  immutable(T)* p2 = new T(&y);
  immutable(T)* p3 = new T(new int);
}

void main() {
	import std.stdio;
	T t;
	immutable(int) seventy = 70;
	t.p = &seventy;
	writeln(t.p);
	foo;
}

version(none) {
struct T {
  immutable(int)* p = null;
  this(immutable(int)* q) pure {
    p = q;
  }
}
 
void foo() {
  immutable int y;
  immutable(T) p1 = T(&y);
  immutable(T)* p2 = new T(&y);
  immutable(T)* p3 = new T(new int);
})
