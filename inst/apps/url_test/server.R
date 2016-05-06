# server.R
#library(shiny)
url_fields_to_sync <- c("beverage","milk","sugarLumps","customer");

# Define server logic required to respond to d3 requests
shinyServer(function(input, output, session) { # session is the common name for this variable, not clientData

  # Generate a plot of the requested variable against mpg and only
  # include outliers if requested
  output$order <- renderText({
    paste(input$beverage,
          if(input$milk) "with milk" else ", black",
          "and",
          if (input$sugarLumps == 0) "no" else input$sugarLumps,
          "sugar lumps",
          "for",
          if (input$customer == "") "next customer" else input$customer)
  })

  firstTime <- TRUE

  output$hash <- renderText({

    newHash = paste(collapse=";",
                    Map(function(field) {
                      paste(sep="=",
                            field,
                            input[[field]])
                    },
                    url_fields_to_sync))

    # the VERY FIRST time we pass the input hash up.
    return(
      if (!firstTime) {
        newHash
      } else {
        if (is.null(input$hash)) {
          NULL
        } else {
          firstTime<<-F;
          isolate(input$hash)
        }
      }
    )
  })

  ###

  # whenever your input values change, including the navbar and tabpanels, send
  # a message to the client to update the URL with the input variables.
  # setURL is defined in url_handler.js
  observe({
    reactlist <- reactiveValuesToList(input)
    reactvals <- grep("^ss-|^shiny-", names(reactlist), value=TRUE, invert=TRUE) # strip shiny related URL parameters
    reactstr <- lapply(reactlist[reactvals], as.character) # handle conversion of special data types
    session$sendCustomMessage(type='setURL', reactstr)
  })

  observe({ # this observer executes once, when the page loads

    # data is a list when an entry for each variable specified
    # in the URL. We'll assume the possibility of the following
    # variables, which may or may not be present:
    #   nav= The navbar tab desired (either Alfa Bravo or Delta Foxtrot)
    #   tab= The desired tab within the specified nav bar tab, e.g., Golf or Hotel
    #   beverage= The desired beverage selection
    #   sugar= The desired number of sugar lumps
    #
    # If any of these variables aren't specified, they won't be used, and
    # the tabs and inputs will remain at their default value.
    data <- parseQueryString(session$clientData$url_search)
    # the navbar tab and tabpanel variables are two variables
    # we have to pass to the client for the update to take place
    # if nav is defined, send a message to the client to set the nav tab
    if (! is.null(data$page)) {
      session$sendCustomMessage(type='setNavbar', data)
    }

    # if the tab variable is defined, send a message to client to update the tab
    if (any(sapply(data[c('alfa_bravo_tabs', 'delta_foxtrot_tabs')], Negate(is.null)))) {
      session$sendCustomMessage(type='setTab', data)
    }

    # the rest of the variables can be set with shiny's update* methods
    if (! is.null(data$beverage)) { # if a variable isn't specified, it will be NULL
      updateSelectInput(session, 'beverage', selected=data$beverage)
    }

    if (! is.null(data$sugarLumps)) {
      sugar <- as.numeric(data$sugarLumps) # variables come in as character, update to numeric
      updateNumericInput(session, 'sugarLumps', value=sugar)
    }
  })

  ###
})
