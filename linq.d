//http://forum.dlang.org/thread/kfrcjmouzltfcycuctpe@forum.dlang.org#post-fzndryndbpkaccovqlkr:40forum.dlang.org

void main() {
    import std.stdio, std.range, std.algorithm, std.typecons;

    iota(2, 12)
    .map!(c => tuple(c ^^ 2 - 1, c ^^ 2 + 1, 2 * c))
    .each!(x => writefln("%3d%4d%4d", x[]));
}
