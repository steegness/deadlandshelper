<?php
require_once("utility.php");
require_once("database.php");
?>
<!doctype html>
<html lang="en">
  <head>
    <title>Deadlands Helper Site</title>
    <!-- BootStrap -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
    <!-- Local Styles -->
    <link rel="stylesheet" href="styles/deadlandshelper.css" />
    <link rel="stylesheet" href="styles/cards.css" />
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="  crossorigin="anonymous"></script>
    <!-- Local JS -->
    <script src="js/utility.js"></script>
    <script src="js/users.js"></script>
    <script src="js/chips.js"></script>
    <script src="js/cards.js"></script>
  </head>
  <body>
    <h1>
      Deadlands Helper Site
    </h1>
    <div id="GiveThings">
      <div id="UserDropDownSection"></div>
      <span id="giveChipLink" onclick="giveThisUserAChip();" class="btn btn-primary">Random Chip</span><br/>
      <span id="giveCardLink" onclick="giveThisUserACard();" class="btn btn-success">Random Card</span>
      <div class="dropdown">
        <button class="btn btn-info dropdown-toggle" type="button" id="giveSpecificChipButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Specific Chip
        </button>
        <div class="dropdown-menu" aria-labelledby="giveSpecificChipButton">
          <span class="dropdown-item" onclick="giveThisUserASpecificChip('white');">White</span>
          <span class="dropdown-item" onclick="giveThisUserASpecificChip('red');">Red</span>
          <span class="dropdown-item" onclick="giveThisUserASpecificChip('blue');">Blue</span>
        </div>
      </div>
      <div id="giveChipMessage" display="none"></div>
      <div id="spendChipMessage" display="none"></div>
      <div id="giveCardMessage" display="none"></div>
      <div id="spendCardMessage" display="none"></div>
    </div>
    <div id="ChipTableSection">
      <h3>Current Chips</h3>
      <div id="ChipTable"></div>
    </div>
    <div id="CardTableSection">
      <h3>Current Cards <span id="reshuffle" onclick="reshuffleAllCards()" class="btn btn-danger">reshuffle all cards</span><span id="reshuffleMessage"></span></h3>
      <div id="CardTable"></div>
    </div>
    
    <script>
      loadUserDropdown();
      loadChipTable();
      loadCardTable();
    </script>
    <?php
    // This is useful for debugging things, as it keeps the period refresh from happening
    if (requestVar("noreload") != "true") { ?>
    <script>
      var chipInterval = setInterval( function() { loadChipTable(); }, 10000);
      var cardInterval = setInterval( function() { loadCardTable(); }, 10000);
    </script>
    <?php } ?>
    
    <!-- Additional Scripts for Bootstrap -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    
  </body>
</html>