// https://dlang.org/blog/2020/09/28/function-generation-in-d-the-good-the-bad-the-ugly-and-the-bolt/

template forward(alias fun)
{
  import std.traits: Parameters;
  static foreach (
    ovl; __traits(getOverloads, __traits(parent, fun), __traits(identifier, fun))) {
    auto forward(Parameters!ovl args)
    {
      return ovl(args);
    }
  }
}

int plus(int a, int b) { return a + b; }
string plus(string a, string b) { return a ~ b; }

void main() {

	assert(forward!plus(1, 2) == 3);        // pass
	assert(forward!plus("a", "b") == "ab"); // pass
}
