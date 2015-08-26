<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/WEB-INF/pages/commonInclude.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<title>��������ͷλ��</title>



</head>
  

<body class="easyui-layout">   
    <div data-options="region:'center'" style="padding:5px;background:#eee;">
	    <div id="cc" class="easyui-layout" data-options="fit:true">   
		 	<!-- ��ͼ����start  -->   
		    <div data-options="region:'center',title:'���ĵ�ͼ����',split:true" >
		    	<div id="map" > </div>
		    </div> 
		    <!-- ��ͼ����end  -->   
		    <!-- ��������start  -->  
	    	<div data-options="region:'east',iconCls:'icon-reload',title:'����',split:true" style="width:300px;">
				<table id="dg" class="easyui-datagrid" data-options="method:'post',toolbar:'#datagridToolbar',
					
		            method:'post',
		            singleSelect:true,
		            rownumbers:true,
		            selectOnCheck:true,
		            checkOnSelect:true,
		            border:false,
		            sortOrder:'asc',
		            sortName:'dwmc',
		            idField:'id',
		            pageSize:getAutoPageSize(),
		            pageList:[getAutoPageSize(),getAutoPageSize() * 2]">
						    <thead>
						        <tr>
						            <th data-options="field:'dwmc', width:15,	align:'left',	halign:'center',sortable:true">��λ����</th>
						            <th data-options="field:'jd', width:25,	align:'left',	halign:'center',sortable:true">����</th>
						            <th data-options="field:'wd', width:15,	align:'left',halign:'center',sortable:true">γ��</th>
						            <th data-options="field:'process',width:10,align:'center',	halign:'center',formatter:datagridProcessFormater">���¶�λ</th>
						        </tr>

						    </thead>
						</table>
				<!-- ������  -->
				<div id="datagridToolbar" style="padding:5px;height:30px;width:100%">
				   	<table width="100%">				   	
				   	<tr>
					   	<td>��ʼ���ڣ�</td>
					   	<td>
					   		<input type="text" name="startDate" id="startDate"  class="easyui-validatebox "   style="width:100px;" value="2014-12-23"
							data-options="required:false,tipPosition:'right',validType:['date[\'yyyy-MM-dd\']']"  onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" /></td>
					   	</td>
					</tr>
					<tr>
					   	<td>�������ڣ�</td>
					   	<td>
					   		<input type="text" name="endDate" id="endDate"  class="easyui-validatebox "   style="width:100px;"  value="2014-12-23"
							data-options="required:false,tipPosition:'right',validType:['date[\'yyyy-MM-dd\']']"  onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" /></td>
					   	</td>
				    </tr>
			        <tr>
			        	<td>
			        	<img src ="<%=contextPath%>/images/search_btn_sousuo_01.png" style="cursor: pointer;height:32px" onclick="searchSxt();"/>
			        	</td>
			        </tr>				    
				    </table>
					
				</div>
    
    		</div>
    		<!-- ��������end  --> 
    	</div>
    	<!-- div id="cc" end  -->  
    </div>
     <!-- data-options="region:'center'" end  -->
</body>      
<script type="text/javascript">

//�Զ�����--��λ
function datagridProcessFormater(val, row, index) { // �Զ����������
  return '&nbsp;<a class="link" href="javascript:javascript:void(0)" onclick="doLocation(this,'+index+')">��ϸ��Ϣ</a>&nbsp;&nbsp;';
}
//��ʼ��λ

function doLocation(linkObject, index) {
	var datagrid_ID = getDatagrid_ID(0, linkObject);
	var rows = $('#' + datagrid_ID).datagrid('getData');
	var rowData = rows.rows[index];
	
	alert(index+","+rowData['id']+","+rowData['dwmc']);

	alert(rows.length);	
}

	//����������������ͷ
	function searchSxt(){
		var startDate=$('#startDate').val();//��ʼ����
		var endDate=$('#endDate').val();//��������		
	
		var reloadUrl  = contextPath + '/sptgl/querySpsxtForMap2?locate=N';//û�����������ͷ
		alert(startDate+","+endDate+","+reloadUrl);
		var opt = $('#dg').datagrid('options');
		opt.url = reloadUrl;
		//opt1.url = reloadUrl;	
		alert(opt.url);	
		$('#dg').datagrid('reload',{startDate:startDate,endDate:endDate	});
	
	}

</script>
</html>
