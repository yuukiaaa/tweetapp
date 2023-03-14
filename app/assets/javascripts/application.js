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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery.jscroll.min.js
//= require jquery_ujs
//= require infinite-scroll.pkgd.min
//= require_tree .


// items.html.erbでツイートを画面下5％までスクロールすると新しくロードする
// $(window).on('scroll', function() {
//     scrollHeight = $(document).height();
//     scrollPosition = $(window).height() + $(window).scrollTop();
//     if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
//       $('.jscroll').jscroll({
//         contentSelector: '.jscroll',
//         nextSelector: 'a[rel="next"]'
//       });
//     }
//   });

//   $(document).on('turbolinks:load', function() {
//     $('.jscroll').jscroll({
//       // 無限に追加する要素は、どこに入れる？
//       contentSelector: '.jscroll', 
//       // 次のページにいくためのリンクの場所は？ ＞aタグの指定
//       nextSelector: 'a[rel="next"]',
//       // 読み込み中の表示はどうする？
//       loadingHtml: '読み込み中'
//     });
//   });

//　コメント：$(document).ready(function{});　＝　jQuery(function(){});　＝　$(function(){});
//　コメント：readyイベントが発火しない場合は $(document).on('turbolinks:load', function(){});を使用する

// jQuery(document).ready(function($){
//   $(document).on('turbolinks:load', function(){
//     $('.jscroll').infiniteScroll({
//       path: 'a[rel="next"]',
//       append: '.inf-scroll',
//       history: false,
//       prefill: true
//     });
//   });
// });


jQuery(document).ready(function($){
  $('.jscroll').infiniteScroll({
    path: 'a[rel="next"]',
    append: '.inf-scroll',
    history: false,
    prefill: true
  });
});


$(document).on("turbolinks:load", function(){

  const ham = document.querySelector('#js-hamburger');
  const nav = document.querySelector('#js-navbar')

  ham.addEventListener('click', function(){
    ham.classList.toggle('active');
    nav.classList.toggle('active');
  });

});

$(document).on("turbolinks:load", function(){
  break_point = 570;
  pc_nav_class = 'navbar navbar-expand-sm navbar-light bg-light';
  smartphone_nav_class = 'smartphone-navbar';
  pc_menulist_class = 'collapse navbar-collapse';
  smartphone_menulist_class = '';
  pc_menulist_2_class = "navbar-nav me-auto mb-2 mb-lg-0";
  smartphone_menulist_2_class = 'list-group';

  nav = document.querySelector("#js-navbar");
  menulist = document.querySelector("#navbarSupportedContent")
  menulist_2 = document.querySelector("#js-nav__menu");
  hamburger = document.querySelector("#js-hamburger");

  if (window.innerWidth < break_point){
    nav.className = smartphone_nav_class;
    hamburger.className = "hamburger";
    menulist.className = smartphone_menulist_class;
    menulist_2.className = smartphone_menulist_2_class;

  }else{
    nav.className = pc_nav_class;
    hamburger.className = "undisplayed";
    menulist.className = pc_menulist_class;
    menulist_2.className = pc_menulist_2_class;
  }

  window.addEventListener('resize', function(){
    console.log("Width:" + window.innerWidth);
    console.log("Height:" + window.innerHeight);

    if (window.innerWidth < break_point ){
      nav.className = smartphone_nav_class;
      hamburger.className = "hamburger";
      menulist.className = smartphone_menulist_class;
      menulist_2.className = smartphone_menulist_2_class;
    } else {
      nav.className = pc_nav_class;
      hamburger.className = "undisplayed";
      menulist.className = pc_menulist_class;
      menulist_2.className = pc_menulist_2_class;
    }

  });

  // window.addEventListener('DOMContentLoad', function(){
  //   window.addEventListener('resize', function(){
  //     console.log("Width:" + window.innerWidth);
  //     console.log("Height:" + window.innerHeight);
  //   });
  // });

});
