#!/usr/bin/env xcrun --sdk macosx swift

enum Turn : String {
  case Left = "L"
  case Right = "R"
  
  var spinValue: Int {
    switch self {
      case .Left: return -1
      case .Right: return 1
    }
  }
  
  static func fromMove(_ move: String) -> Turn {
    let turnValue = String(move.characters.prefix(1))
    return Turn(rawValue: turnValue)!
  }
}

enum Direction : Int {
  case North = 0, East, South, West
  
  var scaleX: Int {
    switch self {
      case .East: return 1
      case .West: return -1
      default: return 0
    }
  }
  
  var scaleY: Int {
    switch self {
      case .North: return 1
      case .South: return -1
      default: return 0
    }
  }
  
  mutating func turn(_ move: String) {
    self = Direction(rawValue: (self.rawValue + Turn.fromMove(move).spinValue + 4) % 4)!
  }
}

struct Point {
  let x, y : Int
  
  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }
  
  func move(distance: Int, direction: Direction) -> Point {
    let nextX = x + distance * direction.scaleX
    let nextY = y + distance * direction.scaleY
    return Point(nextX, nextY)
  }
  
  var distanceToOrigin : Int {
    return abs(self.x) + abs(self.y)
  }
}

struct Line {
  let pointA, pointB : Point
  
  init(_ a: Point, _ b : Point) {
    self.pointA = a
    self.pointB = b
  }
  
  func intersects(_ line : Line) -> Bool {
    let intersectsX = (self.pointA.x < line.pointB.x && self.pointB.x > line.pointA.x)
    let intersectsY = (self.pointA.y < line.pointB.y && self.pointB.y > line.pointA.y)
    
    return intersectsX && intersectsY
  }
  
  func intersection(_ line : Line) -> Point? {
    if self.intersects(line) {
      let x = self.pointA.x - self.pointB.x == 0 ? self.pointA.x : line.pointA.x
      let y = self.pointA.y - self.pointB.y == 0 ? self.pointA.y : line.pointA.y
      return Point(x,y)
    } else {
      return nil
    }
  }
}

var locations = [Point]()

var point = Point(0, 0)
locations.append(point)
var currentDirection = Direction.North

for move in CommandLine.arguments.dropFirst(1) {
  currentDirection.turn(move)
  
  var distance = String(move.characters.dropFirst(1))
  if (distance.hasSuffix(",")) {
    distance = String(distance.characters.dropLast(1))
  }
  
  point = point.move(distance: Int(distance)!, direction: currentDirection)
  
  locations.append(point)
}

print("distance to origin: \(point.distanceToOrigin)")

var lines = [Line]()
var previousPoint = locations[0]
for nextPoint in locations.dropFirst(1) {
  lines.append(Line(previousPoint,nextPoint))
  previousPoint = nextPoint
}

var intersection : Point?
for (index, lineA) in lines.enumerated() {
  for lineB in lines.dropFirst(index+1) {
    intersection = lineA.intersection(lineB)
    
    if intersection != nil {
      break
    }
  }
  if intersection != nil {
    break
  }
}

if intersection != nil {
  print("first intersection: \(intersection!.distanceToOrigin)")
} else {
  print("never intersects")
}
