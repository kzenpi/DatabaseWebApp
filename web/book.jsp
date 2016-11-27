<%@page import = "java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Page</title>
    </head>
    <body>
        <%! // Create a Book class

            public class Book
            {

                String URL = "jdbc:mysql://localhost:3306/test";
                String USERNAME = "root";
                String PASSWORD = "1234";

                Connection connection = null;
                PreparedStatement insertStatement = null;
                PreparedStatement deleteStatement = null;
                PreparedStatement viewStatement = null;
                ResultSet resultSet = null;

                public Book()
                {
                    try
                    {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        insertStatement = connection.prepareStatement(
                                "INSERT INTO Book (bookCode, title, publisherCode, type, paperback)"
                                + " VALUES (?, ?, ?, ?, ?)");
                        deleteStatement = connection.prepareStatement("DELETE FROM Book WHERE bookCode = ?");
                        viewStatement = connection.prepareStatement("SELECT * FROM Book");
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                }

                public ResultSet getAllBooks()
                {
                    try
                    {
                        resultSet = viewStatement.executeQuery();
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                    return resultSet;
                }

                public int insertBook(String bookCode, String title, String pubCode, String type, String paperback)
                {
                    int result = 0;

                    try
                    {
                        insertStatement.setString(1, bookCode);
                        insertStatement.setString(2, title);
                        insertStatement.setString(3, pubCode);
                        insertStatement.setString(4, type);
                        insertStatement.setString(5, paperback);
                        result = insertStatement.executeUpdate();
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }

                    return result;
                }

                public int deleteBook(String bookCode)
                {
                    int result = 0;

                    try
                    {
                        deleteStatement.setString(1, bookCode);
                        result = deleteStatement.executeUpdate();
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                    return result;
                }
            }
        %>

        <%
            Book book = new Book();
        %>

        <% // if the submit form is viewAll
            if (request.getParameter("submitViewAll") != null)
            {
                ResultSet books = book.getAllBooks();%>
        <table border="1">
            <tbody>
                <tr>
                    <td>Book Code</td>
                    <td>Title</td>
                    <td>Publisher Code</td>
                    <td>Type</td>
                    <td>Paperback</td>
                </tr>

                <% while (books.next())
                    {%>
                <tr>
                    <td><%= books.getString("bookCode")%></td>
                    <td><%= books.getString("title")%></td>
                    <td><%= books.getString("publisherCode")%></td>
                    <td><%= books.getString("type")%></td>
                    <td><%= books.getString("paperback")%></td>
                </tr>
                <% };%>
            </tbody>
        </table>
        <% } // end of if statement for view all books%>

        <%// if the submit form is subit data, fill the form
            if (request.getParameter("submitData") != null)
            {
        %>
        <form action="book.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Book Code : </td>
                        <td><input type="text" name="formBookCode" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Title : </td>
                        <td><input type="text" name="formTitle" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Publisher Code: </td>
                        <td><input type="text" name="formPubCode" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Type : </td>
                        <td><input type="text" name="formType" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Paperback : </td>
                        <td><input type="text" name="formPaperback" value="" size="50" /></td>
                    </tr>
                </tbody>
            </table>
            <input type="reset" value="Clear" name="clear" />
            <input type="submit" value="Submit" name="submitBook" />
        </form>
        <% } // end of if statement for filling the form%>

        <% // insert book if the Submit button is submitBook
            if (request.getParameter("submitBook") != null)
            {
                int result = 0;
                String bookCode = new String();
                String title = new String();
                String pubCode = new String();
                String type = new String();
                String paperback = new String();

                if (request.getParameter("formBookCode") != null)
                {
                    bookCode = request.getParameter("formBookCode");
                }
                if (request.getParameter("formTitle") != null)
                {
                    title = request.getParameter("formTitle");
                }
                if (request.getParameter("formPubCode") != null)
                {
                    pubCode = request.getParameter("formPubCode");
                }
                if (request.getParameter("formType") != null)
                {
                    type = request.getParameter("formType");
                }
                if (request.getParameter("formPaperback") != null)
                {
                    paperback = request.getParameter("formPaperback");
                }

                result = book.insertBook(bookCode, title, pubCode, type, paperback);
            } // end of if statement for inserting book
        %>

        <%// form = delete data, fill the form
            if (request.getParameter("submitDelete") != null)
            {
                ResultSet books = book.getAllBooks();
        %>
        <form action="book.jsp" method="POST">
            <table border="1">
                <thead>
                    <tr>
                        <th>(Delete)</th>
                        <th>Book Code</th>
                        <th>Title</th>
                        <th>Publisher Code</th>
                        <th>Type</th>
                        <th>Paperback</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (books.next())
                        {%>
                    <tr>
                        <td><input type="checkbox" name="listBooks" value="<%= books.getString("bookCode")%>"></td>
                        <td><%=books.getString("bookCode")%> </td>
                        <td><%=books.getString("title")%></td>
                        <td><%=books.getString("publisherCode")%></td>
                        <td><%=books.getString("type")%></td>
                        <td><%=books.getString("paperback")%> </td>
                    </tr>
                    <% } // end of while%>
                </tbody>
            </table>
            <input type="submit" value="Submit" name="submitDeleteBook" />
        </form>
        <% } // end of if statement for filling the delete form%>

        <% // button = submitDeleteAuthor, delete an author from the database
            if (request.getParameter("submitDeleteBook") != null)
            {
                // values from the checkboxes
                String[] bookCodes = request.getParameterValues("listBooks");
                for (String bookCode : bookCodes)
                {
                    book.deleteBook(bookCode);
                }
            }
        %>

    </body>
</html>