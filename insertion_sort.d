// https://z0ltan.wordpress.com/2017/02/21/goodbye-rust-and-hello-d/
// insertion_sort.d
import std.stdio;
 
void insertionSort(int[] arr) {
    foreach(i; 1..arr.length) {
        int key = arr[i];
        int j = cast(int)i-1;
         
        while (j >= 0 && arr[j] > key) {
            arr[j+1] = arr[j];
            j--;
        }
        arr[j+1] = key;
    }
}
 
void main() {
    int[] array = [100,-199,0,20,2,3,4,5,0,0,1,200];
     
    writefln("Before sorting: %s", array);
     
    insertionSort(array);
     
    writefln("After sorting: %s", array);
}
