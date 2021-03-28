// 18 9 2020
void main() {
	import std.algorithm : sort;
	auto foo = [new B(1), new B(5), new B(2)];
	foo.sort!((a,b) => a.buzz > b.buzz);
}

class A {
	int fizz;
}

final class B : A {
	int buzz;
	this(int buzz) {
		this.fizz = fizz;
	}
}