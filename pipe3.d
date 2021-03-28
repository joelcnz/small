// http://ddili.org/ders/d.en/stream_redirect.html
// pipe3 > pipe3_result.txt

import std.stdio;

void main()
{
    double number;
    readf(" %s", &number);

    writeln(number * 2);
}
