module qsort;

class QuickSort(T) {
	private T[] items;

	public void quickSort(T[] values) {
		// Check for empty or null array
		if (values.length==0) {
			return;
		}
		this.items = values;
		quickSort(0, cast(int)values.length - 1);
	}

	private void quickSort(int low, int high) {
		int i = low, j = high;

		// Get the pivot element from the middle of the list
		T pivot = items[low + (high-low)/2];

		// Divide into two lists
		while (i <= j) {
			T check(T item) {
				static if (is(T == string))
					return item.toLower;
				else
					return item;
			}
				
			// If the current value from the left list is smaller then the pivot
			// element then get the next element from the left list
			while (check(items[i]) < check(pivot)) {
				i++;
			}
			// If the current value from the right list is larger then the pivot
			// element then get the next element from the right list
			while (check(items[j]) > check(pivot)) {
				j--;
			}

			// If we have found a values in the left list which is larger then
			// the pivot element and if we have found a value in the right list
			// which is smaller then the pivot element then we exchange the
			// values.
			// As we are done we can increase i and j
			if (i <= j) {
				exchange(i, j);
				i++;
				j--;
			}
		}
		// Recursion
		if (low < j)
			quickSort(low, j);
		if (i < high)
			quickSort(i, high);
	}

	private void exchange(int i, int j) {
		T temp = items[i];
		items[i] = items[j];
		items[j] = temp;
	}
}

import std.stdio;
import std.numeric;
import std.random;
import std.string;

void blockLine(T)(T length) {
	foreach(x; 0..length)
		write('#');
}

void draw(T)(T[] lines) {
	foreach(line; lines)
		blockLine(line),
		writeln();
}

void main() {
	auto qsortInt = new QuickSort!int();
	auto data = [42,64,1979,30,37,25,7];
	draw(data);
	with(qsortInt) {
		quickSort(data);
		draw(items);
	}
	
	auto qsortDouble = new QuickSort!double();
	auto data2 = [1.1,2.2,3.3,9.9,8.8,7.7];
	with(qsortDouble) {
		writeln(data2);
		quickSort(data2);
		writeln(items);
	}
	
	auto qsortString = new QuickSort!string();
	auto data4 = "House Cat Rock Grass house cat rock grass".split();
	with(qsortString) {
		writeln(data4);
		quickSort(data4);
		writeln(items);
	}

	float[] data3;
	foreach(x; 0..50)
		data3 ~= uniform(0f,10f);
	auto qsortFloat = new QuickSort!float();
	with(qsortFloat) {
		writeln(data3);
		quickSort(data3);
		writeln(items);
	}
}
