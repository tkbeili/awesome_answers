$ ->
  return if typeof Stripe == 'undefined'
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  charge.setupForm()

charge =
  setupForm: ->
    $('#new_tip').on "submit", ->
      $("#stripe_error").html("")
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        charge.processCard()
        false
      else
        true
  
  processCard: ->
    card =
      number:   $('#card_number').val()
      cvc:      $('#card_ccv').val()
      expMonth: $('#card_month').val()
      expYear:  $('#card_year').val()
    Stripe.createToken(card, charge.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#stripe_card_token').val(response.id)
      $('#new_tip')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)