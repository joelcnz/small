// Must've got this from someone else.
mixin template get_set_accessor(Type, string name) {
    static string codeGenerationHelper() {
        string code;
        // the variable
        code ~= "private Type _" ~ name ~ ";";

        // the getter
        code ~= "public @property Type " ~ name ~ "() { return _" ~ name ~ "; }";

        // the setter
        code ~= "public @property Type " ~ name ~ "(Type a) { return _" ~ name ~ " = a; }";

        return code;
    }

    mixin(codeGenerationHelper());
}

// here's how to use it
struct Person {
    mixin get_set_accessor!(string, "name");
    mixin get_set_accessor!(int,    "age");
	
	string toString() const {
		import std.string : format;

		return format!"Name: %8s, Age: %s"(_name, _age);
	}
}

void main() {
	Person[] ppl;

	ppl ~= Person("Joel", 35);
	ppl ~= Person("Timothy", 32);

	import std.stdio : writeln;
	import std.algorithm : each;

	ppl.each!writeln;
}
