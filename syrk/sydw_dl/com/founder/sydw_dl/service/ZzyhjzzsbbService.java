package com.founder.sydw_dl.service;

import com.founder.framework.annotation.MethodAnnotation;
import com.founder.framework.annotation.MethodAnnotation.logType;
import com.founder.framework.annotation.TypeAnnotation;
import com.founder.framework.base.entity.SessionBean;
import com.founder.sydw_dl.bean.Zzyhjzzsbb;

@TypeAnnotation("自助银行及自助设备")
public interface ZzyhjzzsbbService {
	
	
	public Zzyhjzzsbb queryZzyhjzzsbbByRyid(Zzyhjzzsbb entity);
	/**
	 * 新增<br>
	 * 
	 * @param entity
	 */
	@MethodAnnotation(value = "新增", type = logType.insert)
	public void saveZzyhjzzsbb(Zzyhjzzsbb entity, SessionBean sessionBean);
	/**
	 * 更新<br>
	 * 
	 * @param entity
	 */
	@MethodAnnotation(value = "更新", type = logType.update)

	public void updateZzyhjzzsbb(Zzyhjzzsbb entity, SessionBean sessionBean);
	
}
