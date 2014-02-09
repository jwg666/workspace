$.extend(jQuery.validator.messages, {
    required: "必填",
    remote: "驗證失敗",
    email: "請輸入正確的電子郵件",
    url: "請輸入正確的網址",
    date: "請輸入正確的日期",
    dateISO: "請輸入正確的日期 (ISO)",
    number: "請輸入正確的數字",
    digits: "請輸入正確的整數",
    creditcard: "請輸入正確的信用卡號",
    equalTo: "请再次輸入相同的值",
    maxlength: jQuery.validator.format("允許的最大長度爲 {0} 個字符"),
    minlength: jQuery.validator.format("允許的最小長度爲 {0} 個字符"),
    rangelength: jQuery.validator.format("允許的長度爲 {0} 到 {1} 之間"),
    range: jQuery.validator.format("請輸入介於 {0} 到 {1} 之間的值"),
    max: jQuery.validator.format("請輸入一個最大爲 {0} 的值"),
    min: jQuery.validator.format("請輸入一個最小爲 {0} 的值")
});