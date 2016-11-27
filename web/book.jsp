<%-- 
    Document   : book
    Created on : Nov 25, 2016, 8:04:40 PM
    Author     : Nuboih
--%>

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
        <%!
            public class Book
            {

                String URL = "jdbc:mysql://localhost:3306/test";
                String USERNAME = "root";
                String PASSWORD = "1234";

                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                public Book()
                {
                    try
                    {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        statement = connection.createStatement();
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
                        resultSet = statement.executeQuery("SELECT * FROM Book");
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                    return resultSet;
                }
            }
        %>

        <%
            Book book = new Book();
            ResultSet books = book.getAllBooks();
        %>

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
    </body>
</html>

