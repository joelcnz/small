struct Person {
        string name;
        int age;

        string toString() {
                import std.string;
                return format("Name: %s, Age: %s", name, age);
        }

}

void main() {
        Person[] ppl;
        ppl ~= Person("Joy", 59);
        ppl ~= Person("Joel", 59);


        ppl ~= Person("Dad", 68);




        ppl ~= Person("Timothy", 31);
}