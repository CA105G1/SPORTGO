<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

  <title>Example 03 - Stripe Compatible | CardJs</title>

    <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
  		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

  <link href="<%=request.getContextPath() %>/front-end/pro/card/card-js.min.css" rel="stylesheet" type="text/css" />
  <script src="<%=request.getContextPath() %>/front-end/pro/card/card-js.min.js"></script>

  <style>
    .panel {
      background-color: #F5F5F7;
      border: 1px solid #ddd;
      padding: 20px;
      display: block;
      width: 270px;
      border-radius: 6px;
      box-shadow: 0 2px 4px rgba(0,0,0,.1);
    }
    .btn {
      background: rgb(68,175,231); /* Old browsers */
      background: -moz-linear-gradient(top, rgba(68,175,231,1) 0%, rgba(49,152,223,1) 100%); /* FF3.6-15 */
      background: -webkit-linear-gradient(top, rgba(68,175,231,1) 0%,rgba(49,152,223,1) 100%); /* Chrome10-25,Safari5.1-6 */
      background: linear-gradient(to bottom, rgba(68,175,231,1) 0%,rgba(49,152,223,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
      filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#44afe7', endColorstr='#3198df',GradientType=0 );
      color: #fff;
      display: block;
      width: 100%;
      border: 1px solid rgba(46, 86, 153, 0.0980392);
      border-bottom-color: rgba(46, 86, 153, 0.4);
      border-top: 0;
      border-radius: 4px;
      font-size: 17px;
      text-shadow: rgba(46, 86, 153, 0.298039) 0px -1px 0px;
      line-height: 34px;
      -webkit-font-smoothing: antialiased;
      font-weight: bold;
      margin-top: 20px;
    }

    .btn:hover {
      cursor: pointer;
    }
  </style>

</head>
<body>

  <div class="panel">
    <form id="subscription-form">

      <div class="card-js stripe" data-stripe="true"></div>

      <button class="btn">Pay $20</button>

    </form>
  </div>

</body>



<!-- #### STRIPE LIBRARY - UNCOMMENT TO IMPORT #### -->
<!--<script src="https://js.stripe.com/v2"></script>-->
<!-- ############################################## -->

<script>
$(function() {

  //
  // EXAMPLE CODE FOR STRIPE INTEGRATION
  // ---------------------------------------------------------------------------
  //
  //  1.) You need to import the Stripe JS API -> https://js.stripe.com/v2
  //      Uncomment the script import above.
  //
  //  3.) Uncomment the example code below.
  //
  //  2.) Replace "publishable-key-goes-here" with your Stripe publishable key
  //      For testing purposes you should use your test API credentials.
  //
  //  This is only meant to demonstrate how CardJs can be integrated with Stripe.
  //  You should test your implementation thoroughly before publishing.
  //

  /*
  Stripe.setPublishableKey("publishable-key-goes-here");

  $("#subscription-form button").click(function() {

    var form              = $("#subscription-form");
    var submit            = form.find("button");
    var submitInitialText = submit.text();

    submit.attr("disabled", "disabled").text("Just one moment");

    Stripe.card.createToken(form, function(status, response) {
      if(response.error) {
        form.find(".stripe-errors").text(response.error.message).show();
        submit.removeAttr("disabled");
        submit.text(submitInitialText);
      } else {
        form.append($("<input type='hidden' name='token'>").val(response.id));
        form.submit();
      }
    });
  });
  */

});
</script>
</html>