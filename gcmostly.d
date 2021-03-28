// D2 version
import std.stdio, std.bigint;
import std.range;

pragma(msg, "------------------"); // this come out crazy (eg. Take - with a captial 't') '-'.repeat.take(17)); //"-------------------");

BigInt countChanges(in int amount, in int[] coins) {
   immutable int n = cast(int)coins.length;
   int cycle = 0;
   foreach (int c; coins)
       if (c <= amount && c >= cycle)
           cycle = c + 1;
   cycle *= n;
   auto table = new BigInt[cycle];
   // table[0 .. n] = 1;
   table[0 .. n] = BigInt(1);
   pragma(msg, "More loops");
   int pos = n;
   for (int s = 1; s <= amount; s++) {
       for (int i = 0; i < n; i++) {
           if (i == 0 && pos >= cycle)
               pos = 0;
           if (coins[i] <= s) {
               immutable int q = pos - (coins[i] * n);
               table[pos] = (q >= 0) ? table[q] : table[q + cycle];
           }
           if (i != 0)
               table[pos] += table[pos - 1];//most time spent here
           pos++;
       }
   }

   return table[pos - 1];
}

void main() {
   const int[] coins = [200, 100, 50, 20, 10, 5, 2, 1];
   writeln(countChanges(10000000, coins));
}

