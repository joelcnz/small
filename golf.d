void main(){import std.stdio;int t,n;readf(" %d",&t);while(t--){readf(" %d",&n);real a=0,i=0;for(;i<n;i++)a+=(i%2?-1:1)/(i+i+1);writefln("%.15f",a);}}
