//will not work

void main() {
var a = 10;
var b = "20";
var c = a + b;
var d = json!q{ "foo": { "bar": 10.2 } };
writeln(d.foo); // {"bar":10.2}
d.foo.bar = (var a) => a ~ b;
writeln(d.foo.bar()("hello! "));
}