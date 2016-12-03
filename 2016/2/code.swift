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

enum KeyPad : String {
  case One = "1", Two = "2", Three = "3", Four = "4", Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9", A = "A", B = "B", C = "C", D = "D"
  
  var moveMap : Dictionary<Direction, KeyPad> {
    switch self {
      case .One : return [ .Down : .Three ] 
      case .Two : return [ .Right : .Three, .Down : .Six ]
      case .Three : return [ .Up : .One, .Left : .Two, .Right : .Four, .Down : .Seven ]
      case .Four : return [ .Left : .Three, .Down : .Eight ]
      case .Five : return [ .Right : .Six ]
      case .Six : return [ .Up : .Two, .Left : .Five, .Right : .Seven, .Down : .A ]
      case .Seven : return [ .Up : .Three, .Left : .Six, .Right : .Eight, .Down : .B ]
      case .Eight : return [ .Up : .Four, .Left : .Seven, .Right : .Nine, .Down : .C ]
      case .Nine : return [ .Left : .Eight ]
      case .A : return [ .Up : .Six, .Right : .B ]
      case .B : return [ .Up : .Seven, .Left : .A, .Right : .C, .Down : .D ]
      case .C : return [ .Up : .Eight, .Left : .B ]
      case .D : return [ .Up : .B ]
    }
  }
  
  mutating func move(_ direction : Direction) {
    if let nextKeyPad = self.moveMap[direction] {
      self = nextKeyPad
    }
  }
}

var currentKey = KeyPad.Five
var keys = [KeyPad]()

for moves in arguments {
  var move = Direction.directions(moves)
  
  for direction in move {
    currentKey.move(direction)
  }
  
  keys.append(currentKey)
}

print(keys.map { $0.rawValue }.joined())
