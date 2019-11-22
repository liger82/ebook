package kr.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.book.domain.BookDto;
import kr.member.domain.MemberDto;
import kr.purchase.domain.BasketDto;
import kr.purchase.domain.RecordsDto;

public class PurchaseDao {
	private static PurchaseDao instance = new PurchaseDao();
	
	public static PurchaseDao getInstance() {
		return instance;
	}
	private PurchaseDao(){}
	
	//context.xml���� ���������� �о�鿩 Ŀ�ؼ� Ǯ�κ��� Ŀ�ؼ��� �Ҵ����
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		/*datasource�� db�� �����ϱ� ���� ǥ�� �������̽�. Ư�� DBCP(DataBase Connection Pool)�� �̿��ϱ�����ǥ�ع��*/
		DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/xe");
		return ds.getConnection();
	}
		
	//�ڿ�����
	private void executeClose(ResultSet rs, PreparedStatement pstmt,Connection conn) {
		if(rs!=null) try{rs.close();} catch(SQLException e) {}
		if(pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
		if(conn!=null) try{conn.close();} catch(SQLException e) {}
	}
	
	/* ��ٱ��� */
	
	//��ٱ��Ͽ� ��ǰ �߰�
	public void putInBasket(int book_num, String memberId) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = getConnection();
			sql = "INSERT INTO basket (basket_num,book_num, memberId) VALUES(basket_seq.nextval,?,?)";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			pstmt.setString(2, memberId);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt, conn);
		}
	}
	
	//�ߺ�üũ true�� �ߺ��Ȱ� / �춧
	public boolean checkSellDuplicate(int book_num, String memberId) throws Exception{
		boolean duplicated = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = null;
		
		try {
			conn = getConnection();
			
			sql = "SELECT * FROM recordspurchases where book_num=? and memberId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			pstmt.setString(2, memberId);
						
			rs = pstmt.executeQuery();
			if(rs.next()) {
				duplicated = true;
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return duplicated;
	}
	
	//�ߺ�üũ true�� �ߺ��Ȱ� / ��ٱ��� ������
	public boolean checkBasketDuplicate(int book_num, String memberId) throws Exception{
		boolean duplicated = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		String sql = null;
		
		try {
			conn = getConnection();
			conn.setAutoCommit(false);

			sql = "SELECT * FROM basket where book_num=? and memberId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			pstmt.setString(2, memberId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				duplicated = true;
			}
			
			sql = "SELECT * FROM recordspurchases where book_num=? and memberId=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, book_num);
			pstmt2.setString(2, memberId);
						
			rs2 = pstmt2.executeQuery();
			if(rs2.next()) {
				duplicated = true;
			}
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			executeClose(rs2, pstmt2, null);
			executeClose(rs, pstmt, conn);
		}
		
		
		return duplicated;
	}
	
	
	public BasketDto getBookInCart(int basket_num) throws Exception{
		BasketDto basket = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			conn=getConnection();
			sql ="SELECT * FROM basket WHERE basket_num=?";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, basket_num);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				basket = new BasketDto();
				basket.setBasket_num(rs.getInt("basket_num"));
				basket.setBook_num(rs.getInt("book_num"));
				basket.setMemberId(rs.getString("memberId"));
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		
		return basket;
	}
	
	//user ��ٱ��Ͽ� ��� ��ǰ ����
	public int getBookCountInBasket(String memberId) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = getConnection();
			sql = "SELECT COUNT(book_num) FROM basket WHERE memberId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	
		
	//���� ��ٱ��� ����Ʈ
	public List<BasketDto> getBookListInBasket(int start,int end, String memberId) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<BasketDto> list = null;
		BasketDto basket=null;
		
		try {
			conn = getConnection();
			//��ü�� ����
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM basket join book on basket.BOOK_NUM=book.BOOK_NUM order by basket_num desc) a WHERE memberId=?) WHERE rnum >=? and rnum <= ?";
				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			rs= pstmt.executeQuery();
			list = new ArrayList<BasketDto>();
			while(rs.next()) {
				basket= new BasketDto();

				basket.setBasket_num(rs.getInt("basket_num"));
				basket.setMemberId(rs.getString("memberId"));
				basket.setBook_num(rs.getInt("book_num"));
				basket.setTitle(rs.getString("title"));
				basket.setAuthor(rs.getString("author"));
				basket.setPrice(rs.getInt("price"));
				basket.setAudioLink(rs.getString("audioLink"));
				basket.setImgFilename(rs.getString("imgFilename"));
				
				list.add(basket);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//��ٱ��Ͽ��� ��ǰ ����
	public void deleteBookInBasket(String memberId,int book_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = getConnection();
			sql = "DELETE FROM basket WHERE memberId=? and book_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, book_num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt, conn);
		}
	}
	
	//���ų����� �Ÿ� ��� ���(å �ȱ�) - �ѹ��� å �ϳ��� ���
	public void buyBook(RecordsDto record) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = getConnection();
			sql = "INSERT INTO recordspurchases (records_num,book_num, memberId,total_price,purchasedate,bookmark) VALUES(records_seq.nextval,?,?,?,sysdate,1)";
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, record.getBook_num());
			pstmt.setString(2, record.getMemberId());
			pstmt.setInt(3,record.getTotal_price());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt, conn);
		}
	}

	//���ڸ� ��ü���� �ϳ��� �ް� ������ ������ true/false �༭ nextval, currval�ֱ�
	public void buyBook(int book_num, String memberId,int total_price,boolean one) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = getConnection();
			if(one) {
				sql = "INSERT INTO recordsPurchases (records_num,book_num, memberId,total_price,purchaseDate,bookmark) VALUES(records_seq.nextval,?,?,?,sysdate,1)";
				
			}else {
				sql = "INSERT INTO recordsPurchases (records_num,book_num, memberId,total_price,purchaseDate,bookmark) VALUES(records_seq.currval,?,?,?,sysdate,1)";
				
			}
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			pstmt.setString(2, memberId);
			pstmt.setInt(3,total_price);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt, conn);
		}
	}
	
	//���ų��� ����
	public int getRecordCount(String memberId, boolean audio) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			conn = getConnection();
			
			if(memberId==null) {
				sql = "SELECT count(distinct records_num) FROM recordspurchases";
				pstmt= conn.prepareStatement(sql);
				
			}else {
				//������� ����
				if(audio) {
					sql = "select count(records_num) from recordspurchases r join book b on r.book_num=b.book_num where audiolink is not null and memberId=?";
					
				}else {//�Ϲ� ����
					sql = "select count(records_num) from recordspurchases r join book b on r.book_num=b.book_num where audiolink is null and memberId=?";
					
				}
				pstmt= conn.prepareStatement(sql);
				pstmt.setString(1, memberId);
			}
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return count;
	}

	public List<RecordsDto> getTotalRecordsList(int start, int end) throws Exception{
		List<RecordsDto> list = null;
		RecordsDto records = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt=0;
		
		try {
			conn = getConnection();
			
			//records_num �ߺ����� �ʰ�
			sql="select * from (select a.*, rownum rnum from (select distinct records_num,memberId,total_price,purchaseDate from recordspurchases order by purchasedate desc) a ) WHERE rnum >=? and rnum <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<RecordsDto>();
			while(rs.next()) {
				records = new RecordsDto();
				
				records.setRecords_num(rs.getInt("records_num"));
				records.setMemberId(rs.getString("memberId"));
				records.setTotal_price(rs.getInt("total_price"));
				records.setPurchaseDate(rs.getDate("purchaseDate"));
				
				list.add(records);
			}
			
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//���ų��� ���(��ü)
	public List<RecordsDto> getRecordsList(int start, int end, String memberId,boolean audio) throws Exception{
		List<RecordsDto> list = null;
		RecordsDto records = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt=0;
		
		try {
			conn = getConnection();
			if(memberId==null) {
				sql="select * from (select a.*, rownum rnum from (select r.*,title,author,price,imgfilename,audiolink from recordspurchases r join book b on r.book_num=b.book_num order by purchasedate desc) a) where rnum>=? and rnum <=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
			}else {
				//���ų��� ���� ���(�� ����, audioBook)
				if(audio) {//audiobook ����
					sql ="select * from (select a.*, rownum rnum from (select r.*,title,author,price,imgfilename,audiolink from (select * from recordspurchases where memberId=?) r join book b on r.book_num=b.book_num WHERE audiolink is not null order by purchasedate desc) a) where rnum>=? and rnum <=?";
				}else {//���ų��� ���� ���(�� ����, �Ϲ� ebook)
					sql ="select * from (select a.*, rownum rnum from (select r.*,title,author,price,imgfilename,audiolink from (select * from recordspurchases where memberId=?) r join book b on r.book_num=b.book_num WHERE audiolink is null order by purchasedate desc) a) where rnum>=? and rnum <=?";
				}
					
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, memberId);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<RecordsDto>();
			while(rs.next()) {
				records = new RecordsDto();
				
				records.setRecords_num(rs.getInt("records_num"));
				records.setBook_num(rs.getInt("book_num"));
				records.setMemberId(rs.getString("memberId"));
				records.setTotal_price(rs.getInt("total_price"));
				records.setPurchaseDate(rs.getDate("purchaseDate"));
				records.setTitle(rs.getString("title"));
				records.setAuthor(rs.getString("author"));
				records.setPrice(rs.getInt("price"));
				records.setImgFilename(rs.getString("imgfilename"));
				records.setAudioLink(rs.getString("audioLink"));
				
				list.add(records);
			}
			
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//���ų��� ���(��ü)
	public List<RecordsDto> getRecordsDetail(int records_num) throws Exception{
		List<RecordsDto> list = null;
		RecordsDto records = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt=0;

		try {
			conn = getConnection();
			sql="select r.*,title,author,price,imgfilename,audiolink from (select * from recordspurchases where records_num=?) r join book b on r.book_num=b.book_num order by b.BOOK_NUM";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, records_num);
			rs = pstmt.executeQuery();

			list = new ArrayList<RecordsDto>();
			while(rs.next()) {
				records = new RecordsDto();

				records.setRecords_num(rs.getInt("records_num"));
				records.setBook_num(rs.getInt("book_num"));
				records.setMemberId(rs.getString("memberId"));
				records.setTotal_price(rs.getInt("total_price"));
				records.setPurchaseDate(rs.getDate("purchaseDate"));
				records.setTitle(rs.getString("title"));
				records.setAuthor(rs.getString("author"));
				records.setPrice(rs.getInt("price"));
				records.setImgFilename(rs.getString("imgfilename"));
				records.setAudioLink(rs.getString("audioLink"));

				list.add(records);
			}


		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	
}
