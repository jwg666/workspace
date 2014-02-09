/************************************************************************
*************************************************************************
@Name :       	jRating - jQuery Plugin
@Revison :    	3.0
@Date : 		28/01/2013 
@Author:     	 ALPIXEL - (www.myjqueryplugins.com - www.alpixel.fr) 
@License :		 Open Source - MIT License : http://www.opensource.org/licenses/mit-license.php
 
**************************************************************************
*
*扩展了对datagrid editor 的使用
*
*使用方式：
*editor:{type:'jrating',options:{type:'small',length:5,rateMax:5,customInfo:[],onClick:function}}"
*type:big 或者 small 显示图标大小 默认big
*length：显示几颗星 默认5
*rateMax：最大值 默认5
*customInfo：数组，与rate 相对应 存放提示信息 默认 null
*onClick(rate ,idBox) 回调函数 rate是 value，idBox 星评ID
*
*************************************************************************/
(function($) {
	function destroy (jq) {
		jq.removeData("rating");
		jq.remove();
	};
	function getValue(jq) {
		return jq.data("rating").value;
	};
	function setValue(jq, val) {
		var opt = jq.data("rating");
		opt.value=val;
		console.log(opt.globalWidth);
		opt.globalWidth = parseInt(val)*opt.starWidth;
		console.log(opt.globalWidth);
		jq.data("rating",opt);
		jq.find(".jRatingAverage").width(opt.globalWidth);
	};
	$.fn.jRating = function(op,val) {
		
		if (typeof op == "string") {
			if(op == "setValue"){
				return setValue($(this),val);
			}else if(op == "getValue"){
				return getValue($(this));
			}else if(op == "destroy"){
				return destroy($(this));
			}
		}
		
		var defaults = {
			/** String vars **/
			bigStarsBg : 'starsBg', // style class of the icon stars.png
			smallStarsBg : 'smallStarsBg', // style class  of the icon small.png
			type : 'big', // can be set to 'small' or 'big'

			/** Boolean vars **/
			step:true, // if true,  mouseover binded star by star,
			isDisabled:false,
			showRateInfo: true,
			canRateAgain : true,
			customInfo:null,

			/** Integer vars **/
			length:5, // number of star to display
			decimalLength : 0, // number of decimals.. Max 3, but you can complete the function 'getNote'
			rateMax : 50, // maximal rate - integer from 0 to 9999 (or more)
			rateInfosX : -45, // relative position in X axis of the info box when mouseover
			rateInfosY : 5, // relative position in Y axis of the info box when mouseover
			nbRates : 1,

			/** Functions **/
			onClick :null
		}; 

		if(this.length>0)
		return this.each(function() {
			/*vars*/
			var opts = $.extend(defaults, op),    
			newWidth = 0,
			starWidth = 0,
			starHeight = 0,
			bgClass = '',
			globalWidth = 0,
			nbOfRates = opts.nbRates;

			if($(this).hasClass('jDisabled') || opts.isDisabled)
				var jDisabled = true;
			else
				var jDisabled = false;

			getStarWidth();
			$(this).height(starHeight);
			var averageValue = parseFloat($(this).attr('data-average')), // get the average of all rates
			firstValue = parseFloat(('undefined' == typeof $(this).attr('data-initValue'))?0:$(this).attr('data-initValue')), // get the average of all rates
			idBox = parseInt($(this).attr('data-id')), // get the id of the box
			widthRatingContainer = starWidth*opts.length, // Width of the Container
			widthColor = averageValue/opts.rateMax*widthRatingContainer, // Width of the color Container
			firstWidth = firstValue/opts.rateMax*widthRatingContainer, 
			quotient = 
			$('<div>', 
			{
				'class' : 'jRatingColor',
				css:{
					width:widthColor
				}
			}).appendTo($(this)),

			average = 
			$('<div>', 
			{
				'class' : 'jRatingAverage',
				css:{
					width:firstWidth,
					top:- starHeight
				}
			}).appendTo($(this)),

			 jstar =
			$('<div>', 
			{
				'class' : 'jStar '+bgClass,
				css:{
					width:widthRatingContainer,
					height:starHeight,
					top:- (starHeight*2),
				}
			}).appendTo($(this));
			globalWidth = firstWidth;
			$(this).data("rating",{value:firstWidth,average:averageValue,starWidth:starWidth,globalWidth:globalWidth});

			$(this).css({width: widthRatingContainer,overflow:'hidden',zIndex:1,position:'relative'});
			
			if(!jDisabled)
			$(this).unbind().bind({
				mouseenter : function(e){
					var realOffsetLeft = findRealLeft(this);
					var relativeX = e.pageX - realOffsetLeft;
					if (opts.showRateInfo)
					var tooltip = 
					$('<p>',{
						'class' : 'jRatingInfos',
						html : getNote(relativeX)+' <span class="maxRate">/ '+opts.rateMax+'</span>',
						css : {
							top: (e.pageY + opts.rateInfosY),
							left: (e.pageX + opts.rateInfosX)
						}
					}).appendTo('body').show();
				},
				mouseover : function(e){
					$(this).css('cursor','pointer');	
				},
				mouseout : function(){
					$(this).css('cursor','default');
					average.width($(this).data("rating").globalWidth);
				},
				mousemove : function(e){
					var realOffsetLeft = findRealLeft(this);
					var relativeX = e.pageX - realOffsetLeft;
					if(opts.step) newWidth = Math.floor(relativeX/starWidth)*starWidth + starWidth;
					else newWidth = relativeX;
					average.width(newWidth);					
					if (opts.showRateInfo){
						var info = "";
						if(opts.customInfo instanceof Array && opts.customInfo.length>0){
							var rate = parseInt(getNote(newWidth));
							if(rate==0){rate=1;}
							if(opts.customInfo.length >= rate){
								info = opts.customInfo[rate-1];
							}
						}else{
							info = getNote(newWidth) +' <span class="maxRate">/ '+opts.rateMax+'</span>'
						}
					
						$("p.jRatingInfos").css({
							left: (e.pageX + opts.rateInfosX)
						}).html(info);
					}
					
				},
				mouseleave : function(){
					$("p.jRatingInfos").remove();
				},
				click : function(e){
                    var element = this;
					
					/*set vars*/
					globalWidth = newWidth;
					var dataOpt = $(this).data("rating");
					dataOpt.globalWidth = globalWidth;
					$(this).data("rating",dataOpt);
					nbOfRates--;
					
					if(!opts.canRateAgain && parseInt(nbOfRates) <= 0) $(this).unbind().css('cursor','default').addClass('jDisabled');
					
					if (opts.showRateInfo) $("p.jRatingInfos").fadeOut('fast',function(){$(this).remove();});
					e.preventDefault();
					var rate = getNote(newWidth);
					var dataOpt = $(this).data("rating");
					dataOpt.value=rate;
					$(this).data("rating",dataOpt);
					average.width(newWidth);
					if(opts.onClick) opts.onClick( rate ,idBox);
				}
			});

			function getNote(relativeX) {
				var noteBrut = parseFloat((relativeX*100/widthRatingContainer)*opts.rateMax/100);
				switch(opts.decimalLength) {
					case 1 :
						var note = Math.round(noteBrut*10)/10;
						break;
					case 2 :
						var note = Math.round(noteBrut*100)/100;
						break;
					case 3 :
						var note = Math.round(noteBrut*1000)/1000;
						break;
					default :
						var note = Math.round(noteBrut*1)/1;
				}
				return note;
			};

			function getStarWidth(){
				switch(opts.type) {
					case 'small' :
						starWidth = 12; // width of the picture small.png
						starHeight = 10; // height of the picture small.png
						bgClass = opts.smallStarsBg;
					break;
					default :
						starWidth = 23; // width of the picture stars.png
						starHeight = 20; // height of the picture stars.png
						bgClass = opts.bigStarsBg;
				}
			};

			function findRealLeft(obj) {
			  if( !obj ) return 0;
			  return obj.offsetLeft + findRealLeft( obj.offsetParent );
			};
		});
	}
	$.extend($.fn.datagrid.defaults.editors, {
		jrating : {
			init : function(container, options) {
				var editor = $('<div  data-average="0" data-id="1"></div>').appendTo(container);
				var opt = {};
				if(typeof op != "string"){
					var opts = $.extend(opt, options)
				}
				editor.jRating(opt);
				return editor;
			},
			destroy : function(target) {
				$(target).jRating('destroy');
			},
			getValue : function(target) {
				return $(target).jRating('getValue');
			},
			setValue : function(target, value) {
				$(target).jRating('setValue', value);
			},
			resize : function(target, width) {
				
			}
		}
});
})(jQuery);
