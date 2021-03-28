pragma(lib, "libjeca");

import std.stdio;
import std.string;
import std.array;
import jeca.misc;

void main() {
	auto paragraphs = split(getTextClipBoard(), (newline ~ newline).dup);

    string result;
    foreach(paragraph; paragraphs)
        result ~= unWrap(paragraph) ~ newline;
    setTextClipboard(result);
    write(result);
}

string unWrap(string paragraph) {
    auto segments = split(paragraph, newline.dup);
     string result;
    foreach(i, segment; segments)
        result ~= segment ~ (i != segments.length - 1 ? " " : "");
    return result;
}
