import std.traits;

void showFunctionDetails(alias func)() {
  import std.stdio;

  writeln("        Name: ",
    __traits(identifier, func));
  writeln("     Returns: ",
    ReturnType!func.stringof);
  writeln("   Arguments: ",
    ParameterTypeTuple!func.stringof);
  writeln("   Arg names: ",
    ParameterIdentifierTuple!func.stringof);
  writeln("Arg defaults: ",
    ParameterDefaultValueTuple!func.stringof);
}

string testFunction(int hay, string str = "you got value?") { return "Guts"; }

void main() {
  showFunctionDetails!testFunction();
}

