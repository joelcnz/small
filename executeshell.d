import std.stdio;
import std.process;

void main() {
//    const result = executeShell("ls -l deneme");
    const result = executeShell("ls -l ");
    const returnCode = result[0];
    const output = result[1];

    writefln("ls returned %s.", returnCode);
    writefln("Its output:\n%s", output);
}

