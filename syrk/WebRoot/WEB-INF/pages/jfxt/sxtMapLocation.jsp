<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.founder.framework.base.entity.SessionBean"%>
<%@ include file="/WEB-INF/pages/commonInclude.jsp"%>

<%
/*
    SessionBean userInfo = (SessionBean)session.getAttribute("userSession");
    String userOrgCode = "";
    String bjzbz = "";
    if(userInfo!=null){
        userOrgCode = userInfo.getUserOrgCode();
        bjzbz = userInfo.getBjzbz();//��ø��˺���������ı߽����괮
    }
 */  
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<!-- ���������js�汾 -->
<script type="text/javascript" src="<%=contextPath%>/js/jquery_1.5.min.js"></script>
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


</script>


<script type="text/javascript">

	var g_parentTabPageID=${param.tabPageID};//�����ڱ�ǩҳ����
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


	
	//������ͷ������
	var dataInputx;
	var dataInputy;
	function drawNewPoint(idx){
			//�ı��ͼģʽΪ����
			_MapApp.changeDragMode('drawPoint',null,null,function(result){
				//�����λ�ò���������Ϣ���Ա�Ϊ�޸���׼��
				var coordArray=result.split(',');

				var pIcon=new Icon();
				pIcon.image=basePath+"images/jfxt/dz_zb03.png";//��ɫͼ��
				pIcon.height=25; 
				pIcon.width=25;				
				var newMarker = new Marker(new Point(coordArray[0],coordArray[1]),pIcon); //ʵ����һ�����
				_MapApp.addOverlay(newMarker);//��ӵ�ǰ����
				if(!confirm('λ����ȷ��?')){
					_MapApp.removeOverlay(newMarker);//ɾ�����
					return;
				}
				//alert(coordArray[0]+","+coordArray[1]);
				//updateCoordinate();
				//������д�븸������
				$("#jdGA",window.opener.document).val(coordArray[0]) ;
				$("#wdGA",window.opener.document).val(coordArray[1]) ;
				//closeSelf();//�رյ�ǰ��ǩҳ
				window.close();
		});
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
//��ʼ
$(function(){

	//���¶��������Ĳ˵�����������Ҽ�Ϊ��ͼƽ��
	document.oncontextmenu =function(){
		_MapApp.changeDragMode("pan", null, null, null);
	}
	
	//alert(g_parentTabPageID);
	getBjzbzByOrgCode();//�����߽����괮
	//initMap();//��ʼ����ͼ
	
})


	
//ͨ����ͼ��λ����ͷ����
function getSxtLocationByMap(){
	//alert('��λ');
	drawNewPoint();

}	
window.onload=function(){
	window.moveTo(0,0);
	window.resizeTo(screen.availWidth,screen.availHeight);

}

</script>

</head>
  

<body class="easyui-layout">   
    <div data-options="region:'center'" style="padding:5px;background:#eee;">
	    <div id="cc" class="easyui-layout" data-options="fit:true">   
		 	<!-- ��ͼ����start  -->   
		    <div data-options="region:'center',title:'���ĵ�ͼ����',tools:'#tt' ">
		    	<div id="map" > </div>
		    </div>
		    <div id="tt">				
		    	<span style="background-color:yellow">����˵��:1.�������������ƶ���ͼ������ͷ�Ĵ�������Ȼ���������Ҳఴť�ڵ�ͼ�϶�λ��2.����Ҽ����ȡ����λ&nbsp;&nbsp;</span>
				<a href="#"   onclick="javascript:getSxtLocationByMap()">
					<img alt="��ʼ��λ" src="<%=contextPath %>/images/jfxt/dz_zb01.png" width="20" height="20" >
				</a>			
			</div>
		     
		    <!-- ��ͼ����end  -->   

    	</div>
    	<!-- div id="cc" end  -->  
    </div>
     <!-- data-options="region:'center'" end  -->
</body>      

</html>
