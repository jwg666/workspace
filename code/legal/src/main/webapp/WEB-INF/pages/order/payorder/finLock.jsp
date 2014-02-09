<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/common/common_js.jsp"></jsp:include>
<script type="text/javascript" charset="utf-8">
var form;
	$(function() {
		form=$("#searchForm").form();
		var orderNum='${orderNum}'
		$.ajax({
			url:'${dynamicURL}/payorder/finLockAction!getfinlock.do',
			data:{
				orderNum:orderNum
			},
			dataType:'json',
			success:function(json){
				if(json.success){
					$("#searchForm").form('load',json.obj);
					//dateFormatYMD
					$('#lockDateid').val(dateFormatYMD($('#lockDateid').val()));
					$('#unlockDateid').val(dateFormatYMD($('#unlockDateid').val()));
				}else{
					$.messager.alert('提示',json.msg,'error');
				}
			}
		});
	});
</script>
</head>
<body class="zco">
	<div region="center" border="false" title="锁定明细" collapsed="true"  style="height: 200px;overflow: hidden;" align="left">
	<div data-options="region:'north'"  border="false" class="zoc" collapsed="false"  style="height: 199px;width : 100%;overflow: auto;" align="left">
		<form id="searchForm">
			
			<div class="part_zoc" region="north">
			<div class="oneline">
			     <div class="item25">
				    <div class="itemleft80">
					    锁定人
					</div>
					<div class="righttext">
					<input id="custCodeId" name="lockName" type="text" class="short50" />
					</div>
				 </div>
			      <div class="item25">
								<div class="itemleft80">锁定时间:</div>
								<div class="righttext_easyui">
									<input id="lockDateid" name="lockDate" type="text"
										class="short50"
										 />
								</div>
				  </div>
			    </div>
			    <div class="oneline">
			       
				 <div class="item25">
				    <div class="itemleft80">
					   解锁人
					</div>
					<div class="righttext">
					<input name="unlockName" class="short50"  type="text" />
					</div>
				 </div>
				 <div class="item25">
				    <div class="itemleft80">
					    解锁时间
					</div>
					<div class="righttext">
					<!-- <div class="rightbutt"><input name="createdEnd" class="short50"  type="image" src="img/more.png" /></div> -->
					<input id="unlockDateid" name="unlockDate" class="short50"  type="text" /> 
					</div>
				 </div>
			    </div>
			     <div class="oneline">
			        <div class="itemleft80">
					    备注
					</div>
					<div class="righttext">
					<!-- <div class="rightbutt"><input name="createdEnd" class="short50"  type="image" src="img/more.png" /></div> -->
					<input name="lockReason" class="long100"  type="text" /> 
					</div>
			     </div>
			</div>
		</form>
	</div>
	</div>
</body>
</html>