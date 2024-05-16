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
import java.util.ArrayList;

/**
 * Servlet implementation class GetMemberCostCtrl
 */
public class GetMemberCostCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetMemberCostCtrl() {
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
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		
		try {
			conn = DBConnection.getConnection();
			
			String sql = "SELECT A.CUSTNO, A.CUSTNAME, A.GRADE, B.PRICE"
					+ " FROM MEMBER_TBL_02 A"
					+ " RIGHT OUTER JOIN (SELECT CUSTNO, SUM(PRICE) AS PRICE FROM MONEY_TBL_02 GROUP BY CUSTNO) B"
					+ " ON A.CUSTNO = B.CUSTNO"
					+ " ORDER BY B.PRICE DESC";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				MemberVO vo = new MemberVO();
				
				vo.setCustno(rs.getInt("custno"));
				vo.setCustname(rs.getString("custname"));
				vo.setPrice(rs.getInt("price"));
				vo.setGrade(rs.getString("GRADE"));
				
				list.add(vo);
			}
			
			request.setAttribute("list", list);
			request.getRequestDispatcher("memberCostList.jsp").forward(request, response);
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
		doGet(request, response);
	}

}
