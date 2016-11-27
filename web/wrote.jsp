<%-- 
    Document   : wrote
    Created on : Nov 25, 2016, 8:05:12 PM
    Author     : Nuboih
--%>

<%@page import = "java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Wrote Page</title>
    </head>
    <body>
        <%!
            public class Wrote
            {

                String URL = "jdbc:mysql://localhost:3306/test";
                String USERNAME = "root";
                String PASSWORD = "1234";

                Connection connection = null;
                PreparedStatement viewStatement = null;
                ResultSet resultSet = null;

                public Wrote()
                {
                    try
                    {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        viewStatement = connection.prepareStatement("SELECT * FROM Wrote");
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                }

                public ResultSet getAllWrote()
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
            }
        %>

        <%
            Wrote wrote = new Wrote();
            ResultSet wrotes = wrote.getAllWrote();
        %>

        <table border="1">
            <tbody>
                <tr>
                    <td>Book Code</td>
                    <td>Author Number</td>
                    <td>Sequence</td>
                </tr>

                <% while (wrotes.next())
                    {%>
                <tr>
                    <td><%= wrotes.getInt("bookCode")%></td>
                    <td><%= wrotes.getInt("authorNum")%></td> 
                    <td><%= wrotes.getInt("sequence")%></td>
                </tr>
                <% };%>
            </tbody>
        </table>
    </body>
</html>
