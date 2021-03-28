import std.stdio;

void main() {
	import std.conv;
	enum DeadWood : char {BRICK = 'B', DARK_BRICK = 'b'};
	writeln("With writefln \\/");
	writefln("DeadWood.BRICK -%s-", DeadWood.BRICK);
	writefln("cast(char)DeadWood.BRICK -%s-", cast(char)DeadWood.BRICK);
	assert(DeadWood.BRICK == 'B');
}
