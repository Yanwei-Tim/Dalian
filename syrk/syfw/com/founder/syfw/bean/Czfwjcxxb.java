package com.founder.syfw.bean;

import java.io.Serializable;

import com.founder.framework.annotation.DBInfoAnnotation;
import com.founder.framework.annotation.FieldDesc;
import com.founder.framework.base.entity.BaseEntity;

@DBInfoAnnotation(tableName = "SYFW_CZFWJCXXB", pk = "id")
public class Czfwjcxxb extends BaseEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@FieldDesc("出租房屋检查ID")
	private String id;
	@FieldDesc("出租房屋ID")
	private String czfwid;
	@FieldDesc("检查情况_简要情况")
	private String jcqk_jyqk;
	@FieldDesc("检查单位_公安机关机构代码")
	private String jcdw_gajgjgdm;
	@FieldDesc("检查单位_公安机关名称")
	private String jcdw_gajgmc;
	@FieldDesc("检查人_姓名")
	private String jcr_xm;
	@FieldDesc("检查人_ID")
	private String jcr_id;
	@FieldDesc("检查日期")
	private String jcrq;
	@FieldDesc("备注")
	private String bz;
	@FieldDesc("采集时间")
	private String xt_cjsj;
	@FieldDesc("录入时间")
	private String xt_lrsj;
	@FieldDesc("录入人姓名")
	private String xt_lrrxm;
	@FieldDesc("录入人ID")
	private String xt_lrrid;
	@FieldDesc("录入人部门")
	private String xt_lrrbm;
	@FieldDesc("录入人部门ID")
	private String xt_lrrbmid;
	@FieldDesc("录入IP")
	private String xt_lrip;
	@FieldDesc("最后修改时间")
	private String xt_zhxgsj;
	@FieldDesc("最后修改人姓名")
	private String xt_zhxgrxm;
	@FieldDesc("最后修改人ID")
	private String xt_zhxgrid;
	@FieldDesc("最后修改人部门")
	private String xt_zhxgrbm;
	@FieldDesc("最后修改人部门ID")
	private String xt_zhxgrbmid;
	@FieldDesc("最后修改IP")
	private String xt_zhxgip;
	@FieldDesc("注销标志")
	private String xt_zxbz;
	@FieldDesc("注销原因")
	private String xt_zxyy;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCzfwid() {
		return czfwid;
	}
	public void setCzfwid(String czfwid) {
		this.czfwid = czfwid;
	}
	public String getJcqk_jyqk() {
		return jcqk_jyqk;
	}
	public void setJcqk_jyqk(String jcqk_jyqk) {
		this.jcqk_jyqk = jcqk_jyqk;
	}
	public String getJcdw_gajgjgdm() {
		return jcdw_gajgjgdm;
	}
	public void setJcdw_gajgjgdm(String jcdw_gajgjgdm) {
		this.jcdw_gajgjgdm = jcdw_gajgjgdm;
	}
	public String getJcdw_gajgmc() {
		return jcdw_gajgmc;
	}
	public void setJcdw_gajgmc(String jcdw_gajgmc) {
		this.jcdw_gajgmc = jcdw_gajgmc;
	}
	public String getJcr_xm() {
		return jcr_xm;
	}
	public void setJcr_xm(String jcr_xm) {
		this.jcr_xm = jcr_xm;
	}
	public String getJcr_id() {
		return jcr_id;
	}
	public void setJcr_id(String jcr_id) {
		this.jcr_id = jcr_id;
	}
	public String getJcrq() {
		return jcrq;
	}
	public void setJcrq(String jcrq) {
		this.jcrq = jcrq;
	}
	public String getBz() {
		return bz;
	}
	public void setBz(String bz) {
		this.bz = bz;
	}
	public String getXt_cjsj() {
		return xt_cjsj;
	}
	public void setXt_cjsj(String xt_cjsj) {
		this.xt_cjsj = xt_cjsj;
	}
	public String getXt_lrsj() {
		return xt_lrsj;
	}
	public void setXt_lrsj(String xt_lrsj) {
		this.xt_lrsj = xt_lrsj;
	}
	public String getXt_lrrxm() {
		return xt_lrrxm;
	}
	public void setXt_lrrxm(String xt_lrrxm) {
		this.xt_lrrxm = xt_lrrxm;
	}
	public String getXt_lrrid() {
		return xt_lrrid;
	}
	public void setXt_lrrid(String xt_lrrid) {
		this.xt_lrrid = xt_lrrid;
	}
	public String getXt_lrrbm() {
		return xt_lrrbm;
	}
	public void setXt_lrrbm(String xt_lrrbm) {
		this.xt_lrrbm = xt_lrrbm;
	}
	public String getXt_lrrbmid() {
		return xt_lrrbmid;
	}
	public void setXt_lrrbmid(String xt_lrrbmid) {
		this.xt_lrrbmid = xt_lrrbmid;
	}
	public String getXt_lrip() {
		return xt_lrip;
	}
	public void setXt_lrip(String xt_lrip) {
		this.xt_lrip = xt_lrip;
	}
	public String getXt_zhxgsj() {
		return xt_zhxgsj;
	}
	public void setXt_zhxgsj(String xt_zhxgsj) {
		this.xt_zhxgsj = xt_zhxgsj;
	}
	public String getXt_zhxgrxm() {
		return xt_zhxgrxm;
	}
	public void setXt_zhxgrxm(String xt_zhxgrxm) {
		this.xt_zhxgrxm = xt_zhxgrxm;
	}
	public String getXt_zhxgrid() {
		return xt_zhxgrid;
	}
	public void setXt_zhxgrid(String xt_zhxgrid) {
		this.xt_zhxgrid = xt_zhxgrid;
	}
	public String getXt_zhxgrbm() {
		return xt_zhxgrbm;
	}
	public void setXt_zhxgrbm(String xt_zhxgrbm) {
		this.xt_zhxgrbm = xt_zhxgrbm;
	}
	public String getXt_zhxgrbmid() {
		return xt_zhxgrbmid;
	}
	public void setXt_zhxgrbmid(String xt_zhxgrbmid) {
		this.xt_zhxgrbmid = xt_zhxgrbmid;
	}
	public String getXt_zhxgip() {
		return xt_zhxgip;
	}
	public void setXt_zhxgip(String xt_zhxgip) {
		this.xt_zhxgip = xt_zhxgip;
	}
	public String getXt_zxbz() {
		return xt_zxbz;
	}
	public void setXt_zxbz(String xt_zxbz) {
		this.xt_zxbz = xt_zxbz;
	}
	public String getXt_zxyy() {
		return xt_zxyy;
	}
	public void setXt_zxyy(String xt_zxyy) {
		this.xt_zxyy = xt_zxyy;
	}
	
	
	
	
}
