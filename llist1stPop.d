// 21 4 2019 - code worked first pop!
module llist6;

import std.stdio, std.conv, std.string, std.algorithm, std.array;

struct List(T) {
    class Node {
        T data;
        Node next;
        this(T data) {
            this.data = data;
        }
    }
    Node head;
    void opOpAssign(string op)(T data) if (op == "~") {
        auto node = new Node(data);
        if (head is null)
            head = node;
        else {
            auto current = head;
            while(current.next) {
                current = current.next;
            }
            current.next = node;
        }
    }
    string toString() {
        string result;
        auto current = head;
        int i;
        while(current) {
            result ~= text(" ".replicate(i), current.data, "\n");
            i += 1;
            current = current.next;
        }
        return result;
    }
}

void main(string[] args) {
    args = args[2 .. $];
    auto list = List!string();
    args.each!(e => list ~= e);
    write(list);
}
