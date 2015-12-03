package com.founder.zdrygl.base.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import com.founder.framework.annotation.MethodAnnotation;
import com.founder.framework.annotation.MethodAnnotation.logType;
import com.founder.framework.annotation.ParaAnnotation;
import com.founder.framework.annotation.TypeAnnotation;
import com.founder.framework.base.entity.SessionBean;
import com.founder.framework.base.service.BaseService;
import com.founder.framework.config.SystemConfig;
import com.founder.framework.utils.UUID;
import com.founder.syrkgl.bean.RyRyjbxxb;
import com.founder.syrkgl.service.RyRyjbxxbService;
import com.founder.zdrygl.base.dao.ZdryZdryZbDao;
import com.founder.zdrygl.base.model.ZdryGzb;
import com.founder.zdrygl.base.model.ZdryZb;
import com.founder.zdrygl.base.model.Zdrycg;
import com.founder.zdrygl.core.inteface.ZdryService;
import com.founder.zdrygl.core.model.Zdry;
import com.founder.zdrygl.core.utils.ZdryConstant;
/**
 * ****************************************************************************
 * @Package:      [com.founder.zdrygl.base.service.ZdryzbService.java]  
 * @ClassName:    [ZdryzbService]   
 * @Description:  [重点人员总表业务服务]   
 * @Author:       [wei.wen@founder.com.cn]  
 * @CreateDate:   [2015年9月16日 下午5:23:22]   
 * @UpdateUser:   [wei.wen@founder.com.cn(如多次修改保留历史记录，增加修改记录)]   
 * @UpdateDate:   [2015年9月16日 下午5:23:22，(如多次修改保留历史记录，增加修改记录)]   
 * @UpdateRemark: [说明本次修改内容,(如多次修改保留历史记录，增加修改记录)]  
 * @Version:      [v1.0]
 */
@TypeAnnotation("重点人员管理")
public class ZdryzbService implements ZdryService {
	
	/**
	 * 重点人员总表对象，需要存日志表，必须是public或者指定获取方法getZdry
	 */
	@ParaAnnotation("getZdry")
	private ZdryZb zdryzb;
	
	/**
	 * 撤管对象
	 */
	private Zdrycg zdrycg;
	
	@Autowired
	private ZdryZdryZbDao zdryZdryZbDao;	
	
	@Autowired
	private ZdryConstant zdryConstant;
	
	@Resource(name = "ryRyjbxxbService")
	private RyRyjbxxbService ryRyjbxxbService;
 
	@MethodAnnotation(value = "列管", type = logType.insert)
	@Override
	public void lg(SessionBean sessionBean) {
		zdryzb.setId(UUID.create());
		zdryzb.setGlzt(ZdryConstant.LGSQ);
		zdryzb.setGlbm(sessionBean.getUserOrgCode());//管理部门
		BaseService.setSaveProperties(zdryzb, sessionBean);		
		zdryZdryZbDao.insert(zdryzb);
	}

	@Override
	public void lgSuccess(SessionBean sessionBean) {
		zdryzb.setGlzt(ZdryConstant.YLG);
		updateZdry(sessionBean,zdryzb);
	}

	@Override
	public void lgFail(SessionBean sessionBean) {
		deleteZdry(sessionBean,zdryzb);
	}

	@MethodAnnotation(value = "撤管", type = logType.update)
	@Override
	public void cg(SessionBean sessionBean) {
		ZdryZb entity = new ZdryZb();
		entity.setId(zdrycg.getZdryid_old());
		entity.setGlzt(ZdryConstant.CGSQ);
		updateZdry(sessionBean,entity);				
		if(!isDelete()){
			this.lg(sessionBean);			
		}
	}

	@Override
	public void cgSuccess(SessionBean sessionBean) {
		ZdryZb entity = new ZdryZb();
		entity.setId(zdrycg.getZdryid_old());
		entity.setGlzt(ZdryConstant.YCG);
		deleteZdry(sessionBean,entity);
		if(!isDelete()){
			zdryzb.setGlzt(ZdryConstant.YLG);
			updateZdry(sessionBean,zdryzb);
		}
	}

	@Override
	public void cgFail(SessionBean sessionBean) {
		ZdryZb entity = new ZdryZb();
		entity.setId(zdrycg.getZdryid_old());
		entity.setGlzt(ZdryConstant.YLG);
		entity.setXt_zxbz("0");//设定数据为未注销状态
		updateZdry(sessionBean,entity);
		if(!isDelete()){
			deleteZdry(sessionBean,zdryzb);
		}
	}

	@MethodAnnotation(value = "转类", type = logType.update)
	@Override	
	public void zl(SessionBean sessionBean) {		
		//查询原有信息，发送消息的时候需要
		ZdryZb old = (ZdryZb) zdryZdryZbDao.queryById(zdryzb.getId());
		old.setGlzt(ZdryConstant.ZLSQ);
		old.setZdrylb(zdryzb.getZdrylb());		
		updateZdry(sessionBean,old);				
	}

