#!/usr/bin/env xcrun --sdk macosx swift -I .

import CommonCrypto
import Foundation

func md5(_ string: String) -> String {
    let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
    var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
    CC_MD5_Init(context)
    CC_MD5_Update(context, string, CC_LONG(string.utf8.count))
    CC_MD5_Final(&digest, context)
    context.deallocate(capacity: 1)
    return digest.map { String(format:"%02x", $0) }.joined(separator: "")
}

func part1(_ argument : String) -> String {
  var password = ""
  var index = 0
  while password.characters.count < 8 {
    let id = "\(argument)\(index)"
    let hash = md5(id)
    if hash.hasPrefix("00000") {
      password += String(hash.characters.dropFirst(5).prefix(1).first!)
    }
    
    index += 1
  }
  
  return password
}

func part2(_ argument : String) -> String {
  var password = "        "
  var index = 0
  while password.contains(" ") {
    let id = "\(argument)\(index)"
    let hash = md5(id)
    if hash.hasPrefix("00000") {
      
      let positionChar = String(hash.characters.dropFirst(5).prefix(1).first!)
      if "01234567".contains(positionChar) {
        let position = Int(positionChar)!
        let character = hash.characters.dropFirst(6).prefix(1).first!
      
        var chars = Array(password.characters)
        if chars[position] == " " {
          chars[position] = character
        }
      
        password = String(chars)
      }
    }
    
    index += 1
  }
  
  return password
}

let argument = CommandLine.arguments.dropFirst(1).first!

//print(part1(argument))
print(part2(argument))