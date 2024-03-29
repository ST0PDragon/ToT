package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {
	public int write (Evaluation evaluation) {
		String sql = "INSERT INTO evaluation VALUES(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, evaluation.getUserID().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, evaluation.getRestaurantName().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, evaluation.getRefereeName().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(4, evaluation.getAteYear());
			pstmt.setString(5, evaluation.getAteMonth().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, evaluation.getFoodMenu().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, evaluation.getComment().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, evaluation.getContent().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, evaluation.getTotalScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(10, evaluation.getTasteScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11, evaluation.getVibeScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(12, evaluation.getServiceScore().replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\r\n", "<br>"));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return -1; //데이터 베이스 오류
	}
	
	public ArrayList<Evaluation> getList (String foodMenu, String searchType, String search, int pageNumber) {
		if(foodMenu.equals("전체") ) 
			foodMenu = "";
		ArrayList<Evaluation> evaluationList = null;
		String sql = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.equals("최신순")) {
				sql = "SELECT * FROM evaluation WHERE foodMenu LIKE ? AND CONCAT(restaurantName, refereeName, comment, content) LIKE "
						+ "? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if (searchType.equals("추천순")) {
				sql = "SELECT * FROM evaluation WHERE foodMenu LIKE ? AND CONCAT(restaurantName, refereeName, comment, content) LIKE "
						+ "? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + foodMenu + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<Evaluation>();
			while(rs.next()) {
				Evaluation evaluation = new Evaluation(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14)
				);
				evaluationList.add(evaluation);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return evaluationList; //데이터 베이스 오류
	}
	
	public int like(String evaluationID) {
		String sql = "UPDATE evaluation SET likeCount = likeCount + 1 WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return -1; 
	}
	
	public int delete(String evaluationID) {
		String sql = "DELETE FROM evaluation WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return -1; 
	}
	
	public String getUserID(String evaluationID) {
		String sql = "SELECT userID FROM evaluation WHERE evaluationID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getString(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return null; 
	}
}