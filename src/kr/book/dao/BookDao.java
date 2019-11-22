package kr.book.dao;

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
import kr.book.domain.BookReply;
import kr.util.StringUtil;

public class BookDao {
	private static BookDao instance = new BookDao();
	
	public static BookDao getInstance() {
		return instance;
	}
	
	private BookDao() {}
	
	//context.xml에서 설정정보를 읽어들여 커넥션 풀로부터 커넥션을 할당받음
	private Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();
		/*datasource는 db에 접근하기 위한 표준 인터페이스. 특히 DBCP(DataBase Connection Pool)를 이용하기위한표준방식*/
		DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/xe");
		return ds.getConnection();
	}
	
	//자원정리
	private void executeClose(ResultSet rs, PreparedStatement pstmt,Connection conn) {
		if(rs!=null) try{rs.close();} catch(SQLException e) {}
		if(pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
		if(conn!=null) try{conn.close();} catch(SQLException e) {}
	}
	
	//ebook 추가
	public void insertBook(BookDto book) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		
		try {
			conn = getConnection();
			//평가 점수는 처음 생성시에 0임.
			sql = "INSERT INTO book (highLv,lowLv, book_num,title,author,price, audioLink, imgFilename, contentFilename, seriesCode, introduction,pubDate, regDate) "
					+ "VALUES (?,?,book_seq.nextval,?, ?, ?, 0, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(++cnt, book.getHighLv());
			pstmt.setString(++cnt, book.getLowLv());
			pstmt.setString(++cnt, book.getTitle());
			pstmt.setString(++cnt, book.getAuthor());
			pstmt.setInt(++cnt, book.getPrice());
			pstmt.setString(++cnt, book.getAudioLink());
			pstmt.setString(++cnt, book.getImgFilename());
			pstmt.setString(++cnt, book.getContentFilename());
			pstmt.setString(++cnt, book.getSeriesCode());
			pstmt.setString(++cnt, book.getIntroduction());
			pstmt.setDate(++cnt, book.getPubDate());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt, conn);
		}
	}
	
	public int getBookCount() throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = getConnection();
			sql = "SELECT COUNT(*) FROM book";
			pstmt = conn.prepareStatement(sql);
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
	
	//ebook 개수
	public int getBookCount(
			String keyfield,String keyword) 
	                      throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = getConnection();
			if(keyword == null || "".equals(keyword)) {
				//전체글 갯수
				sql = "SELECT COUNT(*) FROM book";
				pstmt = conn.prepareStatement(sql);
			}else {
				//검색글 갯수
				sql = "SELECT COUNT(*) FROM book WHERE " + keyfield + " like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
			}
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
	//ebook 개수
	public int getBookCount(String keyfield,String keyword,String highLv,String lowLv) 
					throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;

		try {
			conn = getConnection();
			//대분류 > 소분류 리스트 (검색 아님)
			if(highLv !=null && lowLv!=null) {
				//범주별 글 갯수
				sql = "SELECT COUNT(*) FROM book WHERE highLv=? and lowLv=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, highLv);
				pstmt.setString(2, lowLv);
				
			}else if(keyword == null || "".equals(keyword)) {
				//전체글 갯수
				sql = "SELECT COUNT(*) FROM book";
				pstmt = conn.prepareStatement(sql);
			}else {
				//검색글 갯수(범주별 검색 기능아니고 전체에서 검색임)
				sql = "SELECT COUNT(*) FROM book WHERE " + keyfield + " like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
			}
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
	
	//신간 ebook 개수
	public int getNewBookCount(String highLv) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;

		try {
			conn = getConnection();
			sql = "SELECT COUNT(*) FROM book where MONTHS_BETWEEN(sysdate,pubdate) <=6 and highLv=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, highLv);
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

	//고평가 ebook 개수
	public int getHighRatingBookCount(int crit) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;

		try {
			conn = getConnection();
			sql = "SELECT count(*) FROM (SELECT nvl(rating,0) rating FROM book b left join (SELECT book_num, round(avg(rating),1) rating FROM book_reply group by book_num) r on b.book_num = r.book_num) a WHERE a.rating >= ? order by a.rating desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, crit);
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
	//ebook 목록(전체,검색)
	public List<BookDto> getBookList(int start, int end, String keyfield,String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookDto> list = null;
		String sql = null;
		
		try {
		conn = getConnection();
		if(keyword == null || "".equals(keyword)) {
			//전체글 보기
			sql = "select * from (select a.*, rownum rnum from "
				+ "(select * from book b left join "
				+ "(select book_num, count(*) re_cnt from "
				+ "book_reply group by book_num)r "
				+ "on b.book_num = r.book_num order by b.book_num desc)a) "
				+ "where rnum >= ? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
		}else {
			//검색글 보기
			sql = "select * from (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM book b left join "
					+ "(SELECT book_num, count(*) re_cnt FROM book_reply group by book_num) r "
					+ "on b.book_num = r.book_num WHERE "+keyfield+" like ? order by b.book_num desc) a) "
					+ "WHERE rnum >=? and rnum <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
		}
		rs = pstmt.executeQuery();
		
		list = new ArrayList<BookDto>();
		while(rs.next()) {
			BookDto book = new BookDto();
			book.setHighLv(rs.getString("highLv"));
			book.setLowLv(rs.getString("lowLv"));
			book.setBook_num(rs.getInt("book_num"));
			book.setTitle(rs.getString("title"));
			book.setAuthor(rs.getString("author"));
			book.setPrice(rs.getInt("price"));
			book.setAudioLink(rs.getString("audioLink"));
			book.setImgFilename(rs.getString("imgFilename"));
			book.setContentFilename(rs.getString("contentFilename"));
			book.setSeriesCode(rs.getString("seriesCode"));
			book.setIntroduction(rs.getString("introduction"));
			book.setPubDate(rs.getDate("pubDate"));
			book.setRegDate(rs.getDate("regDate"));
			
			list.add(book);
		}
		
		
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//ebook 목록(전체목록, 검색어별 목록, 범주별 목록 )
	public List<BookDto> getBookList(int start, int end, String keyfield,String keyword,String highLv, String lowLv) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookDto> list = null;
		String sql = null;

		try {
			conn = getConnection();
			//대분류 > 소분류 리스트 (검색 아님)
			if(highLv !=null && lowLv!=null) {
				sql = "select * from (select a.*, rownum rnum from "
						+ "(select * from (SELECT * FROM book WHERE highLv = ? and lowLv = ?) b left join "
						+ "(select book_num, count(*) re_cnt from "
						+ "book_reply group by book_num)r "
						+ "on b.book_num = r.book_num order by b.book_num desc)a) "
						+ "where rnum >= ? and rnum <= ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, highLv);
				pstmt.setString(2, lowLv);
				
				pstmt.setInt(3, start);
				pstmt.setInt(4, end);

			}else if(keyword == null || "".equals(keyword)) {
				//전체글 보기
				sql = "select * from (select a.*, rownum rnum from "
						+ "(select * from book b left join "
						+ "(select book_num, count(*) re_cnt from "
						+ "book_reply group by book_num)r "
						+ "on b.book_num = r.book_num order by b.book_num desc)a) "
						+ "where rnum >= ? and rnum <= ?";

				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else {
				//검색글 보기(전체에서 검색)
				sql = "select * from (SELECT a.*, rownum rnum FROM "
						+ "(SELECT * FROM book b left join "
						+ "(SELECT book_num, count(*) re_cnt FROM book_reply group by book_num) r "
						+ "on b.book_num = r.book_num WHERE "+keyfield+" like ? order by b.book_num desc) a) "
						+ "WHERE rnum >=? and rnum <= ?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, "%"+keyword+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();

			list = new ArrayList<BookDto>();
			while(rs.next()) {
				BookDto book = new BookDto();
				book.setHighLv(rs.getString("highLv"));
				book.setLowLv(rs.getString("lowLv"));
				book.setBook_num(rs.getInt("book_num"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setPrice(rs.getInt("price"));
				book.setAudioLink(rs.getString("audioLink"));
				book.setImgFilename(rs.getString("imgFilename"));
				book.setContentFilename(rs.getString("contentFilename"));
				book.setSeriesCode(rs.getString("seriesCode"));
				book.setIntroduction(rs.getString("introduction"));
				book.setPubDate(rs.getDate("pubDate"));
				book.setRegDate(rs.getDate("regDate"));

				list.add(book);
			}

			
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				executeClose(rs, pstmt, conn);
			}
			
			return list;
		}


	//ebook 한개 상세
	public BookDto getBook(int book_num) throws Exception{
		BookDto book =null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			conn = getConnection();
			
			sql = "select highLv,lowLv,book.book_num,title, author, price, audiolink,imgfilename,contentfilename,seriescode,nvl(re_cnt,0) re_cnt, nvl(rating,0) rating,pubdate,regdate,introduction from book left join (SELECT book_num, count(*) re_cnt, round(avg(rating),1) rating FROM book_reply group by book_num) a on book.book_num=a.book_num where book.book_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				book = new BookDto();
				
				book.setHighLv(rs.getString("highLv"));
				book.setLowLv(rs.getString("lowLv"));
				book.setBook_num(rs.getInt("book_num"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setPrice(rs.getInt("price"));
				book.setAudioLink(rs.getString("audioLink"));
				book.setImgFilename(rs.getString("imgFilename"));
				book.setContentFilename(rs.getString("contentFilename"));
				book.setSeriesCode(rs.getString("seriesCode"));
				book.setRe_cnt(rs.getInt("re_cnt"));
				book.setRating(rs.getFloat("rating"));
				book.setIntroduction(rs.getString("introduction"));
				book.setPubDate(rs.getDate("pubDate"));
				book.setRegDate(rs.getDate("regDate"));
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return book;
	}
	
	//ebook 목록(신간)
	public List<BookDto> getNewBookList(int start, int end, String highLv) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookDto> list = null;
		String sql = null;
		
		try {
			conn = getConnection();
			sql = "select * from (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM (SELECT * FROM book WHERE highLv=?) b left join "
					+ "(SELECT book_num, count(*) re_cnt "
					+ "FROM book_reply group by book_num) r "
					+ "on b.book_num = r.book_num "
					+ "where MONTHS_BETWEEN(sysdate,pubdate) <=6 "
					+ "order by b.book_num desc) a) WHERE rnum >=? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, highLv);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<BookDto>();
			while(rs.next()) {
				BookDto book = new BookDto();
				book.setHighLv(rs.getString("highLv"));
				book.setLowLv(rs.getString("lowLv"));
				book.setBook_num(rs.getInt("book_num"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setPrice(rs.getInt("price"));
				book.setAudioLink(rs.getString("audioLink"));
				book.setImgFilename(rs.getString("imgFilename"));
				book.setContentFilename(rs.getString("contentFilename"));
				book.setSeriesCode(rs.getString("seriesCode"));
				book.setIntroduction(rs.getString("introduction"));
				book.setPubDate(rs.getDate("pubDate"));
				book.setRegDate(rs.getDate("regDate"));
				
				list.add(book);
			}
		
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//ebook get rating - 이북 하나의 평가 점수를 평균하여 점수를 반환(평가 없으면 0 반환)
	public float getBookRating(int book_num) throws Exception{
		float rating=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try{
			conn= getConnection();
			sql = "SELECT round(AVG(rating),1) FROM book_reply WHERE book_num=? GROUP BY book_num order by book_num";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rating = rs.getFloat(1);
			}
		
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return rating;
	}
	
	//ebook 목록(best rating)
	//대분류별 목록이 필요할 수도 있다.
	public List<BookDto> getBestRatingList(int start, int end,int crit) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookDto> list = null;
		String sql = null;
		
		try {
			conn = getConnection();
			sql = "select * from (select a.*,rownum rnum from (SELECT * FROM (SELECT highlv,lowlv,b.book_num,title, author, price, audiolink,imgfilename,contentfilename,seriescode,introduction,pubdate, re_cnt, nvl(rating,0) rating FROM book b left join (SELECT book_num, count(*) re_cnt, round(avg(rating),1) rating FROM book_reply group by book_num) r on b.book_num = r.book_num) WHERE rating >= ? order by rating desc) a) WHERE rnum >= ? and rnum <=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, crit);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<BookDto>();
			while(rs.next()) {
				BookDto book = new BookDto();
				book.setHighLv(rs.getString("highLv"));
				book.setLowLv(rs.getString("lowLv"));
				book.setBook_num(rs.getInt("book_num"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setPrice(rs.getInt("price"));
				book.setAudioLink(rs.getString("audioLink"));
				book.setImgFilename(rs.getString("imgFilename"));
				book.setContentFilename(rs.getString("contentFilename"));
				book.setSeriesCode(rs.getString("seriesCode"));
				book.setIntroduction(rs.getString("introduction"));
				book.setPubDate(rs.getDate("pubDate"));
				book.setRe_cnt(rs.getInt("re_cnt"));
				book.setRating(rs.getFloat("rating"));
				
				list.add(book);
			}
		
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}

	//시리즈 목록
	public List<BookDto> getSeriesList(String seriesCode) throws Exception{
		List<BookDto> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = getConnection();
			sql = "select * from (SELECT a.*, rownum rnum FROM (SELECT b.book_num,title, author, price, imgfilename,contentfilename,seriescode,re_cnt, nvl(rating,0) rating FROM book b left join (SELECT book_num, count(*) re_cnt, round(avg(rating),1) rating FROM book_reply group by book_num) r on b.book_num = r.book_num)a WHERE seriescode=? order by a.book_num desc)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seriesCode);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<BookDto>();
			while(rs.next()) {
				BookDto book = new BookDto();
				book.setBook_num(rs.getInt("book_num"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setPrice(rs.getInt("price"));
				book.setImgFilename(rs.getString("imgFilename"));
				book.setContentFilename(rs.getString("contentFilename"));
				book.setSeriesCode(rs.getString("seriesCode"));
				book.setRe_cnt(rs.getInt("re_cnt"));
				book.setRating(rs.getFloat("rating"));
				
				list.add(book);
			}
		
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//오디오북 개수
	public int getAudioBookCount() throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt = 0;
		
		try {
			conn = getConnection();
			sql = "SELECT count(book_num) FROM book WHERE audiolink is not null";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return cnt;
	}
	
	//오디오북 리스트
	public List<BookDto> getAudioBookList(int start, int end) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookDto> list = null;
		String sql = null;

		try {
			conn = getConnection();
			sql = "select * from (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM (select * from book where audiolink is not null) b left join "
					+ "(SELECT book_num, count(*) re_cnt "
					+ "FROM book_reply group by book_num) r "
					+ "on b.book_num = r.book_num "
					+ "order by b.book_num desc) a) WHERE rnum >=? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			list = new ArrayList<BookDto>();
			while(rs.next()) {
				BookDto book = new BookDto();
				
				book.setHighLv(rs.getString("highLv"));
				book.setLowLv(rs.getString("lowLv"));
				book.setBook_num(rs.getInt("book_num"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setPrice(rs.getInt("price"));
				book.setAudioLink(rs.getString("audioLink"));
				book.setImgFilename(rs.getString("imgFilename"));
				book.setContentFilename(rs.getString("contentFilename"));
				book.setSeriesCode(rs.getString("seriesCode"));
				book.setIntroduction(rs.getString("introduction"));
				book.setPubDate(rs.getDate("pubDate"));
				book.setRegDate(rs.getDate("regDate"));

				list.add(book);
			}

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//추천 책 카테고리 내 책 개수
	public int getRecBookCount(String mtype) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		String sql = null;
		try {
			conn = getConnection();
			sql = "select count(book_num) from book where lowlv in (select lowLv from ptype where mtype=?)";
			
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, mtype);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return cnt;
	}
	//추천책 목록 (rating이 높은 순으로 정렬)
	public List<BookDto> getRecBookList(int start, int end,String mtype) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BookDto> list = null;
		String sql = null;

		try {
			conn = getConnection();
			sql = "select * from (SELECT a.*, rownum rnum FROM (SELECT highlv,lowlv,b.book_num,title, author, price, imgfilename, nvl(rating,0) rating FROM (select * from book where lowlv in (select lowLv from ptype where mtype=?)) b left join (SELECT book_num,  round(avg(rating),1) rating FROM book_reply group by book_num) r on b.book_num = r.book_num)a order by a.rating desc, rnum desc) WHERE rnum >= ? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mtype);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			rs = pstmt.executeQuery();

			list = new ArrayList<BookDto>();
			while(rs.next()) {
				BookDto book = new BookDto();
				
				book.setHighLv(rs.getString("highLv"));
				book.setLowLv(rs.getString("lowLv"));
				book.setBook_num(rs.getInt("book_num"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setPrice(rs.getInt("price"));
				book.setImgFilename(rs.getString("imgFilename"));
				book.setRating(rs.getFloat("rating"));
				list.add(book);
			}

		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	
	//ebook 정보 수정
	public void updateBookInfo(BookDto book) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt=0;
		try {
			conn = getConnection();

			sql = "UPDATE book SET highlv=?, lowlv=?, title=?, author=?, price=?, audiolink=?,imgfilename=?,contentfilename=?,seriescode=?,introduction=?,pubdate=? WHERE book_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(++cnt, book.getHighLv());
			pstmt.setString(++cnt, book.getLowLv());
			pstmt.setString(++cnt, book.getTitle());
			pstmt.setString(++cnt, book.getAuthor());
			pstmt.setInt(++cnt, book.getPrice());
			pstmt.setString(++cnt, book.getAudioLink());
			pstmt.setString(++cnt, book.getImgFilename());
			pstmt.setString(++cnt, book.getContentFilename());
			pstmt.setString(++cnt, book.getSeriesCode());
			pstmt.setString(++cnt, book.getIntroduction());
			pstmt.setDate(++cnt, book.getPubDate());

			pstmt.setInt(++cnt, book.getBook_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt, conn);
		}
		
	}
	
	//ebook 삭제
	public void deleteBook(int book_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = getConnection();
			//autocommit 해제
			conn.setAutoCommit(false);
			
			//댓글 삭제 : 게시글 삭제 전에 fk 제약조건으로 인해  댓글을 먼저 지워야한다.
			sql = "DELETE FROM book_reply WHERE book_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			pstmt.executeUpdate();
			
			//book 삭제
			sql = "DELETE FROM book WHERE book_num=?";
			pstmt2 = conn.prepareStatement(sql);
			
			pstmt2.setInt(1,book_num);
			
			pstmt2.executeUpdate();
			
			//commit
			conn.commit();
		}catch(Exception e) {
			//rollback
			conn.rollback();
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt2, null);
			executeClose(null, pstmt, conn);
		}
	}
	
	
	//댓글추가
	public void insertReply(BookReply reply) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		
		try {
			conn = getConnection();
			sql = "INSERT INTO book_reply (re_num,re_content,re_date,re_ip,rating,book_num,memberId) VALUES(bookreply_seq.nextval,?,sysdate,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(++cnt, reply.getRe_content());
			pstmt.setString(++cnt, reply.getRe_ip());
			pstmt.setFloat(++cnt, reply.getRating());
			pstmt.setInt(++cnt, reply.getBook_num());
			pstmt.setString(++cnt, reply.getMemberId());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt, conn);
		}
	}
	//댓글 개수
	public int getBookReplyCount(int book_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = getConnection();
			sql = "SELECT count(re_num) FROM book_reply WHERE book_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			
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
	
	//댓글 목록
	public List<BookReply> getReplyList(int start, int end,int book_num)throws Exception{
		List<BookReply> list = null;
		BookReply reply = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			conn = getConnection();
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM book_reply WHERE book_num=? ORDER BY re_num DESC)a) WHERE rnum>=? AND rnum <=?";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, book_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<BookReply>();
			
			while(rs.next()) {
				reply = new BookReply();
				
				reply.setRe_num(rs.getInt("re_num"));
				reply.setRe_content(StringUtil.useBrNoHtml(rs.getString("re_content")));
				reply.setRe_date(rs.getDate("re_date"));
				reply.setBook_num(rs.getInt("book_num"));
				reply.setRating(rs.getFloat("rating"));
				reply.setMemberId(rs.getString("memberId"));
								
				list.add(reply);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(rs, pstmt, conn);
		}
		return list;
	}
	//댓글 수정
	public void updateBookReply(BookReply reply) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try{
			conn = getConnection();
			
			sql = "UPDATE book_reply SET re_content=?, re_ip=? WHERE re_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(++cnt, reply.getRe_content());
			pstmt.setString(++cnt, reply.getRe_ip());
			pstmt.setInt(++cnt, reply.getRe_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt, conn);
		}
	}
	//댓글 삭제
	public void deleteBookReply(int re_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try{
			conn = getConnection();
			
			sql = "DELETE FROM book_reply WHERE re_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, re_num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			executeClose(null, pstmt, conn);
		}
	}
}
