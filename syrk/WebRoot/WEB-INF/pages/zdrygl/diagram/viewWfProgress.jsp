    <%@ page language="java" contentType="text/html; charset=gbk"  
        pageEncoding="gbk"%>  
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
      
<%@include file="/WEB-INF/pages/commonInclude.jsp"%>
    <html>  
    <head>  
        <title>�鿴����</title>  
    </head>  
    <body>  
        <div >  
          	<input type="hidden" id="assignee" name="assignee" value="${assignee }">
            <img src="<c:url value='/diagram/drawPic' />/${procDefId}/${procIstid}" >  
            <!-- ��ִ�еĽڵ�ӿ� -->  
           <%--  <div style="position:absolute; border:2px solid red;left:${wfLeaveImag.x+10 }px;top:${wfLeaveImag.y+10 }px;width:${wfLeaveImag.width }px;height:${wfLeaveImag.height }px;"></div>   --%>
        </div>  
      		<hr>
      		��������Ա����:<br>
      		
      	<div id="info">
      		<table border="1">
      			<tr>
      				
      				<td>����</td>
      				<td>��ԱID</td>
      				<td>��λ</td>
      				<td>����</td>
      			</tr>
      			<tr>
      				<td>����</td>
      				<td>2313734834889</td>
      				<td>����</td>
      				<td>��Ͻ������</td>
      			</tr>
      		</table>
      	</div>
    </body> 
    <script type="text/javascript">
    window.onload = function(){
    	var assignee=$("#assignee").val();
	    $.ajax({
			async:false,
			type:"GET",
			url:"<%= basePath%>orgUser/query/" + assignee,
			dataType:"json",
			success:function(data){
				if (data && data.length>0) {
					$("#info").val(data)
				}else{
					alert("δ�ҵ������ˣ��ò��Ż��λ��δ������Ա");
				}				
			}
		});
    }
    </script> 
    </html>
	