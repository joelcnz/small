import std.stdio;
import std.ascii;
import std.regex;

void main() {
    //auto input = "sdaz..1.5.;[";
    auto input = "sdaz..3.7.;[";
    auto pattern = ctRegex!(`([^-0-9.]*)([-0-9.]+)(.*)`);
    auto m = input.matchFirst(pattern);

    auto sortOutInputToNumber(in string input, out bool foundNumber) {
        bool foundDot = false;
        string result;
        break1: foreach(c; input) {
            if (c.isDigit) {
                foundNumber = true;
                result ~= c;
            } else if (c == '.') {
                if (! foundDot) {
                    foundDot = true;
                    result ~= '.';
                } else if (foundNumber) {
                    break break1;
                }
            }

            if (! foundDot && c == '.') {
                foundDot = true;
            }
        }

        return result;
    }

    bool foundNumber = false;
    auto result = sortOutInputToNumber(m[2], foundNumber);

    write("From: ", [m[2]]);
    if (! foundNumber) {
        writeln(" Couldn't get a number from input! -> ", result);
        return;
    }

    import std.conv;
    writeln(" result chars: ", [result], " to number: ", [result.to!float]);
/+
    if (m)  {
        assert(m[0] == input);    // whole
        assert(m[1] == "sdaz");         // before
        assert(m[2] == "1.5.");          // number
        assert(m[3] == ";[");           // after
    }
+/
}
