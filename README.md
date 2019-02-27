#  RayTracer
## Based on the Book [Ray Tracer Challenge by Jamis Buck](https://pragprog.com/book/jbtracer/the-ray-tracer-challenge)

For those who don't know about this book, it's a test-driven development approach to writing a ray tracer. Unlike most programming books, it tells you design principles and lays out what the tests should be like, but without code. So language choice is personal, and I chose Swift.

## Design Thoughts

1. Much though Cucumberish looks cool and expressive, I'm going to stick with XCTest for the tests.
2. I find it fascinating that things that could be structs in Swift are classes…e.g., Tuple. That allows for inheritance you can't get with a struct, but also the behavior of a struct and a class is different. (Fun tidbit: Swift's Double is a struct.)
3. I considered having Tuple wrap SceneKit's ScnVector4…that's a struct, so it can't be straight inheritance. Point and Vector also logically inherit from Tuple. So.

