{allowUnsafeEval, allowUnsafeNewFunction} = require '../src/loophole'

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

    it "supports Function.prototype.call", ->
      allowUnsafeNewFunction ->
        expect(Function::call).toBeDefined()
        f = new Function("a, b", "c", "return a + b + c;")
        expect(Function::call.call(f, null, 1, 2, 3)).toBe 6

    it "supports Function.prototype.apply", ->
      allowUnsafeNewFunction ->
        expect(Function::apply).toBeDefined()
        f = new Function("a, b", "c", "return a + b + c;")
        expect(Function::apply.call(f, null, [1, 2, 3])).toBe 6

    it "returns the value that its body function returns", ->
      result = allowUnsafeNewFunction -> 42
      expect(result).toBe 42

  describe "allowUnsafeEval", ->
    it "returns the value that its body function returns", ->
      result = allowUnsafeEval -> 42
      expect(result).toBe 42
