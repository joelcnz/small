void main() {
	import std.conv : to;
	import std.string : replace;

	"”"d.replace("”", `"`); // crashes with a range error
}