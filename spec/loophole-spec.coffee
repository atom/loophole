{allowUnsafeNewFunction} = require '../src/loophole'

describe "Loophole", ->
  describe "allowUnsafeNewFunction", ->
    it "allows functions to be created with no formal parameters", ->
      allowUnsafeNewFunction ->
        f = new Function("return 1 + 1;")
        expect(f()).toBe 2

    it "allows functions to be created with formal parameters", ->
      allowUnsafeNewFunction ->
        f = new Function("a, b", "c", "return a + b + c;")
        expect(f(1, 2, 3)).toBe 6
