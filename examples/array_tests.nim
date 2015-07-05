import strutils

var a2 = @[1,2,3]

var a1 = @[1,2,3]


#echo a1[0]
#echo a1[1]
#echo a1[2]
#echo addr(a1[2]).repr

echo "1: ", toHex(cast[int64](a1),16), " repr: ", a1.repr
echo "2: ", toHex(cast[int64](addr(a1)),16), " repr: ", addr(a1).repr
echo "3: ", toHex(cast[int64](addr(a1[0])),16), " repr: ", addr(a1[0]).repr
echo "4: ", toHex(cast[int64](addr(a1[1])),16), " repr: ", addr(a1[1]).repr

#GC_ref(a1)
#GC_unref(a1)
