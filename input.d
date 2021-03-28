/// Peoples details program
module input;

import std.stdio, std.conv, std.string, std.algorithm, std.range;

/// Message to user, used for error
string message;

/// get input name or age
auto getInput(in string header) {
    writeln(header);
    return readln.chomp;
}

/// for input age
auto getNum(in string input) {
    int result;
    try
        result = input.to!int;
    catch(Exception e) {
        message = "Number convert fail!";
        return -1;
    }
    message = "";
    return result;
}

/// get person info
auto getPerson() {
    auto name = getInput("Enter your name (or enter to finish):");
    if (! name.length)
        return Person("", 0);
    int age;
    do {
        age = getNum(getInput("Enter your age:"));
        writeln(message);
    } while(message.length);
    return Person(name, age);
}

/// Person for name and age
struct Person {
    string name; /// name of person
    int age; /// age of person
    string toString() const {
        return name ~ " " ~ age.to!string;
    }
}

/// main entry point
void main() {
    Person[] ppl;
    writeln("Enter names and ages.");
	bool done = false;
    do {
        ppl ~= getPerson;

		if (! ppl[$ - 1].name.length)
			done = true;
		else
	        writeln("So your name is ", ppl[$ - 1].name, " and your age is ", ppl[$ - 1].age, " years old.");
    } while(! done);
    writeln("\nOk peoples!");
    ppl.dropBack(1).each!(p => writeln(p));
}
