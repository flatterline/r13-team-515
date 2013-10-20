# screenshots = "/screenshots.json"

# console.log "Sending screenshots request"

# $.getJSON(screenshots).done (data) ->
#   sourceResults = _.filter(data, (screen) -> (screen.publication_id == 1 || screen.publication_id == 2))
#   orderedResults = _.sortBy(sourceResults, (screen) -> screen.timestamp)
#   groupedResults = _.groupBy(orderedResults, (screen) -> screen.timestamp)
#   console.log groupedResults