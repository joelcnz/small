import std.stdio;
import std.typetuple;

void main()
{
    immutable key = 5;
    switch (key)
    {
        foreach (c; TypeTuple!(1, 2, 3, 4, 5))
        {
            case c: "Found %s!".writefln(c);
                    break;
        }
       break; // Default always gets executed without this break.
       default:
           "Not found %s :(".writefln(key);
           break;
   }
}
