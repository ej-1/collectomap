// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.remotipart
//= require twitter/bootstrap
// removed '//=require turbolinks' because I had to reload the page sometimes to make application.js load.
// Read about it here in comment nr 5 - http://stackoverflow.com/questions/17881384/jquery-gets-loaded-only-on-page-refresh-in-rails-4-application
// Also had to "split up" form for list items by putting the code directly in edit view withouth remote=> true which was making the page redirect to the right page in the console, but not render the page.
// The remaing form is rendered when creating a new list item and uses remote => true to not reload the page.
//= require_tree .

$(document).ready(function(){

  $( ".clear-adress-btn" ).click(function() {
              document.getElementById("list_item_adress").value = ''; // Send coordinates to adress field.
              document.getElementById("adress_info").innerHTML = 'Click on map to add or change adress marker'; // Send coordinates to adress field.
  });

});