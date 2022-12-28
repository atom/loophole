vm = require 'vm'

exports.allowUnsafeEval = (fn) ->
  previousEval = global.eval
  callback = -> global.eval = previousEval
  error = false
  try
    global.eval = (source) -> vm.runInThisContext(source)
    fn(callback)

  catch err
    error = true
    callback()

  finally
    if !fn.length and !error
      callback()

exports.allowUnsafeNewFunction = (fn) ->
  previousFunction = global.Function
  callback = -> global.eval = previousFunction
  error = false
  try
    global.Function = exports.Function
    fn(callback)

  catch err
    error = true
    callback()

  finally
    if !fn.length and !error
      callback()

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
