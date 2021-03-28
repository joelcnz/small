void main() {
    import std.stdio : writeln, readln;
    import std.string : chomp;

    struct Person {
        string name;
        int age;

        string toString() {
            import std.string : format;

            return format("Name: %7s Age: %s", name, age);
        }
    }
    Person[] people;
    Person person;

    string getString() {
        return readln.chomp;
    }

    int getNumber(in string title) {
        import std.conv : to;

        writeln(title);
        return getString.to!int;
    }

    while(true) {
        writeln("Enter your name (or q to finish)?");
        person.name = getString;

        if (person.name == "q")
            break;

        person.age = getNumber("How many years old are you?");

        people ~= person;
    }

    import std.algorithm : each, sort;
    //people.sort!((a, b) => a.age > b.age);
    people.sort!"a.age > b.age";

    people.each!writeln;

    void graph(in string name, in string type, in int count, in string piece) {
        import std.array : replicate;
        import std.string : format;

        writeln(format("%10s", name), ", ", type, ": ", piece.replicate(count));
    }
    people.each!(p => graph(p.name, "Age", p.age, "_"));
}
