function qddsimol(content,width){
	var top=100;
	//var left=document.documentElement.clientWidth;
	var right=5;
	function scrollTop(y) {
		if (y == undefined)
			return document.documentElement.scrollTop || document.body.scrollTop;
		else
			document.documentElement.scrollTop = document.body.scrollTop = y;
	}
	var html = '<div id="qddsimdiv" style="position:'+(-[1,]?'fixed':'absolute')+';-moz-user-select:none;overflow:hidden;border:1px solid #CCCCCC;padding:3px;font-size:12px;background-color:#FFF8EF;color:#000000;width:'+(width||100)+'px;top:'+top+'px;right:'+right+'px;" onselectstart="return false;">'+(content||'&nbsp;')+'</div>';
	document.write(html);
	if(!-[1,]){
		var handle = document.getElementById('qddsimdiv');
		if(handle){
			var lastScrollY=scrollTop();
			window.setInterval( function() {
				var diffY = scrollTop();
				var percent = .5 * (diffY - lastScrollY);
				if (percent > 0)
					percent = Math.ceil(percent);
				else
					percent = Math.floor(percent);
				if (percent != 0) {
					handle.style.top=parseInt(handle.style.top||0)+percent + "px";
					lastScrollY = lastScrollY + percent;
				}
			}, 100);
		}
	}
};