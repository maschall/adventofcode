#!/usr/bin/env xcrun --sdk macosx swift

import Foundation

struct Room {
  let name : String
  let sector : Int
  let checkSum : String
  
  init(_ input : String) {
    do {
      let regex = try NSRegularExpression(pattern : "(.*?)(\\d+)\\[(.*?)\\]$")
    
      let match = regex.matches(in: input, options: [], range: NSMakeRange(0, input.characters.count))[0]
    
      let nsinput = input as NSString
      self.name = nsinput.substring(with: match.rangeAt(1))
      self.sector = Int(nsinput.substring(with: match.rangeAt(2)))!
      self.checkSum = nsinput.substring(with: match.rangeAt(3))
    } catch {
      self.name = ""
      self.sector = 0
      self.checkSum = ""
    }
  }
  
  var frequency : [(key: Character, value: Int)] {
    return name.characters.filter{ $0 != "-" }.reduce([:]) { (accu: [Character: Int], element) in
      var accu = accu
      accu[element] = accu[element]?.advanced(by: 1) ?? 1
      return accu
    }.sorted { (left : (key: Character, value: Int), right : (key: Character, value: Int)) in
      if left.value == right.value {
        return left.key < right.key
      }
      
      return left.value > right.value
    }
  }
  
  var computedCheckSum : String {
    return self.frequency.map{ $0.0 }.prefix(5).reduce("", {$0 + String($1)})
  }
  
  var valid : Bool {
    return self.checkSum == self.computedCheckSum
  }
  
  var decryptedName : String {
    return name.characters.map { (i : Character) -> Character in
      if i == "-" {
        return " "
      } else {
        let a = Int(("a" as UnicodeScalar).value)
        let iInt = Int(UnicodeScalar(String(i))!.value)
        let newi = UnicodeScalar(((iInt - a) + self.sector) % 26 + a)!
        return Character(newi)
      }
    }.reduce("", {$0 + String($1)})
  }
}

func part1(_ arguments : ArraySlice<String>) -> Int {
  let rooms = arguments.map { Room($0) }.filter { $0.valid }
  
  return rooms.reduce(0,{$0 + $1.sector})
}

func part2(_ arguments : ArraySlice<String>) -> Int {
  let rooms = arguments.map { Room($0) }.filter { $0.valid }
  
  return rooms.filter { $0.decryptedName.contains("north") }.first!.sector
}

let arguments = CommandLine.arguments.dropFirst(1)

print(part1(arguments))
print(part2(arguments))