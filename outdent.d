import std.stdio;
import std.string;

void main() {
writeln(q{
    import std.stdio;
    void main() {
        writeln("Hello");
    }
}.outdent());

// fail!
writeln("
	import std.stdio;
	void main() {
		writeln(`Hello`);
	}
".outdent());
}
