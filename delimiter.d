// code file from http://tech.adroll.com/blog/data/2014/11/17/d-is-for-data-science.html
// %> time rdmd parser.d log.txt > country_info
import std.stdio;
import std.string;

static immutable uint TIMESTAMP_INDEX = 19;
static immutable uint COUNTRY_INDEX = 42;
static immutable char DELIMITER = cast(char)30;

void main(string[] args) {
    auto file = File(args[1], "r");
    foreach(char[] line; file.byLine()) {
        char[][] fields = split(line, DELIMITER);
        writefln("%s\t%s",
                 fields[TIMESTAMP_INDEX],
                 fields[COUNTRY_INDEX]);
    }
    file.close();
}
