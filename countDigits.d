import std.stdio;

uint digits10(uint v) {

    uint result = 0;

    while(v /= 10) {

        ++result;
	};

     return result;

}

void main() {
	writeln(digits10(1));
	writeln(digits10(12345));
}
