<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.founder.framework.base.entity.SessionBean"%>
<%@ include file="/WEB-INF/pages/commonInclude.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
	<title>����ͷ��ͼ��λ</title>
	<!-- ���������js�汾 
	<script type="text/javascript" src="<%=contextPath%>/js/jquery_1.5.min.js"></script>
	-->
	<!-- �þ��Ե�ַ���ã�������� -->
	<script type="text/javascript" src="http://10.80.1.165:9080/PGIS_S_TileMap1/js/EzMapAPI.js"></script>
	
	<style type="text/css">	
		v\:*{
			BEHAVIOR:url(#default#VML)
		}
	</style>
<script type="text/javascript">	

//���ݱ߽�����ֵ�������߽�����
function getRegionCenter(bjzbz){
	/*�����ͼ�����еı��*/
	//DmManage.map._MapApp.clear();
	/*�ǵ�����*/
	var bj = bjzbz.split(";");
	var bjnum = bj.length;
	/*��¼�������ĵ�����*/
	var DmManage={};
	DmManage.Mbr==null;
	//DmManage.mbrArr = new Array();
	//alert("region number="+bjnum);
	for(var j=0;j<bjnum;j++){
		var gArr = bj[j];
		/*�����߽�ͼԪ��*/

		var polyline = new Polyline(gArr, "#68228B",3,1);
		//alert("polyline:=>"+polyline);
		/*ͼԪ����ӵ���ͼ��*/
		if(polyline){
			_MapApp.addOverlay(polyline);//���ƶ��������߽���
			//DmManage.mbrArr.push(polyline);
			if(DmManage.Mbr==null){
				DmManage.Mbr = polyline.getMBR();
			}else{
				DmManage.Mbr = MBR.union(DmManage.Mbr,polyline.getMBR());
			}
		}
	}
	/*����ͼԪ�ؽ���ͼ�ŵ����ʺϵļ����λ��*/
	//DmManage.map._MapApp.centerAtMBR(DmManage.Mbr);
	/*�°汾cliect�Զ���Ӧ������������뽵һ��*/
	//DmManage.map._MapApp.zoomOut();
	return DmManage.Mbr;
}
//����2�����������߽����괮
function getBjzbzByOrgCode(){
	url="<%=contextPath%>/idName/getBjzbzByOrgCode";
	//alert(url);
	//���Ĵ˴���Ĭ��Ϊ�첽����
	$.getJSON(url,function(rsult){		
		g_bjzbz=rsult;//Ϊȫ�ֱ�����ֵ
		//alert(g_bjzbz);
		initMap();//��ʼ����ͼ
		
		
	});
	
}
    var g_bjzbz;// 
	//�������ĵ�����:121.61263,38.91223;     //��ͼ���ĵ�X,y	var _MapApp;//ȫ�ֱ���
	//��ʼ����ͼ
	function initMap(){
		// ʵ����EzMap�࣬
		_MapApp=new EzMap(document.getElementById("map"));
		_MapApp.showMapControl();//��ʾһ����ͼ�ؼ������𣬷Ŵ���С
		if(g_bjzbz!="" && g_bjzbz!=null){
			var regionMbr=getRegionCenter(g_bjzbz);//��ñ߽�����
			//_MapApp.centerAtMBR(polyline.getMBR());//����ͼƽ�Ƶ����˺��������������λ��
			_MapApp.centerAtMBR(regionMbr);
		}
		else{
			alert("g_bjzbzΪ���ˣ���");
		}
	
	}//end initMap()
	
	//���ݵ����ͼ��
	function drawOverlay(theJd,theWd){
		var pIcon=new Icon();
		pIcon.image=contextPath+"/images/jfxt/dz_zb01.png";//��ɫͼ��
		pIcon.height=25; 
		pIcon.width=25;				
		var newMarker = new Marker(new Point(theJd,theWd),pIcon); //ʵ����һ�����
		_MapApp.addOverlay(newMarker);//��ӵ�ǰ����
		newMarker.flash();//��˸��
		return newMarker;
	}

	
	//�������괦������ͷ
	var sxtMapping={}; //�����Ѿ���λ��ÿһ������ͷ��Ϣ	
	function drawNewPoint(rowIndex){
	
			var rows = $('#dgSxt').datagrid('getData');//��ñ���ж���
			var rowData = rows.rows[rowIndex];//����ΪrowIndex���ж���
			//�����Ϣ
			var message="���ƣ�"+rowData.dwmc+"<br>���ȣ�"+rowData.jd+"<br>γ�ȣ�"+rowData.wd;
			var link="<a href='javascript: redrawNewPoint("+rowIndex+")'>���¶�λ</a>"//modify :�����±�
			message+="<br>"+link;	
							
			//alert("��������:"+rowData['id']+","+rowData['dwmc']);//��ʾ���ж�Ӧ������
			var theJd=rowData['jd'];
			var theWd=rowData['wd'];
			//if((sxtMapping[rowData.id]=='undefined') || (sxtMapping[rowData.id]==null)){//�õ���δ��ע�ڵ�ͼ��
			if(!(sxtMapping[rowData.id])){//�õ���δ��ע�ڵ�ͼ��
				//alert("�õ���δ��ע�ڵ�ͼ��,�����ע��:");
				if(!theJd){//��ǰ��(����ͷ)��δ������
					alert("ʹ��ͼ���ڻ���״̬��׼������");			
					//�ı��ͼģʽΪ����
					_MapApp.changeDragMode('drawPoint',null,null,function(result){
						//�����λ�ò���������Ϣ���Ա�Ϊ�޸���׼��
						var coordArray=result.split(',');
						theJd=coordArray[0];
						theWd=coordArray[1];
						var newMarker=drawOverlay(theJd,theWd);//��ͼ��
						sxtMapping[rowData.id]=newMarker;//������������
						updateCoordinate(rowData.id,theJd,theWd);//����������굽���ݿ�
						//�޸ĸ��о�γ���е�ֵ
						$('#dgSxt').datagrid('updateRow',{index: rowIndex,row: {jd:theJd,wd: theWd}});
						//Ϊ�±������click�¼�������
						newMarker.addListener("click",function(){
							/*
							var msg="���ƣ�"+rowData.dwmc+"<br>����:"+rowData.jd+",γ��:"+rowData.wd;
							var link="<a href='javascript: redrawNewPoint("+rowIndex+")'>���¶�λ</a>"//modify :�����±�
							msg+="<br>"+link
							*/
							var msg="���ƣ�"+rowData.dwmc+"<br>���ȣ�"+theJd+"<br>γ�ȣ�"+theWd;
							var link="<a href='javascript: redrawNewPoint("+rowIndex+")'>���¶�λ</a>"//modify :�����±�
							msg+="<br>"+link							
							newMarker.openInfoWindowHtml(msg);//��ʾ����ͷ��λ��Ϣ
							//newMarker.flash();//��˸ ��������˸Ч������Ϊ�ظ���λ��ס��
							
						});					
					});
				}//end if(!theJd)
				else{//��ǰ��(����ͷ)�о�γ��
					//alert('draw point...');
					var newMarker=drawOverlay(theJd,theWd);//��ͼ��
					sxtMapping[rowData.id]=newMarker;//������������
					var pp=newMarker.getPoint();
					_MapApp.centerAndZoom(pp,  _MapApp.getZoomLevel());//����			
					_MapApp.openInfoWindow(pp,message);//������Ϣ��new Point(longitude,latitude)
					
					//Ϊ�±������click�¼�������
					newMarker.addListener("click",function(){
						//var msg="���ƣ�"+rowData.dwmc+"<br>����:"+rowData.jd+",γ��:"+rowData.wd;
						//var link="<a href='javascript: redrawNewPoint("+rowIndex+")'>���¶�λ</a>"//modify :�����±�
						//msg+="<br>"+link
						newMarker.openInfoWindowHtml(message);//��ʾ����ͷ��λ��Ϣ
						//newMarker.flash();//��˸ ��������˸Ч������Ϊ�ظ���λ��ס��
						
					});
				}//end else

			}
			else{//�õ����
				//��˸�õ�
				//alert('�ɵ�:');
				var existsPoint=sxtMapping[rowData.id];//ȡ����������
				var pp=existsPoint.getPoint();
				_MapApp.centerAndZoom(pp,  _MapApp.getZoomLevel());//����			
				_MapApp.openInfoWindow(pp,message);//������Ϣ��new Point(longitude,latitude)
				//existsPoint.showTilte();//click();
				existsPoint.flash();//��˸��
			}
	}
	//�޸ĵ�λ��(���»�ͼ��)
	function redrawNewPoint(rowIndex){
		var rows = $('#dgSxt').datagrid('getData');//��ñ���ж���
		var rowData = rows.rows[rowIndex];//����ΪrowIndex���ж���
		//�����Ϣ
		var message="���ƣ�"+rowData.dwmc+"<br>���ȣ�"+rowData.jd+"<br>γ�ȣ�"+rowData.wd;
		var link="<a href='javascript: redrawNewPoint("+rowIndex+")'>���¶�λ</a>"//modify :�����±�
		message+="<br>"+link;	
		//����λ�����»���
		//�ı��ͼģʽΪ����
		_MapApp.changeDragMode('drawPoint',null,null,function(result){
			//�����λ�ò���������Ϣ���Ա�Ϊ�޸���׼��
			var coordArray=result.split(',');
			var theJd=coordArray[0];
			var theWd=coordArray[1];			
			var existsPoint=sxtMapping[rowData.id];//ȡ����������
			existsPoint.closeInfoWindowHtml();//�ر�����,������������ĵ���û�У�
			_MapApp.removeOverlay(existsPoint);//ɾ�����
			var newMarker=drawOverlay(theJd,theWd);//����ͼ��
			sxtMapping[rowData.id]=newMarker;//����ͼ���滻��ͼ��	
			//���¸��о�γ���е�ֵ
			$('#dgSxt').datagrid('updateRow',{index: rowIndex,row: {jd:theJd,wd: theWd}});
			//���ñ��水ť���ܱ��汾�θ��ĵ����ݿ�
			//alert('׼������');
			updateCoordinate(rowData.id,theJd,theWd);
			
			//Ϊ�±������click�¼�������
			newMarker.addListener("click",function(){
				//var msg="���ƣ�"+rowData.dwmc+"<br>����:"+rowData.jd+",γ��:"+rowData.wd;
				//var link="<a href='javascript: redrawNewPoint("+rowIndex+")'>���¶�λ</a>"//modify :�����±�
				//msg+="<br>"+link
				newMarker.openInfoWindowHtml(message);//��ʾ����ͷ��λ��Ϣ
				//newMarker.flash();//��˸ ��������˸Ч������Ϊ�ظ���λ��ס��
			});			
		});
			
	}
	
//�޸�����
function updateCoordinate(rowId,longitudeNew,latitudeNew){
	//alert(rowId+","+longitudeNew+","+latitudeNew);
	//�������ݿ�
	var url="<%=contextPath%>/sptgl/modifyCoordinateById";
	var params={id:rowId,jd:longitudeNew,wd:latitudeNew};
	//����json��ʽ���ַ���
	$.getJSON(url,params,function(result){
		var msg=(result>0)?"��λ��λ���Ѿ�����":"����ʧ�ܣ����뿪������ϵ(88058977)";
		alert(msg);
	});				
}

//���ڳ�ʼ��
function initDate(){
	function formatDate(curDate){
		var month=curDate.getMonth()+1;
		if(month<10) month='0'+month;
		var days=curDate.getDate();
		if(days<10) days='0'+days;
		var curDateString=curDate.getFullYear()+"-"+month+"-"+days;
		return curDateString;
	}
	
	var date1=new Date();
	var startDate=formatDate(new Date(date1.getTime()-2*24*60*60*1000));
	$('#startDate').val(startDate);
	var endDate=formatDate(date1);
	$('#endDate').val(endDate);
	
	//alert(startDate+"---"+endDate);
	
	
	
}
//����ϴα���ĵ�λ�������ͼ���
function clearSxtMapping(){
	//alert('clearSxtMapping');
	for(obj in sxtMapping){
		_MapApp.removeOverlay(sxtMapping[obj]);//ɾ����ͼ���
		delete sxtMapping[obj];//ɾ������
	}
	//alert('clearComplete....');
}

//�����￪ʼִ�д���
$(function(){
	initDate();
	//���¶��������Ĳ˵�����������Ҽ�Ϊ��ͼƽ��(��ȡ���������)
	document.oncontextmenu =function(){
		_MapApp.changeDragMode("pan", null, null, null);
	}
	
	//alert(g_parentTabPageID);
	getBjzbzByOrgCode();//�����߽����괮
	//initMap();//��ʼ����ͼ
	
})


</script>	

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
				<table id="dgSxt" class="easyui-datagrid" data-options="method:'post',toolbar:'#datagridToolbar',					
		            method:'post',
		            singleSelect:true,		            
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
						            <th data-options="field:'jd', width:15,	align:'left',	halign:'center',sortable:true">����</th>
						            <th data-options="field:'wd', width:15,	align:'left',halign:'center',sortable:true">γ��</th>
						            <th data-options="field:'process',width:10,align:'center',	halign:'center',formatter:datagridProcessFormater">�޸�λ��</th>
						        </tr>

						    </thead>
						</table>
				<!-- ������  -->
				<div id="datagridToolbar" style="padding:5px;height:30px;width:100%">
				   	<table width="100%">				   	
				   	<tr>
					   	<td width="60">��ʼ���ڣ�</td>
					   	<td>
					   		<input type="text" name="startDate" id="startDate"  style="width:100px;" value="2014-12-23"
							data-options="required:false,tipPosition:'right',validType:['date[\'yyyy-MM-dd\']']"  onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" /></td>
					   	</td>
					</tr>
					<tr>
					   	<td>�������ڣ�</td>
					   	<td>
					   		<input type="text" name="endDate" id="endDate"    style="width:100px;"  value="2014-12-26"
							data-options="required:false,tipPosition:'right',validType:['date[\'yyyy-MM-dd\']']"  onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" /></td>
					   	</td>
				    </tr>
					<tr>
					   	<td>����ͷ����:</td>
					   	<td>
					   		<input type="text" name="sxtName" id="sxtName"  />							
					   	</td>
				    </tr>						    
			        <tr>
			        	<td colspan="2">
			        	<img src ="<%=contextPath%>/images/search_btn_sousuo_01.png" style="cursor: pointer;height:32px" onclick="searchSxt();"/>
			        	<input type="checkbox" id="noCoordinate" checked="checked" value="Y">�޾�γ�ȵ�����ͷ
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
  return '&nbsp;<a class="link" href="javascript:javascript:void(0)" onclick="doLocation(this,'+index+')">�޸�</a>&nbsp;&nbsp;';
}
//��ʼ��λ
function doLocation(linkObject, index) {
	var datagrid_ID = getDatagrid_ID(0, linkObject);
	var rows = $('#' + datagrid_ID).datagrid('getData');
	var rowData = rows.rows[index];//������ж���
	//alert("���ж�Ӧ������:"+rowData['id']+","+rowData['dwmc']);//��ʾ���ж�Ӧ������
	drawNewPoint(index);

}

