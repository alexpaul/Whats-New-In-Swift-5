import Foundation

// =================================================================================
//                         Swift 5.0, Xcode 10.2+
// =================================================================================

// Raw Strings - new delimeter #
// the # delimeter treats the entire String as its raw value and inclued any escape characters

var bestTrainingSite = #""The internet's best website for learning iOS, Android and Unity is http://raywenderlich.com" -- Joe User""#
print(bestTrainingSite)

// however if we use string interoplation we will have to include a # sign to indicate our intention
let topic1 = "iOS"
let topic2 = "Android"
let topic3 = "Unity"
bestTrainingSite = #""The internet's best website for learning \#(topic1), \#(topic2), and \#(topic3) is http://raywenderlich.com -- Joe user""#
print(bestTrainingSite)

var longerTweet = #"""
\#(topic1) screencasts at
raywenderlich.com are
"da bomb" #iOS4Ever
"""#
print(longerTweet)


// String Interpolation
// Difference between using CustomStringConvertible and StringInterpolation is that
// you can pass more arguments at runtime when using string interpolation

struct Person: CustomStringConvertible {
  let name: String
  let age: Int
  let dateAdded: Date
  var description: String {
    return "Name is \(name) and age is \(age), added on \(dateAdded)"
  }
}
var alex = Person(name: "Alex", age: 40, dateAdded: Date())
print("Person details: \(alex)")

extension String.StringInterpolation {
  mutating func appendInterpolation(_ value: Person) {
    appendInterpolation("\(value.name) is \(value.age) old")
  }
}
print("\(alex)")

extension String.StringInterpolation {
  mutating func appendInterpolation(_ value: Person, dateFormatterStyle: DateFormatter.Style) {
    let dateFormater = DateFormatter()
    dateFormater.dateStyle = dateFormatterStyle
    let dateString = dateFormater.string(from: value.dateAdded)
    appendInterpolation("\(value.name) was added on \(dateString)")
  }
}
print("\(alex, dateFormatterStyle: .short)")









// =================================================================================
//                         Swift 5.1, Xcode 11+
// =================================================================================


// implicit return from single expressions
// swift evolution: SE-0255

struct Rectangle {
  var width = 0.0, height = 0.0
  var area: Double {
    return width * height
  }
  
  // Swift 5.1, Xcode 11
  //  var area: Double {
  //    width * height
  //  }
}




// Synthesized default values for the memberwise initializer
// Swift Evolution: SE--242
struct Dog {
  var name = "Generic dog name"
  var age = 0
}
let boltNewborn = Dog() // no arguments
let daisyNewborn = Dog(name: "Daisy", age: 0) // all arguments

// Swift 5.1, Xcode 11
// Cannot invoke initializer for type 'Dog' with an argument list of type '(name: String)'
//let benjiNewborn = Dog(name: "Benji")
