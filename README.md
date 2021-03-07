#  RayTracer
## Based on the Book [Ray Tracer Challenge by Jamis Buck](https://pragprog.com/book/jbtracer/the-ray-tracer-challenge)

For those who don't know about this book, it's a test-driven development approach to writing a ray tracer. Unlike most programming books, it tells you design principles and lays out what the tests should be like, but without code. So language choice is personal, and I chose Swift.

Many of the various projects for Swift are largely UI based, but Swift is a general-purpose language, so I wanted to try a project that wasn't UI based to get a feel for using the language in a different way.

Currently: on chapter 5, the beginnings of intersections.

## Design Thoughts

1. Much though Cucumberish looks cool and expressive, I'm going to stick with XCTest for the tests. (Update: I may switch to Quick at some point just because this is a good kind of project for adding that.)
2. I find it fascinating that things that could be structs in Swift are classes…e.g., Tuple. That allows for inheritance you can't get with a struct, but also the behavior of a struct and a class is different. (Fun tidbit: Swift's Double is a struct.)
3. I considered having Tuple wrap SceneKit's ScnVector4…that's a struct, so it can't be straight inheritance. Point and Vector also logically inherit from Tuple. So. (Changing these to protocols may work, but I'll look at it later on. But Point/Vector/Tuple are more tightly coupled than most protocol structs are.)

## Chapter 5

This book was basically easy until Chapter 5, because the math got ahead of my brain fairly early on. What I struggled with at first was why a sphere's intersection with a ray should be a float, not a point.

Then I realized that, while I'd been thinking about it from the sphere's POV, it's really where along the ray that point is, and you only need a floating point number to represent that (given that there's already a known direction). Later on, this will also translate into time, but we're not doing that part yet.

I read the intersection calculations several times, as well as some other implementations, and finally decided to just literally transcribe the book's description into Swift. Voila!

## Other Implementations

It was cool to have a question about a detail I wasn't certain about and see implementations in so many other languages. Here are a few:

* [Swift](https://github.com/haruhikoM/RayTracerChallenge)
* [Swift](https://github.com/sbehnke/SwiftlyRT)
* [Python](https://github.com/thomasdelrue/ray-tracer-challenge-python/tree/ce9fc90c5419d432416c65f1e83b824ce0f95dcb)
* [C++](https://github.com/kongsgard/raytracer/tree/f4f958516c8f479234c1c877cad54871f3857d51)
* [Scala](https://github.com/jamesmcm/raytracer_challenge_scala)
* [Rust](https://github.com/arsenypoga/rust-raytracer/tree/08568d9cdfcae84324698f3fc61985d16a1ce126)
