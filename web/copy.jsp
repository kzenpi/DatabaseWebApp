<%-- 
    Document   : copy
    Created on : Nov 25, 2016, 8:04:54 PM
    Author     : Nuboih
--%>

<%@page import = "java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Copy Page</title>
    </head>
    <body>
        <%!
            public class Copy
            {

                String URL = "jdbc:mysql://localhost:3306/test";
                String USERNAME = "root";
                String PASSWORD = "1234";

                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                public Copy()
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

                public ResultSet getAllCopies()
                {
                    try
                    {
                        resultSet = statement.executeQuery("SELECT * FROM Copy");
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
            Copy copy = new Copy();
            ResultSet copies = copy.getAllCopies();
        %>

        <table border="1">
            <tbody>
                <tr>
                    <td>Book Code</td>
                    <td>Branch Number</td>
                    <td>Amount of Copies</td>
                    <td>Quality</td>
                    <td>Price</td>
                </tr>

                <% while (copies.next())
                    {%>
                <tr>
                    <td><%= copies.getInt("bookCode")%></td>
                    <td><%= copies.getInt("branchNum")%></td>
                    <td><%= copies.getInt("copyNum")%></td>
                    <td><%= copies.getString("quality")%></td>
                    <td><%= copies.getDouble("price")%></td>

                </tr>
                <% };%>
            </tbody>
        </table>
    </body>
</html>
