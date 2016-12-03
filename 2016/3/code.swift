#!/usr/bin/env xcrun --sdk macosx swift

func possibleTriangle(_ sides: [Int]) -> Bool {
  let triange = sides.sorted()
  
  return triange[0] + triange[1] > triange[2]
}

func part1(_ arguments : ArraySlice<String>) -> Int {
  var count = 0

  for line in arguments {
    let sides = line.characters.split(separator: " ").map(String.init).map { Int($0)!}
  
    if possibleTriangle(sides) {
      count += 1
    }
  }
  
  return count
}

func part2(_ arguments : ArraySlice<String>) -> Int {
  var rows = [[Int]]()
  for line in arguments {
    rows.append(line.characters.split(separator: " ").map(String.init).map { Int($0)!})
  }
  
  var triangles = [[Int]]()
  for i in stride(from: 0, to: rows.count, by: 3) {
    triangles.append([rows[i][0], rows[i+1][0], rows[i+2][0]])
    triangles.append([rows[i][1], rows[i+1][1], rows[i+2][1]])
    triangles.append([rows[i][2], rows[i+1][2], rows[i+2][2]])
  }
  
  triangles = triangles.filter { possibleTriangle($0) }
  
  return triangles.count
}

let arguments = CommandLine.arguments.dropFirst(1)

print(part1(arguments))
print(part2(arguments))