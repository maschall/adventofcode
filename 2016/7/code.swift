#!/usr/bin/env xcrun --sdk macosx swift

import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
}

func abba(_ argument : String ) -> Bool {
  if argument.characters.count > 4 {
    var found = false
    
    var argument = argument
    while argument.characters.count >= 4 {
      found = abba(String(argument.characters.prefix(4)))
      
      if found { break }
      
      argument = String(argument.characters.dropFirst(1))
    }
    
    return found
  } else if argument.characters.count == 4 {  
    return argument[0] == argument[3] && argument[1] == argument[2] && argument[0] != argument[1]
  } else {
    return false
  }
}

func ipabba(_ argument : String ) -> Bool {
  let split = argument.components(separatedBy: ["[", "]"])

  var good = false;

  for (index, element) in split.enumerated() {
    if index % 2 == 0 {
      good = good || abba(element)
    } else if abba(element) {
      return false
    }
    
  }
  
  return good
}

func aba(_ argument : String) -> Bool {
  return argument[0] == argument[2] && argument[0] != argument[1]
}

func bab(_ argument : String) -> String {
  return String([argument[1], argument[0], argument[1]])
}

func allaba(_ argument : String) -> [String] {
  var found : [String] = []
  var argument = argument
  while argument.characters.count >= 3 {
    let possible = String(argument.characters.prefix(3))
    
    if aba(possible) {
      found.append(possible)
    }
    
    argument = String(argument.characters.dropFirst(1))
  }
  
  return found
}

func ipaba(_ argument : String ) -> Bool {
  let split = argument.components(separatedBy: ["[", "]"])

  var outside : [String] = []
  var inside : [String] = []

  for (index, element) in split.enumerated() {
    if index % 2 == 0 {
      outside.append(contentsOf: allaba(element))
    } else {
      inside.append(contentsOf: allaba(element))
    }
  }

  var found = false

  for aba in outside {
    found = inside.contains(bab(aba))
    
    if found { break }
  }
  
  return found
}

func part1(_ arguments : ArraySlice<String>) -> Int {
  return arguments.filter { ipabba($0) }.count
}

func part2(_ arguments : ArraySlice<String>) -> Int {
  return arguments.filter { ipaba($0) }.count
}

let arguments = CommandLine.arguments.dropFirst(1)

print(part1(arguments))
print(part2(arguments))