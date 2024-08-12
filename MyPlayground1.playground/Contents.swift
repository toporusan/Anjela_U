func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
}

func multiply(no1: Int, no2: Int) -> Int {
    return no1 * no2
}

calculator(n1: 3, n2: 6, operation: multiply)

calculator(n1: 3, n2: 6, operation: { no1, no2 in no1 * no2 })

calculator(n1: 5, n2: 6, operation: { no1, no2 in no1 * no2 })

calculator(n1: 5, n2: 6, operation: { $0 * $1 })

calculator(n1: 5, n2: 6) { $0 * $1 }


var array = [6, 7, 8, 9, 3, 4]

func addOne(n1: Int) -> Int {
    return n1 + 1
}

var ar0 = array.map(addOne)
print(ar0)

var ar = array.map{$0 + 1}
print (ar)

var ar3 = array.map{"\($0 + 1)"}
print (ar3)


let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let lowercaseNames = cast.map { $0.uppercased() }
print (lowercaseNames)

let letterCounts = cast.map { $0.count }
print (letterCounts)