//����������������ͷ
function searchSxt(){
	clearSxtMapping();//����ϴα���ĵ�λ�������ͼ���
	var startDate=$('#startDate').val();//��ʼ����
	var endDate=$('#endDate').val();//��������	
	var sxtName=$('#sxtName').val();//����ͷ����	
	var noCoordinate=document.getElementById('noCoordinate').checked ? "Y":"N";
	//alert(noCoordinate);
	var reloadUrl  = contextPath + '/sptgl/querySpsxtForMap2';
	//alert(startDate+","+endDate+","+reloadUrl);
	var opt = $('#dgSxt').datagrid('options');
	opt.url = reloadUrl;
	//opt1.url = reloadUrl;	
	//alert(opt.url);	
	$('#dgSxt').datagrid('reload',{startDate:startDate,endDate:endDate,dwmc:sxtName,locate:noCoordinate});

}

//���ڳ�ʼ��
function initDate(){
	function formatDate(curDate){
		var month=curDate.getMonth()+1;
		if(month<10) month='0'+month;
		var days=curDate.getDate();
		if(days<10) days='0'+days;
		var curDateString=curDate.getFullYear()+"-"+month+"-"+days;
		return curDateString;
	}
	
	var date1=new Date();
	var startDate=formatDate(new Date(date1.getTime()-2*24*60*60*1000));
	$('#startDate').val(startDate);
	var endDate=formatDate(date1);
	$('#endDate').val(endDate);
	
	//alert(startDate+"---"+endDate);
	
}
//2014.12.24.
$(function(){
	initDate();
	//����ҳ��������
	$('#dgSxt').datagrid('getPager').pagination({showRefresh:false,layout:['first','prev','next','last']})	
	
}) 

</script>
</html>
