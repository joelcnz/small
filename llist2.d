/// Simple doublely Linked list program
module linklist2;

import std.stdio, std.conv, std.string, std.algorithm, std.array;

/// Double Linked List structure
struct List(T) {
    /// Node class
    class Node {
        T data; /// Payload
        Node prev, /// pointer
            next; /// pointer
        /// Constucter
        this(T data) {
            this.data = data;
        }
    }
    Node head, /// node
        tail; /// node
    /// add to end
    auto append(T data) {
        auto node = new Node(data);
        if (! head)
            head = tail = node;
        else {
            node.prev = tail;
            tail.next = node;
            tail = node;
        }
        return this;
    }
    /// add to start
    auto prepend(T data) {
        auto node = new Node(data);
        if (! head)
            head = tail = node;
        else {
            node.next = head;
            head.prev = node;
            head = node;
        }
        return this;
    }
    /// for foreach loop
    int opApply(int delegate(T) dg) {
        int result;
        auto current = head;
        while(current) {
            auto t = current.data;
            if ((result = dg(t)) != 0) break;
            current = current.next;
        }
        return result;
    }
    auto toString() {
        string result;
        auto current = head;
        while(current) {
            result ~= text(current.data, "\n");
            current = current.next;
        }
        return result;
    }
}

/// Programs main entry point
void main() {
    auto list = List!string();
    "I went for a walk and fell down a hole.".split.each!(a => list.append(a));
    write(list);

    auto list2 = List!string();
    foreach(word; list)
        list2.append(word);
    write(list2);

    auto current = list.head;
    while(current) {
        write(current.data, (current.next) ? " " : "");
        current = current.next;
    }
    writeln;
}
