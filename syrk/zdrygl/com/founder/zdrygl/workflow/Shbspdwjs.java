package com.founder.zdrygl.workflow;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.JavaDelegate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.founder.framework.organization.assign.service.OrgAssignPublic;
import com.founder.framework.organization.assign.vo.OrgUserInfo;
import com.founder.framework.organization.department.bean.OrgOrganization;
import com.founder.framework.organization.department.service.OrgOrganizationService;
import com.founder.framework.organization.position.service.OrgPositionService;
import com.founder.workflow.service.inteface.JProcessDefinitionService;

/**
 * ****************************************************************************
 * @Package:      [com.founder.zdrygl.until.Userbmjs.java]  
 * @ClassName:    [Userbmjs]   
 * @Description:  [动态计算审批人]   
 * @Author:       [cong_rihong@founder.com.cn]  
 * @CreateDate:   [2015年8月11日 上午11:07:19]   
 * @UpdateUser:   [Administrator(如多次修改保留历史记录，增加修改记录)]   
 * @UpdateDate:   [2015年8月11日 上午11:07:19，(如多次修改保留历史记录，增加修改记录)]   
 * @UpdateRemark: [说明本次修改内容,(如多次修改保留历史记录，增加修改记录)]  
 * @Version:      [v1.0]
 */
@Component
public class Shbspdwjs implements JavaDelegate {
	@Resource(name = "orgOrganizationService")
	private OrgOrganizationService orgOrganizationService;
	@Resource
	private OrgPositionService orgPositionService;

	@Override
	public void execute(DelegateExecution execution) throws Exception {
		String zdrylx = (String) execution.getVariable("zdrylx");
		//如果是涉环保重点人员
		if("07".equals(zdrylx)){
			String sqrOrgCode = (String) execution.getVariable("sqrOrgCode");
			String sqrOrgLevel = (String) execution.getVariable("sqrOrgLevel");
			//String sqrOrgBiztype=(String) execution.getVariable("sqrOrgBiztype");
			String splevel=(String) execution.getVariable("splevel");
			OrgOrganization ssOrg =new OrgOrganization();
			//申请人部门
			ssOrg =orgOrganizationService.queryByOrgcode(sqrOrgCode);	
			String ssOrgCode =ssOrg.getOrgcode();//  得到申请人所属部门code		

			//一级审批
			if(splevel.equals("1")){
				//分县局环保大队和市局环保大队申请的，由大队长一级审批
				if("31".equals(sqrOrgLevel)||"30".equals(sqrOrgLevel)){
					String ddz=orgPositionService.queryByPosid("DDZ").getId().toString();
					execution.setVariable("level1spr", ssOrgCode+"_"+ddz);

				}else if("".equals(sqrOrgLevel)){//省厅环保大队申请的
					
				}
				
			}else if(splevel.equals("2")){//二级审批
				
				OrgOrganization upOrg=orgOrganizationService.queryParentOrgByOrgcode(sqrOrgCode);
				
				//分县局环保大队申请的
				if("31".equals(sqrOrgLevel)){	
					String fjz=orgPositionService.queryByPosid("FJZ").getId().toString();

					execution.setVariable("level2spr", upOrg.getOrgcode()+"_"+fjz);					
					
				}else if("30".equals(sqrOrgLevel)){//市局环保大队申请的 由支队长审批
					String zdz=orgPositionService.queryByPosid("ZDZ").getId().toString();
					execution.setVariable("level2spr", upOrg.getOrgcode()+"_"+zdz);					
				}else if("".equals(sqrOrgLevel)){//省厅环保大队申请的
					
				}
			}			
		}
		
	}
	

}
