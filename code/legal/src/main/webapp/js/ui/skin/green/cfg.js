// 依赖于skin/default/cfg.js, 建议将本文件内容拷贝到jquery-grapid-ui-2.1.custom.min.js模板部分
grapidUI.skin["green"] = {
	"enable" :true,
	"msg" : {
		"frame" :grapidUI.skin["default"].msg.frame,
		"iefilter" :grapidUI.skin["default"].msg.iefilter,
		"handler" :0
	}
};
grapidUI.fn.loadSkin("green");