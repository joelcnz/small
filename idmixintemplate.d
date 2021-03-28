struct Quantity(Id) {int value;}
mixin template BasicUnit(string name) {
	struct Id {}
	mixin("enum " ~ name ~ " = Quantity!Id(1);");
}

void main() {
	struct Foo {mixin BasicUnit!"x";}
	struct Bar {mixin BasicUnit!"x";}
	static assert(!is(typeof(Foo.x) == typeof(Bar.x)));
}
