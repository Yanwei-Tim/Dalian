<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.founder.framework.config.SystemConfig" %>
<%@include file="/WEB-INF/pages/commonInclude.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<style type="text/css">
	.searchText {
	   font-size: 13px;
	   font-color: #222222;
	   height: 32px;
	   border: 1px solid #95B8E7;
	   line-height：32px;
	   padding-left: 5px;
	   padding-top: 8px;
	   width:200px;
	}

	.searchIcon {
		width:28px;
		height:28px;
   		background: url('<%=contextPath%>/images/search_icon.png') no-repeat center;
   		cursor: pointer;
	}
	
</style>
<script type="text/javascript">
  <!--
  var markerArr = parent.frames.markerArrSj;
  var option = parent.frames.options;
  
  function getParm(name){
	  var flag = ""; 
  	  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
  	  var r = window.location.search.substr(1).match(reg);
  	  if(r != null){
  		  flag = unescape(r[2]);
  	  } 
  	  return flag;
  }
  
  -->
</script>
</head>
<body class="easyui-layout" data-options="fit:true">  
    <div data-options="region:'center',border:false">
    	<div class="easyui-layout" data-options="fit:true,border:false">   
            <div data-options="region:'center',split:true,title:'',border:false" >
            	<table id="dg" class="easyui-datagrid" 
            	data-options="
            	queryParams: {'sjbh': getParm('sjbh'), 'cfxl': getParm('cfxl'), 'fqsj': getParm('fqsj'), 'jssj': getParm('jssj'), 'sjlx': getParm('sjlx'), 'sjmc': getParm('sjmc')},
            	url: '<%=basePath %>xj/querySj',
            	delayCountUrl:'<%=basePath %>xj/queryCountSj',
            	toolbar:'#datagridToolbar',
            		singleSelect:false,
            		selectOnCheck:true,
            		checkOnSelect:true,
            		border:true,
           			pagination:true,
  					rownumbers: 'true',
  			        sortName:'',
            		sortOrder:'desc',
            		idField:'id',
            		pageSize:5,
            		pageList:[5,10,300],
            		onSelect:onSelectRow,
            		onLoadSuccess:function(data){ loadPoints(data);},
            		fitColumns:true,
            		singleSelect:true">
            		<!-- onClickRow:doOnClickRow 单击行事件 --> 
				    <thead>
				        <tr>
				            <th data-options="field:'sjbh',width:60,align:'left',sortable:true,halign:'center'"> 事件编号</th>
				            <th data-options="field:'fasj',width:60,align:'center',sortable:true,halign:'center'">发生时间</th>
				            <th  data-options="field:'sjmc',width:60,align:'left',halign:'center',sortable:true,formatter:subjzdz">事件名称</th>
				            <th  data-options="field:'cfr',width:60,align:'left',halign:'center',sortable:true,formatter:subjzdz">触发人</th>
				            <th data-options="field:'zbx',hidden:true">zbx</th>
				            <th data-options="field:'zby',hidden:true">zby</th>
				        </tr>
				    </thead>
				</table>
			</div>
        </div>
    </div>   
</body>
<script type="text/javascript">

function onSelectRow(rowIndex, data){
	if(typeof(markerArr[rowIndex])!="undefined" && markerArr[rowIndex]!="" && markerArr[rowIndex]!=null){
		if (IE) {
			parent.frames["biz_center"].XjMap.centerByPoint(markerArr[rowIndex],19,data, 'sj');
		}else{
			var obj = parent.frames.document.getElementById("biz_center").contentWindow;
			obj.XjMap.centerByPoint(markerArr[rowIndex],19,data, 'sj');
		}
	}else{
		//alert("人员无坐标");
	}
}

var addressPrefix = "<%=SystemConfig.getString("addressPrefix")%>";
var addressPrefixArray = addressPrefix.split(",");

//截地址字段
function subjzdz(val, row, index){
	for (var i = 0; i < addressPrefixArray.length; i++) {
		val = val.replace(addressPrefixArray[i], "");
	}
	return val;
}

//页面载入画点
function loadPoints(data) {
	clearPoints();
	//延迟加载统计
	beforeTableLoad(data,'dg');
	//$(parent.frames.document.getElementById("biz_center")).mask("加载中...");
	var mapWindow = null;
	if (IE) {
		mapWindow = parent.frames["biz_center"];
	}
	else {
		mapWindow = parent.frames.document.getElementById("biz_center").contentWindow;
	}
	if ("undefined" != typeof mapWindow && mapWindow != null) {
		if (mapWindow.XjMap) {
			mapPoint(mapWindow);
		}
		else {
			setTimeout(function() {mapPoint(mapWindow);}, 3000);
		}
	}
}

function mapPoint(mapWindow) {
	if (mapWindow.XjMap) {
		//mapWindow.XjMap.clearMarkers();
		var rows = $('#dg').datagrid("getRows");
		var len = rows.length;
		for (var i = 0; i < len; i++) {
			var dz = rows[i].dz_jzdzxz;
			if (rows[i].zbx != null && rows[i].zbx != "") {
				if (option.indexOf('sj') != -1) {
					var marker = null;
					var img = "sj.png";
					if (IE) {
						marker = mapWindow.addMarker('',rows[i].zbx,rows[i].zby, img,null,null,34,34,false,rows[i], 'sj');
					}
					else {
						marker = mapWindow.addMarker('',rows[i].zbx,rows[i].zby, img,null,null,32,32,false,rows[i], 'sj');
					}
					markerArr.push(marker);
				}
			}
		}
	}
	//$(parent.frames.document.getElementById("biz_center")).unmask();
}

//清空已存在坐标点
function clearPoints(){
	var mapWindow = null;
	if (IE) {
		mapWindow = parent.frames["biz_center"];
	}
	else {
		mapWindow = parent.frames.document.getElementById("biz_center").contentWindow;
	}
	if ("undefined" != typeof mapWindow && mapWindow != null) {
		if(markerArr != null){
			var markerLen = markerArr.length;
			for(var j=0;j<markerLen;j++){
				mapWindow.XjMap.map._MapApp.removeOverlay(markerArr[j]);
			}
		}
	}
	mapWindow.XjMap.map._MapApp.closeInfoWindow();
}

</script>  

</html>