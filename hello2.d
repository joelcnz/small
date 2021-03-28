import std.stdio;
import std.algorithm;
import std.conv;

struct Book
{
	string title;
	int pages;

	string toString() const {
		return text(title, " ", pages);
	}
}

void main()
{
	writeln("Hello world");

	int[] array = [5,7,34,2,6,5,8];

	writeln(array.sort!"a > b");

	Book[] books = [Book("How to bake Cakes",    54),
					Book("How to destroy Rocks", 34),
					Book("How to mend Shoes",    70)];

	writeln(books.sort!"a.pages < b.pages");
	writeln(books.sort!"a.title < b.title");

	writeln("\n", "Title, and pages:");
	foreach(book; books.sort!"a.pages < b.pages")
		writeln(book);
}
