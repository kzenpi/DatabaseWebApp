<%-- 
    Document   : author
    Created on : Nov 25, 2016, 8:04:30 PM
    Author     : Nuboih
--%>

<%@page import = "java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Author Page</title>
    </head>
    <body>
        <%! // Create an Author class
            public class Author
            {

                String URL = "jdbc:mysql://localhost:3306/test";
                String USERNAME = "root";
                String PASSWORD = "1234";

                Connection connection = null;
                Statement statement = null;

                ResultSet resultSet = null;

                public Author()
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

                public ResultSet getAllAuthors()
                {
                    try
                    {
                        resultSet = statement.executeQuery("SELECT * FROM Author");
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
            Author author = new Author();
        %>

        <% // if the submit form is viewAll
            if (request.getParameter("submitViewAll") != null)
            {
                ResultSet authors = author.getAllAuthors();%>
        <table border="1">
            <tbody>
                <tr>
                    <td>Author Number</td>
                    <td>Last Name</td>
                    <td>First Name</td>
                </tr>

                <% while (authors.next())
                                {%>
                <tr>
                    <td><%= authors.getInt("authorNum")%></td>
                    <td><%= authors.getString("authorLast")%></td>
                    <td><%= authors.getString("authorFirst")%></td>
                </tr>
                <% };%>
            </tbody>
        </table>
        <% }%>
    </body>
</html>
