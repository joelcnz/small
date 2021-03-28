void main() {
  int[] arr;
  int i = -1;

  auto u = (i - arr.length);    // -1 - 0

  assert(u == size_t.max);                   // the surprise
  static assert (is (typeof(u) == size_t));  // the reason
}
