// https://z0ltan.wordpress.com/2017/02/21/goodbye-rust-and-hello-d/
// line_closure.d
import std.stdio;
 
void delegate() getLineClosure() {
    int lineNum = 0;
     
    void printLineNumber() {
        lineNum++;
         
        writefln("Current line: %s", lineNum);
    }
     
    return &printLineNumber;
}
 
void main() {
    void delegate() x = getLineClosure();
     
    foreach(i; 0..5) {
        x();
    }
    writeln();
     
    void delegate() y = getLineClosure();
     
    foreach(j; 0..3) {
        y();
    }
}
