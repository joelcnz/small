module linklisttest;

import std.stdio, std.conv, std.string, std.algorithm, std.traits;

struct List(T) {
    class Node {
        T data;
        Node next;
        this(T data) {
            this.data = data;
        }
        override string toString() const {
            return data.to!string;
            //return "[" ~ data.to!string ~ "]";
        }
    }
    Node head;
    void opOpAssign(string op)(T data) if (op == "~") {
        auto newNode = new Node(data);
        if (! head)
            head = newNode;
        else {
            auto current = head;
            while(current.next) {
                current = current.next;
           }
           current.next = newNode;
        }
    }
    string toString() {
        string result;
        auto current = head;
        while(current) {
            result ~= current.to!string ~ "\n";
            current = current.next;
        }
        return result;
    }
    int total() {
        int total;
        static if (isNumeric!T) {
            auto current = head;
            while(current) {
                total += current.data.to!int;
                current = current.next;
            }
        }
        return total;
    }
}

void main() {
    auto list = List!int();
    "Enter some text:".writeln;
    readln.split.each!(a => list ~= a.to!int);
    list.write;
    writeln("Total: ", list.total);
}
