/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.se1611.servlets;

import com.se1611.book.BookDAO;
import com.se1611.book.BookDTO;
import com.se1611.orderDetail.OrderDetailDAO;
import com.se1611.orderDetail.OrderDetailDTO;
import com.se1611.request.RequestDAO;
import com.se1611.request.RequestDTO;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class SellerBookServlet extends HttpServlet {

    private final String INVALID_PAGE = "invalidPage";
    private final String SELLER_ORDER_PAGE = "sellerOrderPage";
    private final String SELLER_ORDER_DETAIL_PAGE = "sellerOrderDetailPage";
    private final String SELLER_LIST_ORDER_PAGE = "sellerListOrderPage";
    private final String SELLER_BOOK_DETAIL_PAGE = "sellerBookDetailPage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String url = INVALID_PAGE;
        // /lấy Acction Để đưa vào switch vô case chuyển page
        String action = request.getParameter("action");
        // Session
        HttpSession session = request.getSession();
        // Create list save book
        List<BookDTO> list = new ArrayList<>();
        BookDAO dao = new BookDAO();
        //GEt List Request
        List<RequestDTO> listRequest = new ArrayList<>();
        RequestDAO daoRequest = new RequestDAO();
        
        // số book cần lấy, 1 page gồm 4 book
        int first = 0;
        int last = 0;
        try {
            switch (action) {
                //Page Book
                case "bookPage1":
                    first = 1;
                    last = 4;
                    list = dao.getInformationBook(first, last);
                    session.setAttribute("listBook", list);
                    url = SELLER_ORDER_PAGE;
                    break;
                case "bookPage2":
                    first = 5;
                    last = 8;
                    list = dao.getInformationBook(first, last);
                    session.setAttribute("listBook", list);
                    url = SELLER_ORDER_PAGE;
                    break;
                case "bookPage3":
                    first = 9;
                    last = 12;
                    list = dao.getInformationBook(first, last);
                    session.setAttribute("listBook", list);
                    url = SELLER_ORDER_PAGE;
                    break;
                case "bookPage4":
                    first = 13;
                    last = 16;
                    list = dao.getInformationBook(first, last);
                    session.setAttribute("listBook", list);
                    url = SELLER_ORDER_PAGE;
                    break;

                // Page Detail Book khi click vào từng book
                case "bookDetail":
                    listRequest = daoRequest.getRequest();
                    int bookId = Integer.parseInt(request.getParameter("bookId"));
                    request.setAttribute("request_Book_Id", checkBook(bookId, listRequest, request));
                    first = 1;
                    last = 16;
                    list = dao.getInformationBook(first, last);
                    session.setAttribute("listBook", list);
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                    list = dao.getCategoryBook(categoryId);
                    request.setAttribute("bookIdServlet", bookId);
                    request.setAttribute("nameCategory", list.get(0).getCategoryName());
                    url = SELLER_BOOK_DETAIL_PAGE;
                    break;
            }
        } catch (SQLException e) {
            log("BookServlet_SQL_" + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
            // response.sendRedirect(url);
        }
    }

    private int checkBook(int bookId, List<RequestDTO> listRequest, HttpServletRequest request) {
        int request_Book_Id = 0;
        for (int i = 0; i < listRequest.size(); i++) {
            if (bookId == listRequest.get(i).getRequest_Book_Id()) {
                request_Book_Id = bookId;
                //Get Request Id
                request.setAttribute("request_Id", listRequest.get(i).getRequest_Id());
            }
        }
        return request_Book_Id;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(SellerBookServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SellerBookServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(SellerBookServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SellerBookServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
