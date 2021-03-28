// 17 1 2019 https://forum.dlang.org/post/tioypmysuvvmrzeevvrv@forum.dlang.org

struct Config
{
	string title;
	int width;
	
	auto toString() {
		import std.conv;
		
		return text("Title: ", title, " - Width: ", width);
	}
}

struct Window
{
	this(Config config)
	{
		import std.stdio;
		//use static foreach magic to set everything :P
		writeln(config);
	}
}

auto NewWindow( alias code )()
{
	mixin("Config config = {"~code~"};");
	return Window(config);
}

void main() {
	//usage:
	auto a = NewWindow!q{ title : "MainTitle" };
	auto b = NewWindow!q{ title : "MainTitle", width : 800 };
	auto c = NewWindow!q{ width : 1000 };
	auto d = NewWindow!q{};
}
