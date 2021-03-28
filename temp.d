void main() {
	
	import std.array : array;
	import std.algorithm : remove, count, filter;
	int[] arr = [1,2,44,3,7,4];
//	foreach(itemNum; [44, 7])
//		arr = remove(arr, arr.count(itemNum) + 1);
	//arr = remove(arr, arr.count(44) + 1, arr.count(7) + 1); //not work!
	
	arr = arr.filter!((a) => a != 44 && a != 7).array;
	
	assert(arr == [1, 2, 3, 4]);
}