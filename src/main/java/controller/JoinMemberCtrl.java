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
import java.util.Objects;

/**
 * Servlet implementation class JoinMemberCtrl
 */
public class JoinMemberCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinMemberCtrl() {
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
		
		try {
			conn = DBConnection.getConnection();
			
			String sql = "SELECT NVL(MAX(CUSTNO), 0) + 1 FROM MEMBER_TBL_02";
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				vo = new MemberVO();
				vo.setCustno(rs.getInt(1));
			}
			
			request.setAttribute("vo", vo);
			request.getRequestDispatcher("join.jsp").forward(request, response);
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
		String custno = request.getParameter("custno");
		String custname = request.getParameter("custname");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String date = request.getParameter("date");
		String grade = request.getParameter("grade");
		String city = request.getParameter("city");
		
		String alertMsg = null;
		
		// 도시코드 유효성 검사
		if(city.length() != 2) alertMsg = "도시코드가 올바르게 입력되지 않았습니다.";
		// 회원등급 유효성 검사
		if(grade.length() != 1 || !(grade.equals("A") || grade.equals("B") || grade.equals("C"))) alertMsg = "회원등급이 올바르게 입력되지 않았습니다";
		
		// 주소 유효성 검사
		alertMsg = isValid(address, -1, 60, "회원주소");
		// 전화번호 유효성 검사
		alertMsg = isValid(phone, 13, -1, "회원전화");
		// 이름 유효성 검사
		alertMsg = isValid(custname, -1, 20, "회원성명");
		// 날짜 유효성 검사
		alertMsg = isValid(date, 8, -1, "가입일자");
		
		if(alertMsg == null) {
			Connection conn = null;
			PreparedStatement stmt = null;
			
			try {
				conn = DBConnection.getConnection();
				
				String sql = "INSERT INTO MEMBER_TBL_02 VALUES((SELECT NVL(MAX(CUSTNO), 0) + 1 FROM MEMBER_TBL_02),?,?,?,sysdate,?,?)";
				stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, custname);
				stmt.setString(2, phone);
				stmt.setString(3, address);
				stmt.setString(4, grade);
				stmt.setString(5, city);
				
				if(stmt.executeUpdate() > 0) {
					alertMsg = "회원등록이 완료 되었습니다! ";
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				DBConnection.close(stmt, conn);
			}
		}
		
		System.out.println(alertMsg);
		
		request.setAttribute("alert", alertMsg);
		request.getRequestDispatcher("join.jsp").forward(request, response);
	}
	
	private String isValid(String userInput, int validLength, int overLength, String type) {
		// 입력이 올바르지 않다면
		if(userInput == null || userInput.isBlank() || userInput.isEmpty()) return type + "이 입력되지 않았습니다";
		
		// 길이가 일치해야 하는 입력이라면 && 길이가 일치한다면 => 유효한 입력
		if(validLength >= 0 && userInput.length() != validLength) { 
			return type + "은(는) " + validLength + "자이여야 합니다.";
		}
		
		// 길이가 특정 길이 이하이여야 하는 입력이라면 && 길이가 이하이라면 => 유효한 입력
		if(overLength >= 0 && userInput.length() > overLength) {	
			return type + "은(는) " + overLength + "자 이하여야 합니다.";
		}
		
		return null;
	}

}
