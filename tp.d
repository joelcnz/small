/*
Edited by Joel for Unix system (just for him self)

File: tp.d
Purpose: A simple text pager.
Version: 0.1
Platform: Windows-only.
May be adaptable for Unix using tty / termios calls.
Only the use of getch() may need to be changed.
Author: Vasudev Ram
Copyright 2017 Vasudev Ram
Web site: https://vasudevram.github.io
Blog: https://jugad2.blogspot.com
Product store: https://gumroad.com/vasudevram
Twitter: https://mobile.twitter.com/vasudevram
*/

import std.stdio;
import std.string;
import std.file;

auto getch() {
	import std.stdio : readln;
	import std.string : chomp;
	return readln.chomp;
}

void usage(string[] args) {
    stderr.writeln("Usage: ", args[0], " text_file");
    stderr.writeln("or");
    stderr.writeln("command_generating_text | ", args[0]);
}

void pager(File in_fil, int lines_per_page=12, char quit_key='q')
{
    assert (lines_per_page > 1);
    int line_count = 0;
    string c;
    foreach (line; in_fil.byLine()) {
        writeln(line);
        line_count++;
        if ( (line_count % lines_per_page) == 0) {
            stdout.flush();
            c = getch();
            if (c == "q")
                break;
            else
                line_count = 0;
        }
    }
}

int main(string[] args) {

    int lines_per_page = 20;
    File in_fil;

    try {
        if (args.length > 2) {
            usage(args);
            return 1;
        }
        else {
            if (args.length == 2) {
                in_fil = File(args[1]);
            }
            else {
                in_fil = stdin;
            }
            pager(in_fil, lines_per_page, 'q');
        }
    } catch (FileException fe) {
        stderr.writeln("Caught FileException: msg = ", fe.msg);
    } catch (Exception e) {
        stderr.writeln("Caught Exception: msg = ", e.msg);
    }
    finally {
        in_fil.close();
    }
    return 0;
}
