this.initializePage = (selectors..., callback) ->
  if selectors.length
    $(callback) for selector in selectors when $("body#{selector}").size()
  else
    $(callback)
