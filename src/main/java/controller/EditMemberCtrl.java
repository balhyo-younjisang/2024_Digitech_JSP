package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBConnection;
import vo.MemberVO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class EditMemberCtrl
 */
public class EditMemberCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditMemberCtrl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		MemberVO vo = null;
		
		String custno = request.getParameter("custno");
		
		try {
			conn = DBConnection.getConnection();
			String sql = "SELECT * FROM MEMBER_TBL_02 WHERE CUSTNO = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, custno);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				vo = new MemberVO();
				
				vo.setCustno(rs.getInt("custno"));
				vo.setCustname(rs.getString("custname"));
				vo.setPhone(rs.getString("phone"));
				vo.setJoindate(rs.getDate("joindate"));
				vo.setCity(rs.getString("city"));
				vo.setAddress(rs.getString("address"));
				vo.setGrade(rs.getString("grade"));
			}
			
			request.setAttribute("vo", vo);
			request.getRequestDispatcher("editMember.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(rs, stmt, conn);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String custno = request.getParameter("custno");
		String custname = request.getParameter("custname");
		String phone = request.getParameter("phone");
		String city = request.getParameter("city");
		String address = request.getParameter("address");
		String grade = request.getParameter("grade");
		
		try {
			conn = DBConnection.getConnection();
			
			String sql = "UPDATE MEMBER_TBL_02 SET CUSTNAME = ?, PHONE = ?, CITY = ?, ADDRESS = ?, GRADE = ? WHERE CUSTNO = ?";
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, custname);
			stmt.setString(2, phone);
			stmt.setString(3, city);
			stmt.setString(4, address);
			stmt.setString(5, grade);
			stmt.setString(6, custno);
			
			if(stmt.executeUpdate() > 0) {
				request.setAttribute("alertMsg", "회원정보수정이 완료되었습니다.");
				request.getRequestDispatcher("editMember.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(stmt, conn);
		}
	}

}
