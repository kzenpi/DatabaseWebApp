<%-- 
    Document   : branch
    Created on : Nov 25, 2016, 8:04:47 PM
    Author     : Nuboih
--%>

<%@page import = "java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Branch Page</title>
    </head>
    <body>
        <%!
            public class Branch
            {

                String URL = "jdbc:mysql://localhost:3306/test";
                String USERNAME = "root";
                String PASSWORD = "1234";

                Connection connection = null;
                PreparedStatement viewStatement = null;
                ResultSet resultSet = null;

                public Branch()
                {
                    try
                    {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        viewStatement = connection.prepareStatement("SELECT * FROM Branch");
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                }

                public ResultSet getAllBranches()
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
            Branch branch = new Branch();
            ResultSet branches = branch.getAllBranches();
        %>

        <table border="1">
            <tbody>
                <tr>
                    <td>Branch Number</td>
                    <td>Name</td>
                    <td>Location</td>
                </tr>

                <% while (branches.next())
                    {%>
                <tr>
                    <td><%= branches.getInt("branchNum")%></td>
                    <td><%= branches.getString("branchName")%></td>
                    <td><%= branches.getString("branchLocation")%></td>
                </tr>
                <% };%>
            </tbody>
        </table>
    </body>
</html>