	@Override
	public void zlSuccess(SessionBean sessionBean) {
		zdryzb.setGlzt(ZdryConstant.YLG);
		zdryzb.setXt_zxbz("0");
		updateZdry(sessionBean,zdryzb);
	}

	@Override
	public void zlFail(SessionBean sessionBean) {
		zdryzb.setGlzt(ZdryConstant.YLG);
		zdryzb.setXt_zxbz("0");
		updateZdry(sessionBean,zdryzb);
	}

	@MethodAnnotation(value = "转递", type = logType.update)
	@Override
	public void zd(SessionBean sessionBean) {
		ZdryZb entity = new ZdryZb();
		entity.setId(zdryzb.getId());
		entity.setGlzt(ZdryConstant.ZDSQ);
		entity.setGlbm(zdryzb.getGlbm());	
		entity.setJzd_dzid(zdryzb.getJzd_dzid());
		entity.setJzd_dzxz(zdryzb.getJzd_dzxz());
		entity.setJzd_mlpdm(zdryzb.getJzd_mlpdm());
		entity.setJzd_mlpxz(zdryzb.getJzd_mlpxz());
		entity.setJzd_xzqhdm(zdryzb.getJzd_xzqhdm());
		entity.setJzd_zbx(zdryzb.getJzd_zbx());
		entity.setJzd_zby(zdryzb.getJzd_zby());
		updateZdry(sessionBean,entity);
	}

	@Override
	public void zdSuccess(SessionBean sessionBean) {
		if(sessionBean.getExtendMap().get("xglbm")!=null){
			zdryzb.setGlbm(sessionBean.getExtendMap().get("xglbm"));
			zdryzb.setGxbm(sessionBean.getExtendMap().get("xglbm"));
		}
		if(sessionBean.getExtendMap().get("ryid")!=null){
			zdryzb.setRyid(sessionBean.getExtendMap().get("ryid"));
		}
		if(sessionBean.getExtendMap().get("sszrqdm")!=null){
			zdryzb.setGxzrqdm(sessionBean.getExtendMap().get("sszrqdm"));
		}

		String xgxpcsdm = sessionBean.getExtendMap().remove("xgxpcsdm");
		if(xgxpcsdm != null){
			zdryzb.setGxpcsdm(xgxpcsdm);
		}
		//先把管辖部门和管理部门设置相同，如果是双列管，再设置为户籍地管理部门
		ZdryGzb zdryGzb=zdryZdryZbDao.queryByZdrylx(zdryzb.getZdrygllxdm(),SystemConfig.getString("zdryQY"));
		if(zdryGzb!=null && "1".equals(zdryGzb.getSfslg())){//双列管，查询户籍地管理部门
			RyRyjbxxb ryjbxxb=ryRyjbxxbService.queryById(zdryzb.getRyid());//人员基本信息	
			if(ryjbxxb!=null && ryjbxxb.getHjd_mlpdm()!= null){
//				String zdry_hjd_zrqdm = dzService.queryMldzDx(ryjbxxb.getHjd_mlpdm()).getZrqdm();
				String gxbm=zdryZdryZbDao.queryHjdZrqdm(ryjbxxb.getHjd_mlpdm());
				if(gxbm!=null && gxbm.length()>0)
					zdryzb.setGxbm(gxbm);
			}
		}
		removeTempAttributes(sessionBean);
		zdryzb.setGlzt(ZdryConstant.YLG);
		
		//deleteZdry(sessionBean,zdryzb);
		zdryZdryZbDao.update(zdryzb);
	}

