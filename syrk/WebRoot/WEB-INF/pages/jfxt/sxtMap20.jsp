<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/WEB-INF/pages/commonInclude.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>




<!-- 
<script type="text/javascript" src="http://10.80.5.222:9080/EzServerClientNew/js/EzMapAPI.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/tools/map/map.js"></script>
 -->
<!-- ���������js�汾 -->
<script type="text/javascript" src="<%=contextPath%>/js/jquery_1.5.min.js"></script>


<!-- �þ��Ե�ַ���ã�������� -->
<script type="text/javascript" src="http://10.80.1.165:9080/PGIS_S_TileMap1/js/EzMapAPI.js"></script>


<style type="text/css">
/**/	
	v\:*{
		BEHAVIOR:url(#default#VML)
	}

	.clickRow{
		background-color:#FFEFD5;
	}
	
	table tr{
		cursor:pointer;
	}
</style>



<script type="text/javascript">
	//�������ĵ�����:121.61263,38.91223;     //��ͼ���ĵ�X,y

	//������dataInputx,dataInputy�ڷ�������ĳ��js�ļ��ж���
	var markList=[];//Mark�����б�
	var _MapApp;//ȫ�ֱ���
	var currentMark;//��ǰ��λ����(Mark)
	//��ʼ����ͼ
	function initMap(){
		// ʵ����EzMap�࣬
		_MapApp=new EzMap(document.getElementById("map"));
		_MapApp.showMapControl();//��ʾһ����ͼ�ؼ������𣬷Ŵ���С
		_MapApp.centerAndZoom(new Point(121.77386, 39.30718),5);//����ָ���ĵ�ͼ�����ж���
		
		/*
		var uOverview=new OverView();//��ӥ�����
		uOverview.width=200;
		uOverview.height=200;
		uOverview.minLevel=5;
		uOverview.maxLevel=12;		
		_MapApp.addOverView(uOverview);
		*/
	
	}//end initMap()



	//new add:�����ض�λʱʹ�õĴ洢���飬ÿ�����²�ѯǰ�����
	var markerListForRelocate=[];

	//��������ͷ��λ
	function addCameraMark(){
			markerListForRelocate.length=0;//�������
			var url="<%=contextPath%>/sptgl/querySpsxtForMap?d="+(new Date()).getTime();
			var params={};//{'queryTimeSpan':30*9};//240ms
			//����json��ʽ���ַ���
			$.getJSON(url,params,function(cameraInfoList){			
				fillCameraInfo(cameraInfoList);//�ڵ�ͼ�ϱ�ע����ͷ
				//alert(cameraInfoList.length);
			});				

	}
	

	//�ڵ�ͼ�ϱ�ע����ͷ��Ϣ
	function fillCameraInfo(policeCarList){
		//����ÿһ������ͷ
		$.each(policeCarList,function(index,item){
			var pIcon=new Icon(); 
			pIcon.image=basePath+"images/jfxt/"+"dz_zb01.png"; 
			pIcon.height=25; 
			pIcon.width=25; 
			
			var pCoord=new Point(item.jd,item.wd);//����
			var marker = new Marker(pCoord,pIcon); //ʵ����һ�����
			marker['_ID']=item.id;//��������
			//markList.push(marker);//���Mark�����б���
			_MapApp.addOverlay(marker); //��ӱ�ǵ���ͼ��
			
			//add new:marker�����������ָ���±�λ��
			markerListForRelocate[index]=marker;
			
			//Ϊ�������click�¼�������
			marker.addListener("click",function(){
				var msg="���ƣ�"+item.dwmc+"<br>����:"+item.jd+",γ��:"+item.wd+"<br>��λ����:"+item.tm+",����:"+item.cx;
				var link="<a href='javascript: drawNewPoint("+index+")'>���¶�λ</a>"//modify :�����±�
				msg+="<br>"+link
				marker.openInfoWindowHtml(msg);//��ʾ����ͷ��λ��Ϣ
				marker.flash();//��˸ ��������˸Ч������Ϊ�ظ���λ��ס��
				//�ı�ͼ��
				//pIcon.image="images/GR_PIN.GIF";
				currentMark=marker;//���浱ǰmarker����
				//��ʾ��ǰ����ͷ��Ϣ
				var p=currentMark.getPoint();
				$('#id').val(item.id);//����Ψһ��ʶ
				$('#longitudeOld').val(p.x);
				$('#latitudeOld').val(p.y);
			}); 
            
            //������ͷ��λ��Ϣ���ж�����
            var $tr=$("<tr></tr>"); 

            $tr.append("<td>"+(index)+"</td>");//����(0)
            $tr.append("<td style='display:none'>"+item.tm+"</td>");//����(1)
            $tr.append("<td>"+item.jd+"</td>");//����(2)
            $tr.append("<td>"+item.wd+"</td>");//γ��(3)
            $tr.append("<td>"+item.dwmc+"</td>");//����ͷ����(��λ����)(4)
            $tr.append("<td style='display:none'>"+item.id+"</td>");//����ͷID(������)(5)
            $tr.append("<td style='display:none'>"+item.cx+"</td>");//����ͷcx������)(6)

            //var bs=item.id;//��ʶ
            //var longitude=item.jd;
            //var latitude=item.wd;
            
            //var msg="���ƣ�"+item.dwmc+"<br>����:"+item.jd+",γ��:"+item.wd+"<br>��λ����:"+item.tm+",����:"+item.cx;
            //var hypeLink="<a href='javascript: drawNewPoint("+index+")'>���¶�λ</a>"//modify :�����±�
            //var msg="����:"+item.dwmc+",����:"+item.cx+"<br>"+hypeLink;
            var curMarkerIndex=index;//��������
            //var rowInfo=bs+"@"+longitude+"@"+latitude+"@"+msg+"@"+curMarkerIndex;
            //$tr.data("rowInfo",rowInfo);//���������Ϣ���ж�����
            //$tr.data("rowInfo",item);//����һ����Ϣ������rowInfo��
            //$tr.append("<td>"+strDisplay+"</td>");//��ϸ��� 
            $("#infoTable").append($tr);//�����е�����
			
			
		});

	}
	
	//������ͷ������
	var dataInputx;
	var dataInputy;
	function drawNewPoint(idx){
			//add new :�õ���ǰ��������
			var oldMarker=markerListForRelocate[idx];

			//alert(oldMarker['_ID']);
			//_MapApp.changeDragMode('drawPoint',dataInputx,dataInputy,function(result){
			_MapApp.changeDragMode('drawPoint',null,null,function(result){
				//alert(result);	
				oldMarker.closeInfoWindowHtml();//�ر�����,������������ĵ���û�У�			
				_MapApp.removeOverlay(oldMarker);//�Ƴ���ǰ����				
				//�����λ�ò���������Ϣ���Ա�Ϊ�޸���׼��
				var coordArray=result.split(',');
				$('#longitudeNew').val(coordArray[0]);
				$('#latitudeNew').val(coordArray[1]);	

				var pIcon=new Icon();
				pIcon.image=basePath+"images/jfxt/dz_zb03.png";//��ɫͼ��
				pIcon.height=25; 
				pIcon.width=25; 
				
				var newMarker = new Marker(new Point(coordArray[0],coordArray[1]),pIcon); //ʵ����һ�����
				newMarker['_ID']=oldMarker['_ID'];//Ϊ��marker����Զ�������
				//���¶�Ӧ�б�����Ϣ(��γ������)
				var rowObject=$('#infoTable').children().eq(idx);//�������Ϊidx���ж���
				//alert(idx+","+rowObject.children().length);
				rowObject.children().eq(2).text(coordArray[0]);//�¾���
				rowObject.children().eq(3).text(coordArray[1]);//��γ��
				$('#id').val(rowObject.children().eq(5).text());//���浱ǰ���޸Ķ����Ψһ��ʶid
				
				var curMarkerIndex=idx;//��������
				
				//Ϊ�±������click�¼�������
				newMarker.addListener("click",function(){
					var colArray=rowObject.children();//���е�Ԫ��(��)����

					var msg="���ƣ�"+colArray.eq(4).text()+"<br>����:"+colArray.eq(2).text()+",γ��:"+colArray.eq(3).text()+"<br>��λ����:"+colArray.eq(1).text()+",����:"+colArray.eq(6).text();
					var link="�õ�λ�Ѿ��޸Ĺ���";//"<a href='javascript: drawNewPoint("+index+")'>���¶�λ</a>"//modify :�����±�
					msg+="<br>"+link
					newMarker.openInfoWindowHtml(msg);//��ʾ����ͷ��λ��Ϣ
					newMarker.flash();//��˸ ��������˸Ч������Ϊ�ظ���λ��ס��
					

				
				});
				
				markerListForRelocate[idx]=newMarker;//�½������滻�϶���,click�¼���Ҫ���°�
				_MapApp.addOverlay(newMarker);//��ӵ�ǰ����
				//���ñ��水ť���ܱ��汾�θ��ĵ����ݿ�
				//alert('׼������');
				updateCoordinate();
			
		});
	}

//��ʼ
$(function(){
	initMap();//��ʼ����ͼ
	addCameraMark();//��������ͷ
	
	bandEventForRow();//Ϊ�а�click�¼�
	
})
//Ϊ�а�click�¼�
function bandEventForRow(){
		////Ϊ�а�click�¼�
		$("#infoTable tr").unbind('click');//�����
		$("#infoTable tr").live('click',function(){
			$(this).siblings().removeClass('clickRow');//�Ƴ�������ʾ����
			$(this).addClass('clickRow');//ʹ���и�����ʾ
			
			var colArray=$(this).children();//��õ�ǰ�еĵ�Ԫ���������
			//alert(rowInfo);

			var curRowIndex=colArray.eq(0).text();//����
			var tm=colArray.eq(1).text();
			var longitude=colArray.eq(2).text();//coords[0];
			var latitude=colArray.eq(3).text();
			var dwmc=colArray.eq(4).text();
									
			var message="���ƣ�"+colArray.eq(4).text()+"<br>����:"+colArray.eq(2).text()+",γ��:"+colArray.eq(3).text()+"<br>��λ����:"+colArray.eq(1).text()+",����:"+colArray.eq(6).text();
			var link="<a href='javascript: drawNewPoint("+curRowIndex+")'>���¶�λ</a>"//modify :�����±�
			message+="<br>"+link;		
			//alert(dispName+","+longitude+","+latitude);//
			var pp=new Point(longitude,latitude);
			_MapApp.centerAndZoom(pp,  _MapApp.getZoomLevel());//����			
			_MapApp.openInfoWindow(pp,message);//������Ϣ��new Point(longitude,latitude)
			
			var oldMarker=markerListForRelocate[curRowIndex];//��õ�ǰMarker
			oldMarker.flash();//��˸
			

		})	

}
//�޸�����
function updateCoordinate(){
	//��ò���
	var id=$('#id').val();
	var longitudeNew=$('#longitudeNew').val();
	var latitudeNew=$('#latitudeNew').val();
	
	//alert(id+","+longitudeNew+","+latitudeNew);
	//�������ݿ�
	//markerListForRelocate.length=0;//�������
	var url="<%=contextPath%>/sptgl/modifyCoordinateById";
	var params={id:id,jd:longitudeNew,wd:latitudeNew};
	//����json��ʽ���ַ���
	$.getJSON(url,params,function(result){
		var msg=(result>0)?"��λ��λ���Ѿ�����":"����ʧ�ܣ����뿪������ϵ(88058977)";
		alert(msg);
	});				
}


//�����ã�
function locateByCoord(){
	var rowLength=$('#infoTable').children().length;
	alert(rowLength);
}
		
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
				<!-- ����ͷΨһ��ʶ -->
				<input type="hidden" id="id" name="id" value="">
				<fieldset style="display:none">
					<legend>����ͷ��λ��ʼ����</legend>
					����<input type="text" id="longitudeOld">
					γ��<input type="text" id="latitudeOld">
				</fieldset>
				<p>
				<fieldset style="display:none">
					<legend>����ͷ��λ��ǰ����</legend>
					����<input type="text" id="longitudeNew">
					γ��<input type="text" id="latitudeNew"><br>
					<input type="button" value="�޸�����" onclick="updateCoordinate()">
				</fieldset>
				<hr>
				<!-- �������ʼ -->
				<div style="height:460px;overflow-y: auto;">
					<div class="list"><!-- �б� start -->
						<table>
						<thead>
						<tr>
							<th>�к�</th>			
							<th  style='display:none'>����</th>
							<th>����</th>
							<th>γ��</th>
							<th>����</th>
						</tr>
						</thead>
						<tbody id="infoTable"></tbody>
						</table>
					</div><!-- �б� end -->
					
				</div>  
	    		<!-- ���������� -->
    
    		</div>
    		<!-- ��������end  --> 
    	</div>
    	<!-- div id="cc" end  -->  
    </div>
     <!-- data-options="region:'center'" end  -->
</body>      

</html>
