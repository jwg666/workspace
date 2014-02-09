// postJSON方法
jQuery.extend( {
	postJSON : function(url, data, callback) {
		jQuery.ajax( {
			type :"POST",
			dataType :"json",
			url :url,
			data :data,
			success :callback
		});
	}
});
function formatDate(formatStr, fdate){
 var fTime, fStr = 'ymdhis';
 if (!formatStr)
  formatStr= "y-m-d h:i:s";
 if (fdate)
  fTime = new Date(fdate);
 else
  fTime = new Date();
 var formatArr = [
 fTime.getFullYear().toString(),
 (fTime.getMonth()+1).toString(),
 fTime.getDate().toString(),
 fTime.getHours().toString(),
 fTime.getMinutes().toString(),
 fTime.getSeconds().toString() 
 ];
 if(fTime.getHours()<10){
 formatArr[3]="0"+fTime.getHours();
 }
 if(fTime.getMinutes()<10){
 formatArr[4]="0"+fTime.getMinutes();
 }
 if(fTime.getSeconds()<10){
 formatArr[5]="0"+fTime.getSeconds();
 }
 for (var i=0; i<formatArr.length; i++) {
  formatStr = formatStr.replace(fStr.charAt(i), formatArr[i]);
 }
 return formatStr;
}