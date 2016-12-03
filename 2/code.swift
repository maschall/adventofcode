#!/usr/bin/env xcrun --sdk macosx swift

let arguments = CommandLine.arguments.dropFirst(1)

enum Direction : Character {
  case Up = "U", Down = "D", Left = "L", Right = "R"
  
  static func directions(_ order : String) -> [Direction] {
    var directions = [Direction]()
    for direction in order.characters {
      directions.append(Direction(rawValue: direction)!)
    }
    return directions
  }
}

enum KeyPad : Int {
  case One = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine, A, B, C, D
  
  mutating func move(_ direction : Direction) {
    switch self {
      case .One:
        self = direction == .Down ? .Three : self
        break
      case .Two:
        switch direction {
          case .Right: 
            self = .Three
            break
          case .Down:
            self = .Six
            break
          default:
            break
        }
        break
      case .Three:
        switch direction {
          case .Up: 
            self = .One
            break
          case .Left:
            self = .Two
            break
          case .Right: 
            self = .Four
            break
          case .Down:
            self = .Seven
            break
        }
        break
      case .Four:
        switch direction {
          case .Left:
            self = .Three
            break
          case .Down:
            self = .Eight
            break
          default:
            break
        }
        break
      case .Five:
        switch direction {
          case .Right: 
            self = .Six
            break
          default:
            break
        }
        break
      case .Six:
        switch direction {
          case .Up: 
            self = .Two
            break
          case .Left:
            self = .Five
            break
          case .Right: 
            self = .Seven
            break
          case .Down:
            self = .A
            break
        }
        break
      case .Seven:
        switch direction {
          case .Up: 
            self = .Three
            break
          case .Left:
            self = .Six
            break
          case .Right: 
            self = .Eight
            break
          case .Down:
            self = .B
            break
        }
        break
      case .Eight:
        switch direction {
          case .Up: 
            self = .Four
            break
          case .Left:
            self = .Seven
            break
          case .Right: 
            self = .Nine
            break
          case .Down:
            self = .C
            break
        }
        break
      case .Nine:
        switch direction {
          case .Left:
            self = .Eight
            break
          default:
            break
        }
        break
      case .A:
        switch direction {
          case .Up: 
            self = .Six
            break
          case .Right: 
            self = .B
            break
          default:
            break
        }
        break
      case .B:
        switch direction {
          case .Up: 
            self = .Seven
            break
          case .Left:
            self = .A
            break
          case .Right: 
            self = .C
            break
          case .Down:
            self = .D
            break
        }
        break
      case .C:
        switch direction {
          case .Up: 
            self = .Eight
            break
          case .Left:
            self = .B
            break
          default:
            break
        }
        break
      case .D:
        switch direction {
          case .Up: 
            self = .B
            break
          default:
            break
        }
        break
    }
  }
}

var currentKey = KeyPad.Five

for moves in arguments {
  var move = Direction.directions(moves)
  
  for direction in move {
    currentKey.move(direction)
  }
  
  print(currentKey)
}
