package courses.alex.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import courses.alex.data.LoadFromUrl;

/**
 * Servlet implementation class getUploadImgUrl
 */
public class getUploadImgUrl extends HttpServlet {
    private static final long   serialVersionUID    = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public getUploadImgUrl() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.setCharacterEncoding("utf-8");

        String url = request.getParameter("url");
        String galleryName = request.getParameter("galleryName");
        System.out.println(url);
        LoadFromUrl.loadImage(url, galleryName);

		request.setAttribute("galleryName", galleryName);
        RequestDispatcher dispatcher = getServletContext()
                .getRequestDispatcher("/gallery.jsp");
        dispatcher.forward(request, response);
    }

}
