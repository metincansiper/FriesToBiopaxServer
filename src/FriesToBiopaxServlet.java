

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class FriesToBiopaxServlet
 */
//@WebServlet("/FriesToBiopaxServlet")
public class FriesToBiopaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private JSONParser jsonParser;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FriesToBiopaxServlet() {
		super();

		jsonParser = new JSONParser();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Get response");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsonStr = IOUtils.toString(request.getInputStream());
		try {
			JSONObject friesJson = (JSONObject) jsonParser.parse(jsonStr);
			String biopaxStr = FriesToBiopax.convert(friesJson);
			response.getWriter().append(biopaxStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

}
