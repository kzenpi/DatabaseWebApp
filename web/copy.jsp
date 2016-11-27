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
                PreparedStatement insertStatement = null;
                PreparedStatement deleteStatement = null;
                PreparedStatement viewStatement = null;
                ResultSet resultSet = null;

                public Copy()
                {
                    try
                    {
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        insertStatement = connection.prepareStatement(
                                "INSERT INTO Copy (bookCode, branchNum, copyNum, quality, price)"
                                + " VALUES (?, ?, ?, ?, ?)");
                        deleteStatement = connection.prepareStatement("DELETE FROM Copy"
                                + " WHERE bookCode = ?"
                                + " AND branchNum = ?"
                                + " AND copyNum = ?");
                        viewStatement = connection.prepareStatement("SELECT * FROM Copy");
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
                        resultSet = viewStatement.executeQuery();
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }
                    return resultSet;
                }

                public int insertCopy(String bookCode, int branchNum, int copyNum, String quality, double price)
                {
                    int result = 0;

                    try
                    {
                        insertStatement.setString(1, bookCode);
                        insertStatement.setInt(2, branchNum);
                        insertStatement.setInt(3, copyNum);
                        insertStatement.setString(4, quality);
                        insertStatement.setDouble(5, price);
                        result = insertStatement.executeUpdate();
                    }
                    catch (SQLException e)
                    {
                        e.printStackTrace();
                    }

                    return result;
                }

                public int deleteCopy(String bookCode, int branchNum, int copyNum)
                {
                    int result = 0;

                    try
                    {
                        deleteStatement.setString(1, bookCode);
                        deleteStatement.setInt(2, branchNum);
                        deleteStatement.setInt(3, copyNum);
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
            Copy copy = new Copy();
        %>

        <% // if the submit form is viewAll
            if (request.getParameter("submitViewAll") != null)
            {
                ResultSet copies = copy.getAllCopies(); %>
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
        <% } // end of if statement for view all copies%>

        <%// Submit Data Button, fill the form
            if (request.getParameter("submitData") != null)
            {
        %>
        <form action="copy.jsp" method="POST">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Book Code : </td>
                        <td><input type="text" name="formBookCode" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Branch Number : </td>
                        <td><input type="text" name="formBranchNum" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td># of Copies : </td>
                        <td><input type="text" name="formCopyNum" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Quality : </td>
                        <td><input type="text" name="formQuality" value="" size="50" /></td>
                    </tr>
                    <tr>
                        <td>Price : </td>
                        <td><input type="text" name="formPrice" value="" size="50" /></td>
                    </tr>
                </tbody>
            </table>
            <input type="reset" value="Clear" name="clear" />
            <input type="submit" value="Submit" name="submitCopy" />
        </form>
        <% } // end of if statement, for filling the form%>

        <% // Submit Copy button, Insert copy into database
            if (request.getParameter("submitCopy") != null)
            {
                int result = 0;
                String bookCode = new String();
                int branchNum = 0;
                int copyNum = 0;
                String quality = new String();
                double price = 0.0;

                if (request.getParameter("formBookCode") != null)
                {
                    bookCode = request.getParameter("formBookCode");
                }
                if (request.getParameter("formBranchNum") != null)
                {
                    branchNum = Integer.parseInt(request.getParameter("formBranchNum"));
                }
                if (request.getParameter("formCopyNum") != null)
                {
                    copyNum = Integer.parseInt(request.getParameter("formCopyNum"));
                }
                if (request.getParameter("formQuality") != null)
                {
                    quality = request.getParameter("formQuality");
                }
                if (request.getParameter("formPrice") != null)
                {
                    price = Double.parseDouble(request.getParameter("formPrice"));
                }
                result = copy.insertCopy(bookCode, branchNum, copyNum, quality, price);
            } // end of if statement, for inserting publisher
        %>

        <%// form = delete data, fill the form
            if (request.getParameter("submitDelete") != null)
            {
                ResultSet copies = copy.getAllCopies();
        %>
        <form action="copy.jsp" method="POST">
            <table border="1">
                <thead>
                    <tr>
                        <th>(Delete)</th>
                        <th>Book Code</th>
                        <th>Branch Number</th>
                        <th># of Copies</th>
                        <th>Quality</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (copies.next())
                        {%>
                    <tr>
                        <td><input type="checkbox" name="listCopies" value="<%= copies.getString("bookCode")%>,<%= copies.getInt("branchNum")%>,<%= copies.getInt("copyNum")%>"></td>
                        <td><%= copies.getString("bookCode")%> </td>
                        <td><%= copies.getInt("branchNum")%> </td>
                        <td><%= copies.getInt("copyNum")%> </td>
                        <td><%= copies.getString("quality")%> </td>
                        <td><%= copies.getDouble("price")%> </td>
                    </tr>
                    <% } // end of while%>
                </tbody>
            </table>
            <input type="submit" value="Submit" name="submitDeleteCopy" />
        </form>
        <% } // end of if statement for filling the delete form%>

        <% // button = submitDeleteCopy, delete a key from the database

            if (request.getParameter("submitDeleteCopy") != null)
            {
                // values from the checkboxes
                String[] keysOfCopies = request.getParameterValues("listCopies");
                for (String keysCopy : keysOfCopies)
                {
                    String[] tokens = keysCopy.split(",");
                    copy.deleteCopy(tokens[0], Integer.parseInt(tokens[1]), Integer.parseInt(tokens[2]));
                }
            }
        %> 
    </body>
</html>
