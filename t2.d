import std.stdio;

void main()
{
    writeln("<html>");
    scope(exit) writeln("</html>");

    {
        writeln("  <head>");
        scope(exit) writeln("  </head>");
        "    <title>%s</title>".writefln("Hello");
    }

    writeln("  <body>");
    scope(exit) writeln("  </body>");

    writeln("    <h1>Hello World!</h1>");
}
