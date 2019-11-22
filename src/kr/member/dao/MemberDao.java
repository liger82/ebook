package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.member.domain.MemberDto;
import kr.member.domain.Ptype;

public class MemberDao {
   
   private static MemberDao instance = 
         new MemberDao();

   public static MemberDao getInstance() {
      return instance;
   }

   private MemberDao() {}   

   //context.xml���� ���������� �о�鿩
   //Ŀ�ؼ�Ǯ�κ��� Ŀ�ؼ��� �Ҵ� ����
   private Connection getConnection()
         throws Exception{
      Context initCtx = new InitialContext();
      DataSource ds = 
            (DataSource)initCtx.lookup(
                  "java:comp/env/jdbc/xe");
      return ds.getConnection();
   }

   //�ڿ�����
   private void executeClose(ResultSet rs,
         PreparedStatement pstmt,
         Connection conn) {
      if(rs!=null)try {rs.close();}catch(SQLException e) {}
      if(pstmt!=null)try {pstmt.close();}catch(SQLException e) {}
      if(conn!=null)try {conn.close();}catch(SQLException e) {}
   }
   
   //ȸ������
   public void insertMember(MemberDto member) throws Exception{
      Connection conn = null;
      PreparedStatement pstmt = null;
      PreparedStatement pstmt2 = null;
      String sql = null;
      int cnt = 0;
      
      try {
         conn = getConnection();
         //���� Ŀ�� ����
         conn.setAutoCommit(false);
         sql = "INSERT INTO member1 (memberId,pw,lv) VALUES (?,?,1)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, member.getMemberId());
         pstmt.setString(2, member.getPw());
         pstmt.executeUpdate();
         
         //ȸ�� ��
         sql = "INSERT INTO member2 (memberId,name, sex,email,phone,mtype, regDate) VALUES(?,?,?,?,?,'0',sysdate)";
         pstmt2 = conn.prepareStatement(sql);
         pstmt2.setString(++cnt, member.getMemberId());
         pstmt2.setString(++cnt, member.getName());
         pstmt2.setString(++cnt, member.getSex());
         pstmt2.setString(++cnt, member.getEmail());
         pstmt2.setString(++cnt, member.getPhone());
         pstmt2.executeUpdate();
         
         //��� ����
         conn.commit();         
      }catch(Exception e) {
         //���� �߻�
         conn.rollback();
         throw new Exception(e);
      }finally {
    	 //executeClose(null, pstmt2, null);
         executeClose(null, pstmt, conn);
      }   
   }
   //���̵� �ߺ� üũ
   public MemberDto checkId(String memberId) throws Exception{
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      MemberDto member = null;
      String sql = null;
      
      try {
         conn = getConnection();
         sql = "SELECT * FROM member1 WHERE memberId=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,memberId);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            member = new MemberDto();
         }
      }catch(Exception e) {
         throw new Exception(e);
      }finally {
         executeClose(rs, pstmt, conn);
      }
      return member;
   }
   public List<MemberDto> getMemberList() throws Exception{
	   List<MemberDto> list = null;
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   MemberDto member = null;
	   String sql = null;
	   try {
		   conn = getConnection();
		   sql = "SELECT a.memberId,a.lv,"
				   + "b.name,b.sex, b.phone,b.email,b.mtype,"
				   + "b.regDate"
				   + " FROM member1 a JOIN member2 b " 
				   + "on a.memberId = b.memberId";
		   pstmt = conn.prepareStatement(sql);
		   rs = pstmt.executeQuery();

		   list = new ArrayList<MemberDto>();
		   while(rs.next()) {
			   member = new MemberDto();
			   member.setMemberId(rs.getString("memberId"));
			   member.setLv(rs.getInt("lv"));
			   member.setName(rs.getString("name"));
			   member.setSex(rs.getString("sex"));
			   member.setPhone(rs.getString("phone"));
			   member.setEmail(rs.getString("email"));
			   member.setMtype(rs.getString("mtype"));
			   member.setRegDate(rs.getDate("regDate"));
			   list.add(member);
		   }

	   }catch(Exception e) {
		   throw new Exception(e);
	   }finally {
		   executeClose(rs, pstmt, conn);
	   }

	   return list;
   }
   //ȸ��������
   public MemberDto getMember(String memberId) throws Exception{
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      MemberDto member = null;
      String sql = null;
      
      try {
         conn = getConnection();
         sql = "SELECT a.memberId,a.pw,a.lv,"
            + "b.name,b.sex, b.phone,b.email,b.mtype,"
            + "b.regDate"
            + " FROM member1 a JOIN member2 b " 
             + "on a.memberId = b.memberId where a.memberId=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, memberId);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            member = new MemberDto();
            member.setMemberId(rs.getString("memberId"));
            member.setPw(rs.getString("pw"));
            member.setLv(rs.getInt("lv"));
            member.setName(rs.getString("name"));
            member.setSex(rs.getString("sex"));
            member.setPhone(rs.getString("phone"));
            member.setEmail(rs.getString("email"));
            member.setMtype(rs.getString("mtype"));
            member.setRegDate(rs.getDate("regDate"));
         }
         
      }catch(Exception e) {
         throw new Exception(e);
      }finally {
         executeClose(rs, pstmt, conn);
      }
      
      return member;
   }
   //�����ȣ����
   public void updatePassword(MemberDto member) throws Exception{
      Connection conn = null;
      PreparedStatement pstmt = null;
      String sql = null;
      
      try {
         conn = getConnection();
         sql = "UPDATE member1 SET pw=? WHERE memberId=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, member.getPw());
         pstmt.setString(2, member.getMemberId());
         
         pstmt.executeUpdate();
         
      }catch(Exception e) {
         throw new Exception(e);
      }finally {
         executeClose(null, pstmt, conn);
      }
   }
   //ȸ����������
   public void updateMember(MemberDto member) throws Exception{
      Connection conn = null;
      PreparedStatement pstmt = null;
      String sql = null;
      int cnt = 0;
      
      try {
         conn = getConnection();
         sql = "UPDATE member2 SET name=?, phone=?,email=? WHERE memberId=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(++cnt, member.getName());
         pstmt.setString(++cnt, member.getPhone());
         pstmt.setString(++cnt, member.getEmail());
         pstmt.setString(++cnt, member.getMemberId());
         
         pstmt.executeUpdate();
         
      }catch(Exception e) {
         throw new Exception(e);
      }finally {
         executeClose(null, pstmt, conn);
      }
   }
   //ȸ��Ż��,ȸ������ ����
   public void deleteMember(String memberId)
                             throws Exception{
      Connection conn = null;
      PreparedStatement pstmt = null;
      PreparedStatement pstmt2 = null;
      String sql = null;
      
      try {
         conn = getConnection();
         //���� Ŀ�� ����
         conn.setAutoCommit(false);
         sql = "DELETE FROM member2 WHERE memberId=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, memberId);
         pstmt.executeUpdate();
         
         sql = "UPDATE member1 SET lv=0 WHERE memberId=?";
         pstmt2 = conn.prepareStatement(sql);
         pstmt2.setString(1, memberId);
         pstmt2.executeUpdate();
         
         //���� ����
         conn.commit();
      }catch(Exception e) {
         //���� �߻�
         conn.rollback();
         throw new Exception(e);
      }finally {
         executeClose(null, pstmt, conn);
      }
      
   }
   
   //�����ڷ� �°�
   public void promoteLv(String memberId) throws Exception{
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   String sql = null;
	   
	   try {
		   conn = getConnection();
		   sql = "UPDATE member1 SET lv=2 WHERE memberId=?";
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, memberId);

		   pstmt.executeUpdate();

	   }catch(Exception e) {
		   throw new Exception(e);
	   }finally {
		   executeClose(null, pstmt, conn);
	   }
   }
   
   //�Ϲ�ȸ������ ����
   public void demoteLv(String memberId) throws Exception{
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   String sql = null;
	   
	   try {
		   conn = getConnection();
		   sql = "UPDATE member1 SET lv=1 WHERE memberId=?";
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, memberId);

		   pstmt.executeUpdate();

	   }catch(Exception e) {
		   throw new Exception(e);
	   }finally {
		   executeClose(null, pstmt, conn);
	   }
   }
   
   //�������� �˻� ��� �ݿ��ϱ� : mtype �ٲٱ�
   public void modifyType(String memberId,String mtype) throws Exception{
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   String sql = null;
	   
	   try {
		   conn = getConnection();
		   sql = "UPDATE member2 SET mtype=? WHERE memberId=?";
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, mtype);
		   pstmt.setString(2, memberId);

		   pstmt.executeUpdate();

	   }catch(Exception e) {
		   throw new Exception(e);
	   }finally {
		   executeClose(null, pstmt, conn);
	   }
   }
   
   //�ϳ��� mtype�� ���� �̹���,����
   public Ptype getPtype(String mtype) throws Exception{
	   Ptype type = null;
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   String sql = null;
	   
	   try {
		   conn = getConnection();
		   sql = "SELECT mtype,image,explanation FROM ptype WHERE mtype=?";
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, mtype);
		   
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   type = new Ptype();
			   type.setMtype(rs.getString("mtype"));
			   type.setImage(rs.getString("image"));
			   type.setExplanation(rs.getString("explanation"));
		   }
	   }catch(Exception e) {
		   throw new Exception(e);
	   }finally {
		   executeClose(rs, pstmt, conn);
	   }
	   return type;
   }
   
   //�ϳ��� mtype�� ���� �̹���,����, ��õ ī�װ�
   public List<Ptype> getCategory(String mtype) throws Exception{
	   List<Ptype> list = null;
	   Ptype type = null;
	   Connection conn = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   String sql = null;
	   
	   try {
		   conn = getConnection();
		   sql = "SELECT mtype,highLv,lowLv FROM ptype WHERE mtype=?";
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, mtype);
		   
		   rs = pstmt.executeQuery();
		   list = new ArrayList<Ptype>();
		   while(rs.next()) {
			   type = new Ptype();
			   type.setMtype(rs.getString("mtype"));
			   type.setHighLv(rs.getString("highLv"));
			   type.setLowLv(rs.getString("lowLv"));
			   
			   list.add(type);
		   }
	   }catch(Exception e) {
		   throw new Exception(e);
	   }finally {
		   executeClose(rs, pstmt, conn);
	   }
	   return list;
   }
   
}