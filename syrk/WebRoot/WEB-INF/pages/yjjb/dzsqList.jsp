<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.founder.framework.config.SystemConfig" %>
<%@include file="/WEB-INF/pages/commonInclude.jsp"%>
<%@ page import="com.founder.framework.base.entity.SessionBean"%>
<%
    SessionBean userInfo = (SessionBean)session.getAttribute("userSession");
    String userOrgCode = "";
    String bjzbz = "";
    if(userInfo!=null){
        userOrgCode = userInfo.getUserOrgCode();
        bjzbz = userInfo.getBjzbz();
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>线索递转申请列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
  </head>
  <body class="easyui-layout" data-options="fit:true">
	    <div data-options="region:'center',border:false">
    	<div class="easyui-layout" data-options="fit:true,border:false">   
            <div data-options="region:'center',split:true,title:'自动执行任务',border:true" style="height:auto">
			<table id="dg" class="easyui-datagrid" data-options="url:'<%=basePath %>xsdzsqb/query',toolbar:'#datagridToolbar',
			            singleSelect:false,
			            selectOnCheck:true,checkOnSelect:true,border:false,sortOrder:'desc',sortName:'xt_zhxgsj',
			            	idField:'id',pageSize:getAutoPageSize(175),pageList:[getAutoPageSize(175),getAutoPageSize(175) * 2],
			            	onDblClickRow:dbClickRow
			            	">
			  <!-- 查询结果模块 -->
			    <thead>
			        <tr>
			       	 	<th data-options="checkbox:true,align:'center',halign:'center'"></th>
			       	 	<th data-options="field:'id',       width:20,   align:'center',	halign:'center'	,sortable:true">申请编号</th>
			       	 	<th data-options="field:'xsbh',     width:20,   align:'center',	halign:'center'	,sortable:true">线索编号</th>
				        <th data-options="field:'dzfqdw',   width:20,   align:'center',	halign:'center'	,sortable:true,formatter:dictFormatter,dictName:'<%=basePath %>common/queryOrg?orgCode=210200000000'">申请单位</th>
				        <th data-options="field:'dzjsdw',   width:20,   align:'center',	halign:'center'	,sortable:true,formatter:dictFormatter,dictName:'<%=basePath %>common/myOrg?type=DZSQ'">接收单位</th>
				        <th data-options="field:'sqsj',     width:20,   align:'center',	halign:'center'	,sortable:true">申请时间</th>
				        <th data-options="field:'spzt',     width:20,   align:'center',	halign:'center'	,sortable:true,formatter:dictFormatter,dictName:contextPath+'/common/dict/D_BZ_SQZT.js'">审批状态</th>
				        <th data-options="field:'process',	width:20,   align:'center',	halign:'center',formatter:datagridProcessFormater">操作</th>
			         </tr>
				</thead>
			</table>
			<!-- 查询条件模块 -->
			<div id="datagridToolbar" style="padding:5px;height:auto" >
					
					<!-- 表格工具条按钮 -->
					<form id="queryForm">
						<table cellspacing="0" cellpadding="0" border="0" >
							<tbody>
							<tr>
							<td class="toolbarTd" style="width:250px">
									开始时间：<input class="easyui-validatebox" type="text" name="starttime" id="starttime" 
										data-options="required:false,validType:['date[\'yyyy-MM-dd\']'],tipPosition:'right'" 
										onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" 
										style="width:160px;" />
								</td>
								<td class="toolbarTd"><div class="datagrid-btn-separator"></div></td>
								<td class="toolbarTd" style="width:250px">
									结束时间：<input class="easyui-validatebox" type="text" name="endtime" id="endtime" 
										data-options="required:false,validType:['date[\'yyyy-MM-dd\']'],tipPosition:'right'" 
										onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" 
										style="width:160px;" />
								</td>
								<td class="toolbarTd"><div class="datagrid-btn-separator"></div></td>
								<td class="toolbarTd" style="width:250px">
									申请编号：<input class="easyui-validatebox" type="text" name="id" id="id" 
										data-options="required:false"  	style="width:160px;" />
								</td>
								<td class="toolbarTd"><div class="datagrid-btn-separator"></div></td>
								<td class="toolbarTd" style="width:250px">
									线索编号：<input class="easyui-validatebox" type="text" name="xsbh" id="xsbh" 
										data-options="required:false"  	style="width:160px;" />
								</td>
							</tr>								
							<tr>

								<td class="toolbarTd" style="width:250px">
									审批状态：<input class="easyui-combobox" type="text" name="spzt" id="spzt" 
										data-options="required:false,url: contextPath + '/common/dict/D_BZ_SQZT.js',
			    						valueField:'id',textField:'text',selectOnNavigation:false,method:'get'"  
										style="width:160px;" />
								</td>
								<td class="toolbarTd"><div class="datagrid-btn-separator"></div></td>
								<td class="toolbarTd" style="width:250px">
									申请单位：<input class="easyui-combobox" type="text" name="dzfqdw" id="dzfqdw" value=<%=userOrgCode %>
										data-options="required:false,url: '<%=basePath %>common/queryOrgLower?orgCode=<%=userOrgCode%>',
			    						valueField:'id',textField:'text',selectOnNavigation:false,method:'get'"  	style="width:160px;" />
								</td>
								<td class="toolbarTd"><div class="datagrid-btn-separator"></div></td>
								<td class="toolbarTd" style="width:250px">
									接收单位：<input class="easyui-combobox" type="text" name="dzjsdw" id="dzjsdw" 
										data-options="required:false,url: '<%=basePath %>common/myOrg?type=DZSQ',
			    						valueField:'id',textField:'text',selectOnNavigation:false,method:'get'"  	style="width:160px;" />
								</td>
							</tr>
								<tr>
									<td class="toolbarTd" align="right" colspan="7" style="padding-right:8px">
										<a class="easyui-linkbutton" iconCls="icon-search" onclick="queryButton();" >查询</a>
										<a class="easyui-linkbutton" iconCls="icon-reload" onclick="clearCase();" >重置</a>
										<a class="easyui-linkbutton" iconCls="icon-add" onclick="addNew();">新增</a>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
var addressPrefix = "<%=SystemConfig.getString("addressPrefix")%>";
var addressPrefixArray = addressPrefix.split(",");

//截地址字段
function subjzdz(val, row, index){
	for (var i = 0; i < addressPrefixArray.length; i++) {
		val = val.replace(addressPrefixArray[i], "");
	}
	return val;
}
//操作列
function datagridProcessFormater(val, row, index) { // 自定义操作生成
		
	var Process = '<a class="link" href="javascript:javascript:void(0)" onclick="doEdit(this,'+index+')">查看详细</a>';
	
    return Process;
}
  
function clearCase(){
	  $("#queryForm").form("reset");
}

//查询按钮
function queryButton(){
  	var starttime = document.getElementById("starttime").value;
  	var endtime = document.getElementById("endtime").value;
  	var spzt = document.getElementById("spzt").value;
  	var xsbh = document.getElementById("xsbh").value;
  	var dzfqdw = document.getElementById("dzfqdw").value;
  	var dzjsdw = document.getElementById("dzjsdw").value;
  	
	xsbh = $.trim(xsbh);
  	$('#dg').datagrid(
  			'reload',
  			{   'starttime':starttime,
  				'endtime':endtime,
  				'spzt':spzt,
  				'xsbh':xsbh,
  				'dzfqdw':dzfqdw,
  				'dzjsdw':dzjsdw
  			});
  }
  
function doEdit(linkObject, index){
		cancelBubble(); // 阻止冒泡，不然要执行onClickRow
		var hsUrl = "/xsjbxxb/openDZCK?";
		var datagrid_ID = getDatagrid_ID(0, linkObject);
		var opts = $('#' + datagrid_ID).datagrid("options");
		var rows = $('#' + datagrid_ID).datagrid('getData');
		var rowData = rows.rows[index];
		
		hsUrl+="xsbh="+rowData.xsbh+"&sqbh="+rowData.id+"&mainTabID="+getMainTabID();
		menu_open("查看详细",hsUrl);
  }
 
//暂停
// SYS_SYRK_11.	把自动执行任务表的任务状态修改为1，同时把操作里面暂停调整为“启动”
function doStop(linkObject,index){
	
}
//注销单条
  function doDelete(linkObject, index) {
	  cancelBubble(); // 阻止冒泡，不然要执行onClickRow
		var deleteUrl = contextPath + '/xsdzsqb/delete';
		var datagrid_ID = getDatagrid_ID(0, linkObject);
		var submitFields = ""; //  除主键之外需要提交的字段（多个用逗号分隔）
		
		topMessager.confirm('','您确认要注销数据吗？',function(r) {    
			if (r) {	
				var opts = $('#' + datagrid_ID).datagrid("options");
				var rows = $('#' + datagrid_ID).datagrid('getData');
				var rowData = rows.rows[index];
				var postFieldArray = [];
				postFieldArray.push(opts.idField);
				if (submitFields != "") {
					postFieldArray = postFieldArray.concat(submitFields.split(","));
				}
				var postData = {};
				for (var i = 0; i < postFieldArray.length; i++) {
					var postField = postFieldArray[i];
					if (rowData[postField]) {
						postData[postField] = rowData[postField];
					}
				}
				$.ajax({
					url: deleteUrl,
					type: 'POST',
					data: postData
				}).done(function(result) {
					doSubmitResult(result, null, datagrid_ID);
				});
			}
		});
  }
	
function dbClickRow(rowIndex,rowData){
	
	var hsUrl = "/xsjbxxb/openDZCK?";
	hsUrl+="xsbh="+rowData.xsbh+"&sqbh="+rowData.id+"&mainTabID="+getMainTabID();
	menu_open("查看详细",hsUrl);
}

function addNew(){
	var hsUrl = "/xsjbxxb/openAdd?";
	hsUrl+="&mainTabID="+getMainTabID();
	//mainTabID=1
	menu_open("新增线索",hsUrl);
}

function reloadDg(){
	$("#dg").datagrid("clearSelections");
	$('#dg').datagrid('reload');
}

//初查
function doCC(linkObject, index){
	cancelBubble(); // 阻止冒泡，不然要执行onClickRow
	var hsUrl = "/xsjbxxb/openCC?";
	var datagrid_ID = getDatagrid_ID(0, linkObject);
	var opts = $('#' + datagrid_ID).datagrid("options");
	var rows = $('#' + datagrid_ID).datagrid('getData');
	var rowData = rows.rows[index];
	
	hsUrl+="id="+rowData.id+"&mainTabID="+getMainTabID();
	//mainTabID=1
	menu_open("初查线索",hsUrl);
}

//复查
function doFC(linkObject, index){
	cancelBubble(); // 阻止冒泡，不然要执行onClickRow
	var hsUrl = "/xsjbxxb/openFC?";
	var datagrid_ID = getDatagrid_ID(0, linkObject);
	var opts = $('#' + datagrid_ID).datagrid("options");
	var rows = $('#' + datagrid_ID).datagrid('getData');
	var rowData = rows.rows[index];
	
	hsUrl+="id="+rowData.id+"&mainTabID="+getMainTabID();
	//mainTabID=1
	menu_open("复查线索",hsUrl);
}

// 查看案件
// TODO
function doAJ(linkObject, index){
	
	cancelBubble(); // 阻止冒泡，不然要执行onClickRow
	var hsUrl = '/forward/yjjb|xgajList?';
	var datagrid_ID = getDatagrid_ID(0, linkObject);
	var opts = $('#' + datagrid_ID).datagrid("options");
	var rows = $('#' + datagrid_ID).datagrid('getData');
	var rowData = rows.rows[index];
	
	hsUrl+="xsId="+rowData.id+"&mainTabID="+getMainTabID();
	//mainTabID=1
	menu_open("相关案件列表",hsUrl);
	
}

    </script>
  </body>
</html>
