#!/usr/bin/env xcrun --sdk macosx swift

import Foundation

func decompress(_ argument : String) -> Int {
  var sum = 0
  
  var oldFile = argument
  
  while oldFile.characters.count > 0 {
    let split = oldFile.components(separatedBy: ["(", "x", ")"])
    
    let nonCommand = split[0]
    oldFile.removeSubrange(oldFile.startIndex..<oldFile.index(argument.startIndex, offsetBy: "\(nonCommand)".characters.count))
    sum += nonCommand.characters.count
  
    if split.count > 1 {    
      let count = Int(split[1])!
      let times = Int(split[2])!

      oldFile.removeSubrange(oldFile.startIndex..<oldFile.index(argument.startIndex, offsetBy: "(\(count)x\(times))".characters.count))
      
      let range = oldFile.startIndex..<oldFile.index(argument.startIndex, offsetBy: count)
      oldFile.removeSubrange(range)
      
      sum += count * times
    }
  }
  return sum
}

func decompress2(_ argument : String) -> Int {
  var sum = 0
  
  var oldFile = argument
  
  while oldFile.characters.count > 0 {
    let split = oldFile.components(separatedBy: ["(", "x", ")"])
    
    let nonCommand = split[0]
    oldFile.removeSubrange(oldFile.startIndex..<oldFile.index(argument.startIndex, offsetBy: "\(nonCommand)".characters.count))
    sum += nonCommand.characters.count
  
    if split.count > 1 {    
      let count = Int(split[1])!
      let times = Int(split[2])!

      oldFile.removeSubrange(oldFile.startIndex..<oldFile.index(argument.startIndex, offsetBy: "(\(count)x\(times))".characters.count))
      
      let range = oldFile.startIndex..<oldFile.index(argument.startIndex, offsetBy: count)
      let str = oldFile[range]
      oldFile.removeSubrange(range)
      
      let decompressedCount = decompress2(str)
      sum += decompressedCount * times
    }
  }
  return sum
}

func part1(_ arguments : ArraySlice<String>) -> Int {
  let argument = arguments.first!
  
  return decompress(argument)
}

func part2(_ arguments : ArraySlice<String>) -> Int {
  let argument = arguments.first!
  
  return decompress2(argument)
}

let arguments = CommandLine.arguments.dropFirst(1)

print(part1(arguments))
print(part2(arguments))