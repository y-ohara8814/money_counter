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
//= require turbolinks
//= require_tree .

function check(){
    //プラン新規作成画面の、設定金額の値を取得
    var money_amount = document.getElementById("money_amount").value;
    //対象の年を取得
    var year = document.getElementById("year");
    var year_value = year.value;
    //対象の月を取得
    var month = document.getElementById("month");
    var month_value = month.value;
    //モーダルに表示
    alert(year_value);
}
// 動作したjsのサンプル
// document.addEventListener('turbolinks:load',function(){
//     document.getElementById("purpose_other").onclick = function(){
//         alert("クリックされた！");
//       };
// });

 document.addEventListener('turbolinks:load',function(){
    document.getElementsByName("usage[purpose]").onclick = function () {
        if ( document.forms["usage[purpose]"][3].checked ) { // 「その他」のラジオボタンをクリックしたとき
            document.forms["usage[purpose_text]"].disabled = false; // 「その他」のラジオボタンの横のテキスト入力欄を有効化
            document.getElementById('purpose_text').style.display = "inline"; // 「その他」のラジオボタンの横のテキスト入力欄を表示
        } else { // 「その他」のラジオボタン以外をクリックしたとき
            document.forms["usage[purpose_text]"].disabled = true; // 「その他」のラジオボタンの横のテキスト入力欄を有効化
            document.getElementById('purpose_text').style.display = "none"; // 「その他」のラジオボタンの横のテキスト入力欄を表示
        }
    };
 });

