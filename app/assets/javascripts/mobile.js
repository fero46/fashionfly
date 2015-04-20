//= require jquery
//= require jquery_ujs
//= require jquery.raty
//= require jquerybbq_min
//= require foundation

//= require masonry
//= require datetimepicker.js
//= require ratyrate
//= require tinymce-jquery
//= require angular
//= require angular-resource
//= require appconfig
//= require comments
//= require collections
//= require app
//= require_tree ./angular

$(document).foundation();

addSticky = function(){
  if($('.header').hasClass('sticky')){
    return;
  }
  $('.header').fadeOut(20, function(){
    $('.header').addClass('sticky');
    $('.header').fadeIn(500);
  });
};

removeSticky = function(){
  if(!$('.header').hasClass('sticky')){
    return;
  }
  $('.header').removeClass('sticky');
};

$(document).ready(function(){
  if( $(window).scrollTop() > $('.header').height() && !($('.header').hasClass('sticky'))){
      addSticky();
    } else if ($(window).scrollTop() <= $('.header').height()){
      removeSticky();
    }
  $(window).scroll(function () {
      if( $(window).scrollTop() > $('.header').height() && !($('.header').hasClass('sticky'))){
        addSticky();
      } else if ($(window).scrollTop() <= $('.header').height()){
        removeSticky();
      }
  });
});
