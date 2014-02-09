$.extend(jQuery.validator.messages, {
	required: "このフィールドは必須です。",
	remote: "このフィールドを修正してください。",
	email: "有効なメールアドレスを入力してください。",
	url: "有効なURLを入力してください。",
	date: "有効な日付を入力してください。",
	dateISO: "有効な日付（ISO）を入力してください。",
	number: "有効な番号を入力してください。",
	digits: "数字だけを入力してください。",
	creditcard: "有効なクレジットカード番号を入力してください。",
	equalTo: "再び同じ値を入力してください。",
	maxlength: $.validator.format("{0}文字以内で入力してください。"),
	minlength: $.validator.format("少なくとも{0}文字を入力してください。"),
	rangelength: $.validator.format("{0}と{1}文字の長さの値を入力してください。"),
	range: $.validator.format("{0}と{1}の間の値を入力してください。"),
	max: $.validator.format("未満または{0}に等しい値を入力してください。"),
	min: $.validator.format("以上{0}に等しい値を入力してください。")
});