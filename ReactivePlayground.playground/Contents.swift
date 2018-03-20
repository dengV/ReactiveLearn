//: Playground - noun: a place where people can play

import UIKit

var str = "flatMap ， 平整映射"



print([1, 2, 3, 4].map{ $0 * 2})

print(["ab", "cc", nil, "dd"].map{ $0 })

print(["ab", "cc", nil, "dd"].filter{$0 != nil}.map{ $0! })
 // func flatMap<T>(transform: (Self.Generator.Element) throws -> T?) -> [T]

print(["ab", "cc", nil, "dd"].flatMap{ $0 })



let numbers = [1 , 2, 3, 4]
let result = numbers.map {
    $0 + 2
}
print(result)

let sameResult = numbers.map { num in
    num + 3
}
print(sameResult)


// 它接受 Self.Generator.Element 类型的参数， 这个类型代表数组中当前元素的类型。 而这个闭包的返回值，是可以和传递进来的值不同的。 比如我们可以这样：
// https://swiftcafe.io/2016/03/28/about-map/




let stringResult = numbers.map{
    "NO.\($0)"
}





let resultF = numbers.flatMap{ $0 - 3 }

print(resultF)


let numbersCompound = [[1, 2, 3] , [4, 5, 6]]

let resultMapC = numbersCompound.map{
    $0.map{
        $0 + 4
    }
}
print(resultMapC)

let resultFlatMapC = numbersCompound.flatMap{
    $0.map{$0+3}
}

print(resultFlatMapC)


//flatMap 依然会遍历数组的元素，并对这些元素执行闭包中定义的操作。 但唯一不同的是，它对最终的结果进行了所谓的 "降维" 操作。 本来原始数组是一个二维的， 但经过 flatMap 之后，它变成一维的了。


// func flatMap<S : SequenceType>(transform: (Self.Generator.Element) -> S) -> [S.Generator.Element]



// swift/stdlib/public/core/SequenceAlgorithms.swift.gyb





/*
 > I'm reading the stdlib source code and I see .gyb files. What are those files for?
 
 gyb stands for Generate Your Boilerplate. It’s a preprocessor the Swift team wrote so that when they needed to build, say, ten nearly-identical variants of Int, they wouldn’t have to literally copy and paste the same code ten times. If you open one of those files, you’ll see that they’re mainly Swift code, but with some lines of code intermixed that are written in Python. The actual preprocessor itself is in the Swift source repository at utils/gyb, though most of the code is in utils/gyb.py.

 
 
 https://lists.swift.org/pipermail/swift-users/Week-of-Mon-20151207/000226.html
 
 */




/*
 
 这就和原始数组一样了。 这两者的区别就是这样。 map 函数值对元素进行变换操作。 但不会对数组的结构造成影响。 而 flatMap 会影响数组的结构。再进一步分析之前，我们暂且这样理解。
 */


/*
 
 flatMap 的这种机制，而已帮助我们方便的对数据进行验证，比如我们有一组图片文件名， 我们可以使用 flatMap 将无效的图片过滤掉：
 

 */
