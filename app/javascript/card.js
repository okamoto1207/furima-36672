const pay = () => {
  Payjp.setPublicKey("pk_test_3a6038bc9a00048fe6f84f1d");
  const form = document.getElementById("charge-form");
  // クリックした時に実行
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
    const card = {
      number: formData.get("order_form[number]"),
      exp_month: formData.get("order_form[exp_month]"),
      exp_year: `20${formData.get("order_form[exp_year]")}`,
      cvc: formData.get("order_form[cvc]"),
    };

    // 第一引数は15行目で定義したカード情報。第二関数はアロー関数を用いてPAYJP側からのレスポンス・ステータスコードを受け取った後の処理を定義
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        // response.idとすることでトークンの値を取得
        const token = response.id;
        // HTMLのinput要素にトークンの値を埋め込み、フォームに追加
        const renderDom = document.getElementById("charge-form");
        // valueは実際に送られる値、nameはその値を示すプロパティ名（params[:name]のように取得できるようになる）を示す。トークンはユーザーに見せる必要がないのでtype属性の値にhiddenを指定。
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        // フォームの中に作成したinput要素を追加（内部の最後の子要素の後に挿入）
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // フォームに存在するクレジットカードの各情報を削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");

      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
  });
};

// payページを読み込んだ時に実行
window.addEventListener("load", pay);