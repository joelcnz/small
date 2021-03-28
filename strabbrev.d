import std.stdio;
import std.string;

void main()
{
//   static string[] list = [ "food", "foxy" ];
//   static string[] list = [ "rocks", "shoes" ];
   static string[] list = [ "Joel", "John" ];

   auto abbrevs = std.string.abbrev(list);

   foreach (key, value; abbrevs)
   {
      writefln("%s => %s", key, value);
   }
}
