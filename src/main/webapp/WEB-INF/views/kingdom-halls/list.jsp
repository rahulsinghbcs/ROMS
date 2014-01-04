<%--
    List the kingdom halls.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="pageTitle" value="Kingdom halls" />
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
            <h1>Kingdom halls</h1>
            <hr />
            <div class="entity-list-results">
                <table class="table table-bordered table-condensed table-striped table-hover" id="kingdom-hall-list">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Street</th>
                            <th>Town</th>
                            <th>Postcode</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${kingdomHalls}" var="kingdomHall">
                            <tr>
                                <td>${kingdomHall.name}</td>
                                <td>${kingdomHall.street}</td>
                                <td>${kingdomHall.town}</td>
                                <td>${kingdomHall.postcode}</td>
                                <td>
                                    <ul class="list-inline">
                                        <li><a class="btn btn-success" href="<c:url value="${kingdomHall.uri}" />">View</a></li>
                                        <sec:authorize access="hasPermission('KINGDOMHALL', 'EDIT')">
                                            <li><a class="list-action" href="<c:url value="${kingdomHall.editUri}" />">Edit</a></li>
                                        </sec:authorize>
                                    </ul>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <sec:authorize access="hasPermission('KINGDOMHALL', 'ADD')">
                <hr />
                <div class="entity-list-add-new">
                    <a class="btn btn-edifice" href="<c:url value="${newUri}" />">Create new kingdom hall</a>
                </div>
            </sec:authorize>

            <br />
            <ol class="breadcrumb">
                <li><a href="<c:url value="/" />">Edifice</a></li>
                <li class="active">Kingdom halls</li>
            </ol>
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        <script type="text/javascript" src="<c:url value='/javascript/kingdom-halls.js' />" ></script>
    </body>
</html>
