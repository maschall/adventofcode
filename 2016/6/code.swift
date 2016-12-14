#!/usr/bin/env xcrun --sdk macosx swift

func part1(_ arguments : ArraySlice<String>) -> String {
  let strings = arguments.reduce([]) { (accu: [String], element) in
      var accu = accu
      for (index, char) in element.characters.enumerated() {
        if accu.count <= index {
          accu.append(String(char))
        } else {
          accu[index].append(char)
        }
      }
      return accu
    }.map { $0.characters.reduce([:]) { (accu: [Character: Int], element) in
      var accu = accu
      accu[element] = accu[element]?.advanced(by: 1) ?? 1
      return accu
    }.sorted { (left : (key: Character, value: Int), right : (key: Character, value: Int)) in
      return left.value > right.value
    }.map{ $0.0 }.prefix(1).reduce("", {$0 + String($1)}) }
  
  return strings.joined(separator: "")
}

func part2(_ arguments : ArraySlice<String>) -> String {
  let strings = arguments.reduce([]) { (accu: [String], element) in
      var accu = accu
      for (index, char) in element.characters.enumerated() {
        if accu.count <= index {
          accu.append(String(char))
        } else {
          accu[index].append(char)
        }
      }
      return accu
    }.map { $0.characters.reduce([:]) { (accu: [Character: Int], element) in
      var accu = accu
      accu[element] = accu[element]?.advanced(by: 1) ?? 1
      return accu
    }.sorted { (left : (key: Character, value: Int), right : (key: Character, value: Int)) in
      // THIS IS ONLY DIFF
      return left.value < right.value
    }.map{ $0.0 }.prefix(1).reduce("", {$0 + String($1)}) }
  
  return strings.joined(separator: "")
}

let arguments = CommandLine.arguments.dropFirst(1)

print(part1(arguments))
print(part2(arguments))