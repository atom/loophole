vm = require 'vm'

exports.allowUnsafeEval = (fn) ->
  previousEval = global.eval
  try
    global.eval = (source) -> vm.runInThisContext(source)
    fn()
  finally
    global.eval = previousEval
