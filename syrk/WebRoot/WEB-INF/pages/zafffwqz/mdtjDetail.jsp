<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/commonInclude.jsp"%>
<%
/******************************************************************************
 * @JSPName:      [mdtjDetail.jsp]   
 * @Description:  [矛盾详情页面]   
 * @Author:       [tian_chengwei@founder.com.cn]  
 * @CreateDate:   [2015-06-03]   
 * @UpdateUser:   [lk(如多次修改保留历史记录，增加修改记录)]   
 * @UpdateDate:   [2015-06-03(如多次修改保留历史记录，增加修改记录)]   
 * @UpdateRemark: [说明本次修改内容,(如多次修改保留历史记录，增加修改记录)]  
 * @Version:      [v1.0] 
 
 	@review      :wu.w@founder.com.cn
	@reviewDate  : 20150604
 */
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>矛盾详细信息</title>
		<script type="text/javascript" src="<%=contextPath%>/js/mdtj/mdtjDetail.js"></script>
	</head>
<body class="easyui-layout">
			<div data-options="region:'center', split:true" style="width:100%border-width: 0px;margin:0 0 0;" align="center" class="bodybg">
				<div data-options="region:'north', split:true" >
					<table height="60%" style="margin:0 auto;"><tr><td height="100%" valign="top" align="center">
						<div class="pop_conta">
							<div class="pop_contb">
								<div class="pop_contc">
									<form action="<%=basePath%>mdxxb/saveMdxxb" id="dataForm" name="dataForm" method="post">
										<table border="0" cellpadding="0" cellspacing="10" width="width:800px;" align="center">
											<tr class="dialogTr">
												<td width="20%" class="dialogTd" align="right">矛盾来源：</td>
												<td width="30%" class="dialogTd">
													<input type="text" name="mdlydm" id="mdlydm" class="easyui-combobox" style="width:200px"  value="${entity.mdlydm}"  
														data-options="required:false,
														url: contextPath + '/common/dict/D_FWQZ_MDLY.js',
														valueField:'id',
														textField:'text',
														tipPosition:'left',
														selectOnNavigation:false,method:'get'"/></td>
												<td width="20%" class="dialogTd" align="right">矛盾管辖归属：</td>
												<td width="30%" class="dialogTd">
													<input type="text" name="mdgxgsdm" id="mdgxgsdm" class="easyui-combobox" style="width:200px"   value="${entity.mdgxgsdm}"
															data-options="required:false,
															url: contextPath + '/common/dict/D_FWQZ_GXGS.js',
															valueField:'id',
															textField:'text',
															tipPosition:'left',
															selectOnNavigation:false,method:'get'"/></td>
											</tr>
											<tr class="dialogTr">
											 	<td width="20%" class="dialogTd" align="right">矛盾类型：</td>
												<td width="30%" class="dialogTd">
														<input type="text" name="mdlx" id="mdlx" class="easyui-validatebox" style="width:200px" value="${entity.mdlx}" 
																data-options="required:false,validType:'maxLength[50]'" /></td>
												<td width="20%" class="dialogTd" align="right">矛盾发生时间：</td>
												<td width="30%" class="dialogTd">
														<input  type='text' id='mdfssj' name='mdfssj' class="easyui-validatebox" style="width:200px;"maxlength="19" value="${entity.mdfssj}" 
																onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"
																data-options="validType:['date[\'yyyy-MM-dd\']'],invalidMessage:'请输入正确的时间！ ',required:true,tipPosition:'left'" /></td>
											</tr>
											<tr class="dialogTr">
												<td width="20%" class="dialogTd" align="right">矛盾发生地点：</td>
												<td width="80%" class="dialogTd" colspan="3">
														<input type="text" name="mdfsddmc" id ="mdfsddmc" class="easyui-validatebox" value="${entity.mdfsddmc}" maxlength="100" 
																 data-options="required:false,validType:'maxLength[100]'" style="width:555px"/></td>
											</tr>
											<tr class="dialogTr">
												<td width="20%" class="dialogTd" align="right">矛盾原因：</td>
												<td width="80%" class="dialogTd" colspan="3">
															<input type="text" name="mdyy" id ="mdyy" class="easyui-validatebox" value="${entity.mdyy}" maxlength="200" 
																data-options="required:false,validType:'maxLength[200]'" style="width:555px" /></td>	
											</tr>
											<tr class="dialogTr">
											 	<td width="20%" class="dialogTd" align="right">矛盾现状：</td>
												<td width="30%" class="dialogTd">
															<input type="text" name="mdxz" id ="mdxz" class="easyui-validatebox" value="${entity.mdxz}" style="width:200px" maxlength="200"
																data-options="required:false,validType:'maxLength[200]'" /></td>
											</tr>
											<tr class="dialogTr">
												<td width="20%" class="dialogTd" align="right">管辖单位名称：</td>
															<input class="easyui-validatebox-delay" type="hidden" name="gxdwid" id="jwry_gzdwid" value="${entity.gxdwid}" />
												<td width="80%" class="dialogTd" colspan="3">
															<input type="text" readonly="readonly" name="dwmc" id="dwmc" class="easyui-combobox" maxlength="100" style="width: 555px;" value="${entity.gxdwmc}" 
																 data-options="mode:'remote',
																 method:'post',panelHeight: 22,
																 valueField:'id',textField:'text',
																 selectOnNavigation:false,required:false" />
															 <input type="hidden" name="gxdwmc" id="gxdwmc" value="${entity.gxdwmc }"/></td>
										 	</tr>
											<tr class="dialogTr">
												<td width="20%" class="dialogTd" align="right">是否移交：</td>
												<td width="30%" class="dialogTd">
															<input type="text" name="sfyjdm" id ="sfyjdm"  class="easyui-combobox" value="${entity.sfyjdm}" 
																		 data-options="required:false,
																		 url: contextPath + '/common/dict/D_BZ_SF.js',
																		 valueField:'id',textField:'text',
																		 tipPosition:'left',selectOnNavigation:false,method:'get'" style="width:200px" /></td>
												<td width="20%" class="dialogTd" align="right">转交人：</td>
												<td width="30%" class="dialogTd">
															<input type="text" name="yjr" id="yjr" class="easyui-validatebox" data-options="required:false,validType:'maxLength[50]'" style="width:200px"  maxlength="50"
															value="${entity.yjr}"/></td>
										</tr>
										<tr class="dialogTr">
												<td width="20%" class="dialogTd" align="right">接受人：</td>
												<td width="30%" class="dialogTd">
															<input type="text"  name="jsr" id="jsr" class="easyui-validatebox" data-options="required:false,validType:'maxLength[50]'" style="width:200px"  maxlength="50" value="${entity.jsr}" /></td>
										</tr>
										<tr class="dialogTr">
											<td width="20%" class="dialogTd" align="right">备注：</td>
										 	<td width="80%" class="dialogTd" colspan="3" >
										 			<textarea id="bz" name="bz" class="easyui-validatebox" style="width: 555px; height:48px;"
																data-options="validType:['maxLength[1000]'],
																invalidMessage:'备注不能超过1000个汉字，请重新输入！',
																tipPosition:'left'" readonly="readonly">${entity.bz}</textarea></td>
										</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			</td>
		</tr>
   </table>
 </div> 
		<div data-options="region:'center', split:true" style="width:700px; margin:0 0 0;border-width: 0px; height:250px;">
			<div class="easyui-tabs" style="height: auto;" id="xxk" style="width:700px;">  
				<div title="当事人信息"  >
					<div id="dg1" data-options="region:'center',split:true,title:'当事人信息列表',border:true" style="height:250px;width:700px;">
						<table id="dg0" class="easyui-datagrid" 
							data-options="url: contextPath +'/dsrxxzb/queryList?mdjfxxid=${entity.id}',
					 		singleSelect:false,
					 		fitColumns:false,
					 		toolbar:'#datagridToolbar',
					 		border:false,
					 		sortName:'xt_zhxgsj',
					 		sortOrder:'asc',
					 		idField:'id',
					 		pageSize:getAutoPageSize(),
					 		selectOnCheck:true,
					 		checkOnSelect:true,
					 		pageList:[getAutoPageSize(),getAutoPageSize() * 2]">
					 		<thead>
					 			<tr>
						        	<th data-options="checkbox:true,align:'center',halign:'center'"></th>
						        	 <th data-options="field:'zjhm',width:120,align:'left',sortable:true,halign:'center'">证件号码</th>
						        	 <th data-options="field:'xm',width:65,align:'left',sortable:true,halign:'center'">姓名</th>
						        	 <th data-options="field:'xbdm',width:55,align:'left',sortable:true,halign:'center',formatter:dictFormatter,dictName:contextPath+'/common/dict/D_BZ_XB.js'">性别</th>
						        	 <th data-options="field:'dz_jzdzxz',width:150,align:'left',sortable:true,halign:'center'">居住地址</th>
						        	 <th data-options="field:'gzdw',width:100,align:'left',sortable:true,halign:'center'">工作单位</th>
						        	 <th data-options="field:'lxdh',width:70,align:'left',sortable:true,halign:'center'">联系电话</th>
						            <th data-options="field:'process',align:'center',halign:'center',formatter:processFormater0">操作</th>
						        </tr>
					        </thead>
				        </table>
			        </div>
		        </div>	
	<div title="调解信息" >
    		 <div id="dg2" data-options="region:'center',split:true,title:'调解信息列表',border:true" style="height:250px;width:700px;">
				<table  id="tb1" class="easyui-datagrid" 
					data-options="url: contextPath +'/tjxxzb/queryList?mdjfxxid=${entity.id}',
			 		toolbar:'#datagridToolbar1',
			 		fitColumns:false,
			 		singleSelect:false,selectOnCheck:true,
			 		checkOnSelect:true,border:false,
			 		sortName:'xt_zhxgsj',sortOrder:'asc',
			 		idField:'id',pageSize:getAutoPageSize(),
			 		pageList:[getAutoPageSize(),getAutoPageSize() * 2]">
		 		<thead>
		 				<tr>
				        	<th data-options="checkbox:true,align:'center',halign:'center'"></th>
				        	 <th data-options="field:'tjdwmc',width:150,align:'left',sortable:true,halign:'center'">调解单位名称</th>
				        	 <th data-options="field:'tjdd',width:100,align:'left',sortable:true,halign:'center'">调解地点</th>
				        	 <th data-options="field:'tjsj',width:100,align:'left',sortable:true,halign:'center'">调解时间</th>
				        	 <th data-options="field:'tjclxx',width:100,align:'left',sortable:true,halign:'center'">调解处理信息</th>
				        	 <th data-options="field:'tjr',width:100,align:'left',sortable:true,halign:'center'">调解人</th>
				            <th data-options="field:'process',align:'center',halign:'center',formatter:processFormater1">操作</th>
				        </tr>
    			</thead>
   			</table>
		</div>
	</div>
	<div title="跟踪进展情况" >
		<div id="dg3" data-options="region:'center',split:true,title:'跟踪进展情况列表',border:true" style="height:250px;width:700px;">
			<table  id="tb2" class="easyui-datagrid" 
					data-options="url: contextPath +'/gzjzqkzb/queryList?mdjfxxid=${entity.id}',
			 		toolbar:'#datagridToolbar2',
			 		fitColumns:false,
			 		singleSelect:false,selectOnCheck:true,
			 		checkOnSelect:true,border:false,
			 		sortName:'xt_zhxgsj',sortOrder:'asc',
			 		idField:'id',pageSize:getAutoPageSize(),
			 		pageList:[getAutoPageSize(),getAutoPageSize() * 2]">
			    <thead>
			        <tr>
			        	<th data-options="checkbox:true,align:'center',halign:'center'"></th>
			        	 <th data-options="field:'gzjzr',width:150,align:'left',sortable:true,halign:'center'">跟踪进展人</th>
			        	 <th data-options="field:'gzjzsj',width:150,align:'left',sortable:true,halign:'center'">跟踪进展时间</th>
			        	 <th data-options="field:'jzqkms',width:300,align:'left',sortable:true,halign:'center'">进展情况描述</th>
			            <th data-options="field:'process',align:'center',halign:'center',formatter:processFormater2">操作</th>
			        </tr>
			    </thead>
			</table>
		</div>
	</div>
</div>
</div>
</div>
</body>
</html>
