import Foundation

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
