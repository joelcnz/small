// from D CookBook
void main() {
  import std.zlib, std.file;
  auto compressor = new Compress(HeaderFormat.gzip);
  void[] compressedData;
  compressedData ~= compressor.compress("Hello, ");
  compressedData ~= compressor.compress("world!");
  compressedData ~= compressor.flush();
  std.file.write("compressed.gz", compressedData);
}

