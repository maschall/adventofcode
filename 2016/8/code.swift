#!/usr/bin/env xcrun --sdk macosx swift

import Foundation

class Grid {
  var grid = [[Bool]](repeating: [Bool](repeating: false, count: 6), count: 50)
  
  func turnOn(_ x : Int, _ y : Int) {
    for i in 0..<x {
      for j in 0..<y {
        grid[i][j] = true
      }
    }
  }
  
  func rotateColumn(_ x : Int, _ by : Int) {
    let height = grid[x].count
    var temp = grid
    for j in 0..<height {
      temp[x][j] = grid[x][(j - by + height) % height]
    }
    grid = temp
  }
  
  func rotateRow(_ y : Int, _ by : Int) {
    let width = grid.count
    var temp = grid
    for i in 0..<width {
      temp[i][y] = grid[(i - by + width) % width][y]
    }
    grid = temp
  }
  
  func display() {
    for y in 0..<grid[0].count {
      var row = ""
      for x in 0..<grid.count {
        row.append(grid[x][y] ? "#" : ".")
      }
      print(row)
    }
  }
  
  var count : Int {
    var sum = 0
    for y in 0..<grid[0].count {
      for x in 0..<grid.count {
        sum += grid[x][y] ? 1 : 0
      }
    }
    return sum
  }
}

enum Command {
  case rect(Int, Int)
  case rotateColumn(Int, Int)
  case rotateRow(Int, Int)
  case unknown
  
  static func parseCommand(_ command : String) -> Command {
    var argument = command
    if command.hasPrefix("rect ") {
      argument.removeSubrange(argument.startIndex..<argument.index(argument.startIndex, offsetBy: 5))
      let arguments = argument.components(separatedBy: "x")
      return .rect(Int(arguments[0])!, Int(arguments[1])!)
    } else if command.hasPrefix("rotate column x=") {
      argument.removeSubrange(argument.startIndex..<argument.index(argument.startIndex, offsetBy: 16))
      let arguments = argument.components(separatedBy: " by ")
      return .rotateColumn(Int(arguments[0])!, Int(arguments[1])!)
    } else if command.hasPrefix("rotate row y=") {
      argument.removeSubrange(argument.startIndex..<argument.index(argument.startIndex, offsetBy: 13))
      let arguments = argument.components(separatedBy: " by ")
      return .rotateRow(Int(arguments[0])!, Int(arguments[1])!)
    } 
    
    return .unknown
  }
  
  func execute(_ grid : Grid ) {
    switch self {
    case .rect(let x, let y):
      grid.turnOn(x, y)
      break
    case .rotateColumn(let x, let by):
      grid.rotateColumn(x, by)
      break
    case .rotateRow(let y, let by):
      grid.rotateRow(y, by)
      break
    default:
      break
    }
  }
}

func part1(_ arguments : ArraySlice<String>) -> Int {
  let grid = Grid()
  
  for argument in arguments {
    Command.parseCommand(argument).execute(grid)
  }
  
  grid.display()
  return grid.count
}

func part2(_ arguments : ArraySlice<String>) -> Int {
  return 0
}

let arguments = CommandLine.arguments.dropFirst(1)

print(part1(arguments))
print(part2(arguments))