	@Override
	public void zdFail(SessionBean sessionBean) {
		String yjzd_dzid = sessionBean.getExtendMap().get("yjzd_dzid");
		String yjzd_dzxz = sessionBean.getExtendMap().get("yjzd_dzxz");
		String yjzd_mlpdm = sessionBean.getExtendMap().get("yjzd_mlpdm");
		String yjzd_mlpxz = sessionBean.getExtendMap().get("yjzd_mlpxz");
		String yjzd_xzqhdm = sessionBean.getExtendMap().get("yjzd_xzqhdm");
		String yjzd_zbx = sessionBean.getExtendMap().get("yjzd_zbx");
		String yjzd_zby = sessionBean.getExtendMap().get("yjzd_zby");
		String yglbm = sessionBean.getExtendMap().get("yglbm");

		String ygxpcsdm = sessionBean.getExtendMap().remove("ygxpcsdm");
		if(yjzd_dzid != null){
			zdryzb.setJzd_dzid(yjzd_dzid);
		}
		if(yjzd_dzxz != null){
			zdryzb.setJzd_dzxz(yjzd_dzxz);
		}
		if(yjzd_mlpdm != null){
			zdryzb.setJzd_mlpdm(yjzd_mlpdm);
		}
		if(yjzd_mlpxz != null){
			zdryzb.setJzd_mlpxz(yjzd_mlpxz);
		}
		if(yjzd_xzqhdm != null){
			zdryzb.setJzd_xzqhdm(yjzd_xzqhdm);
		}
		if(yjzd_zbx != null){
			zdryzb.setJzd_zbx(yjzd_zbx);
		}
		if(yjzd_zby != null){
			zdryzb.setJzd_zby(yjzd_zby);
		}
		if(yglbm != null){
			zdryzb.setGlbm(yglbm);
		}
		if(ygxpcsdm != null){
			zdryzb.setGxpcsdm(ygxpcsdm);
		}
		if(sessionBean.getExtendMap().get("ryid")!=null){
			zdryzb.setRyid(sessionBean.getExtendMap().get("ryid"));
		}
		removeTempAttributes(sessionBean);
		zdryzb.setGlzt(ZdryConstant.YLG);
		zdryzb.setXt_zxbz("0");
		updateZdry(sessionBean,zdryzb);
	}
	/**
	 * 
	 * @Title: removeTempAttributes
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 * @param @param sessionBean    设定文件
	 * @return void    返回类型
	 * @throws
	 */
	private void removeTempAttributes(SessionBean sessionBean) {
		sessionBean.getExtendMap().remove("yjzd_dzid");
		sessionBean.getExtendMap().remove("yjzd_dzxz");
		sessionBean.getExtendMap().remove("yjzd_mlpdm");
		sessionBean.getExtendMap().remove("yjzd_mlpxz");
		sessionBean.getExtendMap().remove("yjzd_xzqhdm");
		sessionBean.getExtendMap().remove("yjzd_zbx");
		sessionBean.getExtendMap().remove("yjzd_zby");
		sessionBean.getExtendMap().remove("yglbm");
		sessionBean.getExtendMap().remove("ryid");
		//zdsuccess
		sessionBean.getExtendMap().remove("xglbm");
		sessionBean.getExtendMap().remove("sszrqdm");
		sessionBean.getExtendMap().remove("sspcsdm");
		sessionBean.getExtendMap().remove("xgxpcsdm");
		sessionBean.getExtendMap().remove("ygxpcsdm");
	}

	/**
	 * 
	 * @Title: update
	 * @Description: TODO (修改)
	 * @param @param sessionBean    设定文件
	 * @return void    返回类型
	 * @throw
	 */
	@MethodAnnotation(value = "修改", type = logType.update)
	@Override
	public final void update(SessionBean sessionBean) {
		//总表还不确定要修改	
	}

	private void updateZdry(SessionBean sessionBean,ZdryZb entity){
		BaseService.setUpdateProperties(entity, sessionBean);
		zdryZdryZbDao.update(entity);
	}
	private void deleteZdry(SessionBean sessionBean,ZdryZb entity){
		BaseService.setCrossoutProperties(entity, sessionBean);
		zdryZdryZbDao.delete(entity);
	}
	
	/**
	 * 
	 * @Title: isDelete
	 * @Description: (判断是注销还是撤管)
	 * @param @return    设定文件
	 * @return boolean    返回类型
	 * @throws
	 */
	private boolean isDelete(){
		if(zdrycg != null && !StringUtils.isEmpty(zdrycg.getZdrygllxdm())){
			return false;
		}
		return true;
	}

	@Override
	public void setZdry(Zdry entity) {
		if(entity!=null){
			if(entity.getClass().getName().equals(Zdrycg.class.getName())){
				this.zdrycg = (Zdrycg) entity;
				this.zdryzb = new ZdryZb();
				BeanUtils.copyProperties(zdrycg, zdryzb);
			}else{
				this.zdryzb = (ZdryZb) entity;
			}
		}
	}

	@Override
	public Zdry getZdry() {
		return zdryzb;
	}

	@Override
	public String getZdryId() {
		return getZdry().getId();
	}

	@Override
	@Deprecated  
	public void setStartProcessInstance(String processKey, String applyUserId, Map<String, Object> variables) {
		
	}

	/**
	 * 
	 * @Title: queryZdryAllInfo
	 * @Description: (查询重点人员总表和子表)
	 * @param @param zdryid
	 * @return void    返回类型
	 * @throw
	 */
//	@Override
//	public Zdry[] queryZdryAllInfo(String zdryid) {
//		Zdry[] zdry = new Zdry[1];
//		zdry[0] = zdryZdryZbDao.queryById(zdryid);
//		return zdry;
//	}

	@Override
	public Map<String, String> getZdryXmAndZdrylxName() {
		Map<String, String> map = new HashMap<String,String>();
		map.put("zdryName", zdryzb.getXm());
		map.put("zdrylxName", zdryConstant.getValueOfZdryDict(zdryzb.getZdrygllxdm()));
		return map;
	}
}
