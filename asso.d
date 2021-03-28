//This doesn't work! (in dmd 2.029) - works now and even with dmd 2.031
import std.stdio;       // for writefln()

int main()
{
  // Declare an associative array with string keys and
  // arrays of strings as data
  string[][string] container;

  // Add some people to the container and let them carry some items
  container["Anya"] ~= "scarf";
  container["Anya"] ~= "wallet";
  container["Dimitri"] ~= "tickets";
  container["Anya"] ~= "puppy";

  // Iterate over all the persons in the container
  foreach( person, string[] items; container)
      display_item_count(person, items);

  return 0;
}

void display_item_count(string person, string[] items)
{
  writefln(person~" is carrying %d item%s",items.length,items.length==1 ? "" : "s");
	foreach(i,item;items)
		writefln("    Item %d - %s",i+1,item);
}
