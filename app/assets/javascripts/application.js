// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require_tree .
$(function() {
  $('#slider').slick({
      autoplay: true,
      autoplaySpeed: 4000,
      slidesToShow: 4, //表示するスライドの数
      slidesToScroll: 4, //スクロールで切り替わるスライドの数
      nextArrow: '<i class="fas fa-arrow-circle-right"></i>',
      prevArrow: '<i class="fas fa-arrow-circle-left"></i>',

      //レスポンシブ対応させたい場合は以下も記述
      responsive: [{
        breakpoint: 768, //画面幅768pxで以下のセッティング
        settings: {
          slidesToShow: 2,
          slidesToScroll: 2,
        }
      }]
  });
});