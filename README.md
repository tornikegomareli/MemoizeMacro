<p align="center">
<img src="https://github.com/tornikegomareli/MemoizeMacro/assets/24585160/4ac49599-85d7-4457-aa7c-c912730b2d64" width="600" alt="MemoizeScreenshot">
</p>

# Swift Memoize Macro

A Swift macro for easy function memoization.

## Overview

This package provides a `@Memoize` macro that automatically generates a memoized version of any function it's applied to. Memoization is an optimization technique that stores the results of expensive function calls and returns the cached result when the same inputs occur again.

## Features

- Easy to use: Just add `@Memoize` before your function declaration
- Supports functions with any number of parameters
- Works with various return types
- Automatically generates a memoized version of the function with a `memoized` prefix

## Installation

Add this package to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/SwiftMemoizeMacro.git", from: "1.0.0")
]
```

## Usage

1. Import the package in your Swift file:

```swift
import Memoize
```

2. Apply the `@Memoize` macro to any function you want to memoize:

```swift
class Calculator {
    @Memoize
    func expensiveCalculation(a: Int, b: Int) -> Int {
        // Simulate expensive operation
        sleep(2)
        return a + b
    }
}
```

3. Use the memoized version of the function by prefixing the original function name with `memoized`:

```swift
let calculator = Calculator()
let result1 = calculator.memoizedExpensiveCalculation(a: 5, b: 3) // Takes 2 seconds
let result2 = calculator.memoizedExpensiveCalculation(a: 5, b: 3) // Returns immediately
```

## How It Works

The `@Memoize` macro generates a private cache and a new function with the `memoized` prefix. This new function checks the cache for previously computed results before calling the original function.

## Requirements

- Swift 5.9+
- Xcode 15+

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.
