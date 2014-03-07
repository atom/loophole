vm = require 'vm'

exports.allowUnsafeEval = (fn) ->
  previousEval = global.eval
  try
    global.eval = (source) -> vm.runInThisContext(source)
    fn()
  finally
    global.eval = previousEval

exports.allowUnsafeNewFunction = (fn) ->
  previousFunction = global.Function
  try
    global.Function = (source) -> vm.runInThisContext(source)
    fn()
  finally
    global.Function = Function
