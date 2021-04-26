# Math2D
![noise](./examples/noise.gif)
<p style="text-align: center;"><sub><sup>An example of noise generation in Ruby2D using Math2D's Perlin Noise implementation</sup></sub></p>


A collection of useful Mathematical and Vector tools in 2D space

## Purpose

Math2D is a library written in Ruby designed to help programmers with 2D projects - specifically, I started to develop this tool for use in my projects with the [Ruby2D gem](https://github.com/ruby2d/ruby2d). It provides several mathematical and vector functions and tools in two-dimensional Euclidean space.

## How to use

Math2D is not a gem (yet), so simply copy the contents of the `src/` folder into your own project and add `require_relative 'math2d'` to your script. The `Math2D` namespace provides a `Vector2D` class, which, as the name suggests, deals with 2D vectors, and the `Utils2D` module, which includes some useful non-vector specific mathematical methods and constants. Documentation is provided in the code above each module/class/method following YARD's syntax and also in the `doc/` folder.

## Credits

A special thanks to the creators of the [p5.js website](https://p5js.org/) and the [Unity's Scripting API website](https://docs.unity3d.com/ScriptReference/). Most ideas for the methods in this library came from these two places. Specially, most if not all methods descriptions come from p5.js.