package com.founder.xjpt.easymap.sevlet;


import com.founder.xjpt.easymap.bean.xlcbean;
import com.founder.xjpt.easymap.conn.DBConnection;

import java.io.IOException;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class XlcSevlet extends HttpServlet
{
  private static final long serialVersionUID = 1L;

  public void destroy()
  {
    super.destroy();
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    doPost(request, response);
  }


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=gbk");
		request.setCharacterEncoding("gbk");
	  String ssfj=request.getParameter("gxsxj");
	  String sspcs=request.getParameter("gxpcs");
       SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
       String tjz="";
       
       
       if(sspcs ==""){
    	 //  ssfj = ssfj.substring(0, ssfj.length() - 6);
  
    	   if("210200000000".equals(ssfj))
    	   {   tjz="1=1"; 
    		  }else{
  tjz=" SecurityBureauID='"+ssfj+"' ";
    	   }
   
       }else{
    	   tjz=" PoliceStationID= '"+sspcs+"' ";
       }
       
	   String times  =df.format(new Date());;
	 
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet rs = null;
		try {
    
			//String sql = "select * from xlc_xxxx where GPSCODE is not null and  "+tjz+" and realtime>(to_date( '"+times+"' , 'YYYY-MM-DD hh24:mi-ss')-interval '10' MINUTE )order by realtime desc";
			String sql = "select * from xlc_xxxx where GPSCODE is not null and  "+tjz+" order by realtime desc";
				conn = DBConnection.getZlConnection();
			stmt = conn.createStatement();
			System.out.println("++++++++++"+sql);
			rs = stmt.executeQuery(sql.toString());
			Map<String,xlcbean> map = new HashMap<String,xlcbean>(); 
		  	while (rs.next()) {
        		xlcbean xb = new xlcbean();
		  		xb.setZbx(rs.getString("x"));
		  		xb.setZby(rs.getString("y"));
		  		xb.setCallno(rs.getString("callno"));
		  		xb.setCarno(rs.getString("carno"));
		  		xb.setGpsid(rs.getString("gpsid"));
		  		xb.setBm(rs.getString("zzjgmc"));
		  		xb.setType(rs.getString("CarType"));
		        map.put(rs.getString("gpsid"), xb);

			}
			rs.close();
			stmt.close();
			conn.close();
			
		 Iterator<String> iter=map.keySet().iterator();
	
			StringBuffer sb = new StringBuffer();
			sb.append("<menus>");
	   while(iter.hasNext()){
		String key=(String)iter.next();

	  	sb.append("<menu gpsid='"+key+"'  x='"
				+ map.get(key).getZbx() + "' y='" +map.get(key).getZby()
		        + "'  bm='" +map.get(key).getBm()
		        + "'  carno='" +map.get(key).getCarno()
		        + "'  type='" +map.get(key).getType()
		        + "'  callno='" +map.get(key).getCallno()+"'/>");		
	    }
			
			
			sb.append("</menus>");
			System.out.println(sb);
			response.setContentType("text/xml;charset=UTF-8");
			response.getWriter().write(sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	

		
		
	}


	
	

}
