import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
@testable import MemoizeMacro

final class MemoizeMacroTests: XCTestCase {
  let macros: [String: Macro.Type] = [
    "Memoize": Memoize.self
  ]
  
  func testMemoizeMacroOnSimpleFunction() {
    assertMacroExpansion(
          """
          @Memoize
          func add(a: Int, b: Int) -> Int {
              return a + b
          }
          """,
          expandedSource: """
          func add(a: Int, b: Int) -> Int {
              return a + b
          }
          
          private var memoizeaddCache: [String: Int] = [:]
          
          func memoizedAdd(a: Int, b: Int) -> Int {
              let cacheKey = "a: \\(a), b: \\(b)"
              if let cachedResult = memoizeaddCache[cacheKey] {
                  return cachedResult
              }
              let result = add(a, b)
              memoizeaddCache[cacheKey] = result
              return result
          }
          """,
          macros: macros
    )
  }
  
  func testMemoizeMacroOnFunctionWithNoParameters() {
    assertMacroExpansion(
              """
              @Memoize
              func getCurrentTime() -> Double {
                  return Date().timeIntervalSince1970
              }
              """,
              expandedSource: """
              func getCurrentTime() -> Double {
                  return Date().timeIntervalSince1970
              }
              
              private var memoizegetCurrentTimeCache: [String: Double] = [:]
              
              func memoizedGetCurrentTime() -> Double {
                  let cacheKey = ""
                  if let cachedResult = memoizegetCurrentTimeCache[cacheKey] {
                      return cachedResult
                  }
                  let result = getCurrentTime()
                  memoizegetCurrentTimeCache[cacheKey] = result
                  return result
              }
              """,
              macros: macros
    )
  }
  
  func testMemoizeMacroOnFunctionWithComplexReturnType() {
    assertMacroExpansion(
              """
              @Memoize
              func fetchUserData(id: Int) -> (name: String, age: Int, emails: [String]) {
                  // Simulating a complex operation
                  return ("User\\(id)", id * 2, ["user\\(id)@example.com"])
              }
              """,
              expandedSource: """
              func fetchUserData(id: Int) -> (name: String, age: Int, emails: [String]) {
                  // Simulating a complex operation
                  return ("User\\(id)", id * 2, ["user\\(id)@example.com"])
              }
              
              private var memoizefetchUserDataCache: [String: (name: String, age: Int, emails: [String])] = [:]
              
              func memoizedFetchUserData(id: Int) -> (name: String, age: Int, emails: [String]) {
                  let cacheKey = "id: \\(id)"
                  if let cachedResult = memoizefetchUserDataCache[cacheKey] {
                      return cachedResult
                  }
                  let result = fetchUserData(id)
                  memoizefetchUserDataCache[cacheKey] = result
                  return result
              }
              """,
              macros: macros
    )
  }
}

