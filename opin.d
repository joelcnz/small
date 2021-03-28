#! /usr/bin/env rdmd
  import std.stdio;

  struct X {
      string data;

      bool opBinary(string op)(char p) if (op == "in") {
          foreach (c; data)
              if (p == c) return true;
          return false;
      }
  }

  void main() {
      auto x = X("hi there");
      writeln(x in 'i');
      writeln(x in '?');
  }
  