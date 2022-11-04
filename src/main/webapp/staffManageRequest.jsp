<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- link file CSS -->
    <link rel="stylesheet" href="./css/adminHomeStyle.css">
    <!-- BoxIcon CDN Link -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <%--    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>--%>
    <%--    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>--%>
    <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
          integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /*Start Form*/
        .modal-dialog {
            margin-top: 200px;
        }

        .add {
            width: 70px;
            height: 28px;
            margin-right: 10px;
            font-size: 15px;
        }

        .xclose {
            width: 70px;
            height: 28px;
            margin-right: 10px;
            font-size: 15px;
        }

        .head-form {
            color: #ffae00;
            font-weight: bold;
            margin: 20px 0px 0px 70px;
        }

        /*End Form*/
    </style>
</head>

<body>
<div class="header">
    <div class="header-menu">
        <!-- even menu sidebar -->
        <div class="sidebar-button__logo">
            <div class="sidebar-button">
                <i class='bx bx-menu sidebarBtn'></i>
            </div>
            <!-- div of logo -->
            <div class="logo-details">
                <img src="./images/logo.jpg" alt="Logo Phuong Nam Bookstore">
                <span class="logo_name">Book Store</span>
            </div>
        </div>
        <div class="seachbox-profile">
            <div class="wraper_searchbox_profile">
                <div class="search-box">
                    <input type="text" placeholder="Search...">
                    <button type='submit'><i class='bx bx-search-alt-2'></i></button>
                </div>
                <div class="profile_details">
                    <img src="images/admin1.png" alt="image admin">
                    <div class="name_role">
                        <span class="name">${sessionScope.USER["fullName"]}</span>
                        <i class='bx bxs-chevron-down'></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="wrapper-body">
    <div class="sidebar">
        <!-- link in sidebar -->
        <ul class="nav-links">
            <li>
                <a href="staffNodifyPage">
                    <i class='bx bxs-bell'></i>
                    <span class="links_name">Nodify</span>
                </a>
            </li>
            <li>
                <a href="staffImportationAction?action=getRequest">
                    <i class='bx bx-notification'></i>
                    <span class="links_name">Request</span>
                </a>
            </li>
            <li>
                <a href="staffImportationAction?action=getImportation">
                    <i class='bx bx-add-to-queue'></i>
                    <span class="links_name">Importation</span>
                </a>
            </li>
            <li>
                <a type="submit" href="staffBookAction?action=bookPage1">
                    <i class='bx bx-book'></i>
                    <span class="links_name">Books</span>
                </a>
            </li>
            <li>
                <a href="staffInventoryAction?action=getInventory">
                    <i class='bx bx-carousel'></i>
                    <span class="links_name">Inventory</span>
                </a>
            </li>
            <li>
                <a href="login.jsp">
                    <i class='bx bx-log-out'></i>
                    <span class="links_name">Log out</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- home content -->
    <div class="home-section">
        <!-- home-content -->
        <div class="home-content">

            <div class="overview-boxes">

                <div class="box">
                    <div class="left-side">
                        <%--                             Write   Body Code--%>
                        <table class="table">
                            <thead class="thead-dark" style="font-size: 15px">
                            <tr>
                                <th>Image</th>
                                <th>Name Book</th>
                                <th>Quantity</th>
                                <th>Note</th>
                                <th>Date Request</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody style="font-size: 15px">

                            <c:forEach var="i" items="${listRequest}">
                                <c:if test="${i.request_Status != 0}">
                                    <%--                                Start Show Item Request--%>
                                    <tr>
                                        <td><img style="height: 100px;width: 100px"
                                                 src="<c:url value="/images/${i.request_Image}"/>"/></td>
                                        <td>
                                            <a href="staffBookAction?action=bookDetail&bookId=${i.request_Book_Id}&categoryId=${i.request_Category}">
                                                    ${i.request_Name_Book}</a></td>
                                        <td>${i.request_Quantity}</td>
                                        <td>${i.request_Note}</td>
                                        <td>${i.request_Date}</td>
                                        <td>
                                            <c:if test="${i.request_Status==1}">
                                                <p style="color: red">Proceeding</p>
                                            </c:if>
                                            <c:if test="${i.request_Status==2}">
                                                <p style="color: #1ace1a">Done</p>
                                            </c:if></td>
                                        <td>
                                                <%--<button style="font-size: 15px" class="btn btn-info">Update--%>
                                                <%--</button>--%>
                                            <button style="font-size: 30px;border: none"  data-toggle="modal"
                                                    data-target="#myModal"><i class="fa-solid fa-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <%-- End Show Item Request--%>

                                    <%--Delete Request--%>
                                    <div class="modal fade" id="myModal">
                                        <div class="modal-dialog">
                                            <div class="modal-content">

                                                <header class="head-form mb-0">
                                                    <h2>Are You Sure Delete Request Book ?</h2>
                                                </header>

                                                <div class="modal-body">
                                                        <%--Form --%>
                                                    <form action="staffImportationAction?action=deleteRequest"
                                                          method="POST">
                                                        <input type="hidden" name="request_Id"
                                                               value="${i.request_Id}"/>
                                                            <%-- Are You Sure --%>
                                                </div>
                                                <!-- Modal footer -->
                                                <div class="modal-footer">
                                                    <button type="submit" class="btn btn-danger add">Delete</button>
                                                    </form>
                                                    <button class="btn btn-warning xclose" data-dismiss="modal">Close
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%--End Delete Request--%>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="./js/script.js"></script>


<%--Update Book Inventory--%>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>

</body>

</html>