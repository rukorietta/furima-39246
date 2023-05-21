document.addEventListener("DOMContentLoaded", function() {
  // クレジットカード情報の入力フォーム
  var cardNumberElement = document.getElementById("card_number");
  var expirationMonthElement = document.getElementById("expiration_month");
  var expirationYearElement = document.getElementById("expiration_year");
  var securityCodeElement = document.getElementById("security_code");

  // トークン生成処理
  var form = document.getElementById("order_form");
  form.addEventListener("submit", function(event) {
    event.preventDefault(); // フォームのデフォルトの送信を防止

    // クレジットカード情報を取得
    var cardNumber = cardNumberElement.value;
    var expirationMonth = expirationMonthElement.value;
    var expirationYear = expirationYearElement.value;
    var securityCode = securityCodeElement.value;

    // PAY.JPのトークン生成リクエストを送信
    Payjp.createToken({
      card: {
        number: cardNumber,
        exp_month: expirationMonth,
        exp_year: expirationYear,
        cvc: securityCode
      }
    }, function(status, response) {
      if (status === 200) {
        // トークンが生成された場合、サーバーサイドにトークンを送信
        var token = response.id;

        // サーバーサイドにトークンを送信するためのAjaxリクエスト
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/orders", true);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onreadystatechange = function() {
          if (xhr.readyState === 4 && xhr.status === 200) {
            // サーバーサイドからのレスポンスを処理
            var response = JSON.parse(xhr.responseText);
            if (response.success) {
              // 決済が成功した場合の処理
              alert("決済が完了しました。");
            } else {
              // 決済が失敗した場合の処理
              alert("決済が失敗しました。");
            }
          }
        };

        // トークンをサーバーサイドに送信
        var data = JSON.stringify({ token: token });
        xhr.send(data);
      } else {
        // トークン生成に失敗した場合の処理
        alert("トークンの生成に失敗しました。");
      }
    });
  });
});