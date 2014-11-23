// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.raty
//= require jquerybbq_min
//= require datetimepicker.js
//= require ratyrate
//= require social-share-button
//= require tinymce-jquery
//= require angular
//= require angular-resource
//= require appconfig
//= require comments
//= require app
//= require_tree ./angular

//<![CDATA[
tinyMCE.init({
selector: "textarea.tinymce",
toolbar: ["styleselect | bold italic | undo redo | code link media image | fullscreen"],
plugins: "image,link,fullscreen,code,media",
language: "de"
});
//]]>