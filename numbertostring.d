//Org: http://stackoverflow.com/questions/10923246/c-xna-giant-memory-leak/10924720#10924720 by Andrew Russell Date: 7.6.2012
import std.stdio;

// 11 characters will fit -4294967296
char[11] numberBuffer;

void main() {
    writeln(appendNumber("Number: ".dup, -1024));
}

/// <summary>Append an integer without generating any garbage.</summary>
char[] appendNumber(char[] sb, int number)
{
	bool negative = (number < 0);
	if(negative)
		number = -number;

	int i = numberBuffer.length;
	do
	{
		numberBuffer[--i] = cast(char)('0' + (number % 10));
		number /= 10;
	} while(number > 0);

	if(negative)
		numberBuffer[--i] = '-';

	return sb ~ numberBuffer;
}
