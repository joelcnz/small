//http://forum.dlang.org/thread/fcfhhbwcumzsvmuwumtn@forum.dlang.org - bearophile
//http://leonardo-m.livejournal.com/108490.html
import std.stdio, std.string,std.random, std.array;

alias char Cell;

Cell[][] makeMines(in uint width, in uint height,
                   in uint mineCount)
in {
    assert(width > 0);
    assert(height > 0);
    assert(mineCount > 0);
    assert(mineCount <= width * height);
} out(mat) {
    assert(mat.length == height);
    int nMines = 0;
    foreach (row; mat) {
        assert(row.length == width);
        nMines += count(row, '*');
        assert(row.countchars("*.12345678") == width);
    }
    assert(nMines == mineCount);
} body {
    enum gInit = '0';
    enum mine = '*';

    auto grid = new Cell[][](height, width);
    foreach (row; grid)
        row[] = gInit;

    for (uint nMines = 0; nMines < mineCount; ) {
        immutable int x = uniform(0, width);
        immutable int y = uniform(0, height);
        if (grid[y][x] != mine) {
            grid[y][x] = mine;
            nMines++;
            foreach (int sy; -1 .. 2)
                if (y + sy >= 0 && y + sy < height)
                    foreach (int sx; -1 .. 2)
                        if (x + sx >= 0 && x + sx < width
                            && grid[y + sy][x + sx] != mine)
                            grid[y + sy][x + sx]++; // Next char
        }
    }

    foreach (ref row; grid)
        row = row.replace([gInit], ".");
    return grid;
}

void main() {
    writefln("%-(%s\n%)", makeMines(15, 15, 21));
}
