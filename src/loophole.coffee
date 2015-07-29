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
    global.Function = exports.Function
    fn()
  finally
    global.Function = previousFunction

exports.Function = (paramLists..., body) ->
  params = []
  for paramList in paramLists
    if typeof paramList is 'string'
      paramList = paramList.split(/\s*,\s*/)
    params.push(paramList...)

  vm.runInThisContext """
    (function(#{params.join(', ')}) {
      #{body}
    })
  """

exports.Function:: = global.Function::
