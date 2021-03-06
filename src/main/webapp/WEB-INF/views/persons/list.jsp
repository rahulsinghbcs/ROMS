<%--
    List the persons - a combination of all volunteers, overseers, emergency contacts, etc.
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="pageTitle">People</c:set>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
        <h1>People</h1>
        <hr />
        <div class="entity-list-results">
            <table class="table table-bordered table-condensed table-striped table-hover" id="person-list">
                <thead>
                    <tr>
                        <th>Forename</th>
                        <th>Surname</th>
                        <th>Congregation</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot>
                </tfoot>
            </table>
        </div>

        <br />
        <ol class="breadcrumb">
            <li><a href="<c:url value="/" />">Edifice</a></li>
            <li class="active">Persons</li>
        </ol>
        <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        <%@ include file="/WEB-INF/views/common/mustache-list-actions.jsp" %>
        <script type="text/javascript" src="<c:url value='/javascript/persons.js' />" ></script>
    </body>
</html>
