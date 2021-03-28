//#Org: D.learn ng by Steve Teale -- 17 Oct 2011
import std.stdio;

bool glob;

struct Sentinel
{
   void function() doit;
   bool already;
   this(void function() f)
   {
      doit = f;
      already = false;
   }

   ~this()
   {
      if (!already)
      {
         writeln("Doing it now");
         doit();
      }
      else
         writeln("Won't bother");
   }

   void dontBother() { already = true; }
}

void reset() { glob = false; }

void main(string[] args)
{
   glob = true;
   {
      Sentinel s = Sentinel(&reset);
      writeln("Doing stuff in the scope");
      if (args.length >= 2 && args[1] == "db")
         s.dontBother();
   }
   writeln(glob);
}
