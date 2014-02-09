(function ($) {
            $.fn.extend({
            	"fixedTable" : function(options) {
            		var _setting = $.extend({
            			height: 300
            		}, options),
            		$table = $(this),
            		$tbody = $table.find("tbody"),		// 表格体
            		$thead = $table.find("thead"),		// 表格头
            		$tfoot = $table.find("tfoot"),		// 表格脚
            		$rowCount = $tbody.find("tr"),		// 当前表格总行数
            		tdWidths = new Array();				// 行宽
            		
            		// 如果当前的表格总高度大于记录条数的总高度，则终止执行
            		if ($($rowCount[0]).height() * $rowCount.length < _setting.height) {
            			return false;
            		}
            		
            		// 否则，开始生成带滚动条的表格
            		$table.wrap('<div style="width: 100%" class="div-tbody" style="overflow: auto"></div>');
            		$table.css("width", $table.width());
            		$table.removeAttr("width");
            		var $divBody = $table.closest(".div-tbody");
            		var $divHead = $('<div style="width: 100%" class="div-thead"><table width="100%" class="head-table"></table></div>').prependTo($divBody.parent());
            		var $divFoot = $('<div style="width: 100%" class="div-tfoot"><table width="100%" class="foot-table"></table></div>').appendTo($divBody.parent());

            		// 获取单元格宽度
            		var tds = $($divBody.find("table").find("tbody").find("tr")[0]).find("td");
            		for(var i = 0; i < tds.length; i++) {
            			tdWidths[i] = $(tds[i]).width();
            		}
            		
            		/*
            		 * 生成表头
            		 */
            		// 获取表头行并生成表头
            		var headTr = $thead.find("tr");
            		for(var i = 0; i < headTr.length; i++) {
            			$divHead.find(".head-table").append(headTr[i]);
            		}
            		$divHead.find(".head-table").addClass("list_table");
            		// 填充生成表头宽度
            		var newTHs = $divHead.find(".head-table").find("th");
            		for(var i = 0; i < newTHs.length; i++) {
            			if (i < newTHs.length - 1) {
            				if (i < newTHs.length - 1) {
            					$(newTHs[i]).removeAttr("width");
            					$(newTHs[i]).css("width", tdWidths[i]);
            				}
            			}
            		}

            		/*
            		 * 生成表格体
            		 */
            		// 设置body的高度
            		$divBody.css({
            			"overflow-y" : "scroll",
            			"overflow-x" : "hidden",
            			"height" : _setting.height
            		});
            		for(var i = 0; i < tds.length; i++) {
            			if (i < tds.length - 1) {
            				$(tds[i]).css("width", tdWidths[i]);
            			}
            		}
            		
            		/*
            		 * 生成表格脚
            		 */
            		// 获取表头行并生成表头
            		var footTr = $tfoot.find("tr");
            		for(var i = 0; i < footTr.length; i++) {
            			$divFoot.find(".foot-table").append(footTr[i]);
            		}
            		$divFoot.find(".foot-table").addClass("list_table");
            		//去除right-frame的scroll。
            		var _scrollHeight = $(document).height() - $(window).height();
            		if(_scrollHeight > 0){
            			$divBody.css("height",_setting.height-_scrollHeight-1);
            		}
            		return this;
            	},
                "alterBgColor": function (options) {
                    var _table = this;
                    //设置默认值
                    options = $.extend({
                        odd: "list_table_odd", /* 偶数行样式*/
                        even: "list_table_even", /* 奇数行样式*/
                        selected: "list_table_selectrow", /* 选中行样式*/
                        singleCheck:"",
                        multipleCheck:""
                    }, options);
                    var singleCheckArray = options.singleCheck.split(",");
                    var multiCheckArray = options.multipleCheck.split(",");
                    _temp_checkButton();
                    $("tbody>tr:odd", this).addClass(options.odd);
                    $("tbody>tr:even", this).addClass(options.even);
                    $('tbody>tr', this).click(function () {
                        //判断当前是否选中
                        var hasSelected = $(this).hasClass(options.selected);
                        //如果选中，则移出selected类，否则就加上selected类
                        $(this)[hasSelected ? "removeClass" : "addClass"](options.selected)
                            //查找内部的checkbox,设置对应的属性。
                                .find(':checkbox').attr('checked', !hasSelected);
                        _temp_checkButton();
                    });
                    //表头中的checkbox （全选 反选）
                    $("tbody>tr th:first :checkbox:first ",this).click(function () {
                        //判断当前是否选中
                        var hasSelected = this.checked;
                        //如果选中，则移出selected类，否则就加上selected类
                        $('tbody>tr:gt(0)',_table)[!hasSelected ? "removeClass" : "addClass"](options.selected);
                        if (hasSelected){
                            $(this).attr("checked",true);
                        	$('tbody>tr :checkbox',_table).attr("checked",true);
                        } else{
                            $(this).attr("checked",false);
                        	$('tbody>tr :checkbox',_table).attr("checked",false);
                        }
                    });
                    // 如果单选框默认情况下是选择的，则高色.
                    $('tr:has(:checked)', this).addClass(options.selected);
                    function _temp_checkButton(){
                        var checkSize = $(":checkbox:checked",_table).size();
                        for(i=0;i<multiCheckArray.length;i++){
                        	if(checkSize > 0){
                        		$("#"+multiCheckArray[i]).removeAttr("disabled");
                        	}else{
                        		$("#"+multiCheckArray[i]).attr("disabled","true");
                        	}
                            
                        }
                        for(i=0;i<singleCheckArray.length;i++){
                        	if(checkSize == 1){
                        		$("#"+singleCheckArray[i]).removeAttr("disabled");
                        	}else{
                        		$("#"+singleCheckArray[i]).attr("disabled","true");
                        	}
                        }
                    }

                    return this;  //返回this，使方法可链。
                }
            });
        })(jQuery);
 
 