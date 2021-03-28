import std.stdio;
import std.string;
import std.conv;
 
void main() {
  string namestmp = "Joel Ria Lahtrell Katherine Timothy Chris Hamish";
  auto names = namestmp.split;
  int longest;

  import std.range;
  import std.algorithm;
  
  names.sort!"a.length > b.length";
  
	if (names[$-1].length > names[0].length)
		longest = cast(int)names[$-1].length;
	else 
  		longest = cast(int)names[0].length;

  /*
  for (int i = 0; i < names.length; i++) {
    if (names[i].length > longest)
      longest = names[i].length;
    for (int i2 = i + 1; i2 < names.length; i2++)
      if (names[i].length > names[i2].length) {
        auto tmp = names[i];
        names[i] = names[i2];
        names[i2] = tmp;
      }
  }
 */
  
  // neat part
  auto form = "%+" ~ longest.to!string ~ "s: %s";
  foreach (name; names)
    writefln(form, name, name.length);
}
