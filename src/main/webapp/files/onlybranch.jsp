<%@page import="admin.*"%>
<%@page import="java.sql.*" %>

<%@page import="com.google.gson.Gson"%>

<%@page import="java.io.InputStreamReader"%>
<%@page import="java.util.*"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.text.Format"%>
<%@ page contentType="application/json" %>


<%
 
  // Date s= sdf.parse(d);
BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
 
String json="",line=null;
while((line  = br.readLine())!=null){
json+=line;	
}

br.close();

GsonBuilder builder = new GsonBuilder(); 
builder.setPrettyPrinting(); 
Gson gson = builder.create(); 
cb cmp=new cb();
//json="{name:'Rabecca fatima',address:'88/141-1 chamanganj kanpur',dob:'2001-01-02T00:00:00.000Z',time:'morning',mobile:'1234567890',email:'arib@gmail.com',city:2,country:1,dob:'2022-03-26T00:00:00.000Z',way:['yes','yes','yes'],cars:[2]}";
cmp =gson.fromJson(json,cb.class);
          
JsonObject jobj= new JsonObject();


Connection con = null;

try{		    Class.forName("com.mysql.jdbc.Driver");
con =DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=utf8","root","root");
System.out.println("connected");
// Connection con = ConnectionProvider.getCon();
Statement st =con.createStatement();

String sql2="insert into branch values('"+cmp.getBranchid()+"','"+cmp.getBname()+"',(select cid from course where cid='"+cmp.getCourseid()+"'))" ;
/* response.sendRedirect("adminHome.jsp"); */
int n =st.executeUpdate(sql2);

	
	if(n>0 ){
		
		jobj.addProperty("status","success");
		jobj.addProperty("message"," Branch: "+cmp.getBname()+" saved.");
	}else{
		jobj.addProperty("status","failed");
		jobj.addProperty("message"," Branch: "+cmp.getBname()+" not saved.");
	}
	}
catch(Exception ex){
	
  jobj.addProperty("status","error");
  jobj.addProperty("message",ex.getMessage());
  

}
finally {
	
	
	try{if(con!=null){
	 con.close();	
	}
	}
	catch ( Exception ex)
	{
		out.println(ex.getMessage());
	}
	
	

	out.println(jobj.toString());

	
	if(json!=null) 
	{//out.println("json ");
		


		}
	else{
		out.println("json empty");
	}
	
	
	
	
	
	
	
	
	
	
}






%>
