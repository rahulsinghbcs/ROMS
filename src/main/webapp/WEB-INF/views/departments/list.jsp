<%--
  List the departments.
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="pageTitle" value="Departments" />
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
        <div class="container-fluid">
            <h1>Departments</h1>
            <hr>
            <div class="entity-list-results">
                <table class="table table-bordered table-condensed table-striped table-hover" id="department-list">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Super Department</th>
                            <th>Overseer</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${departments}" var="department">
                            <tr>
                                <td>${department.name}</td>
                                <td>
                                    <c:if test="${not empty department.superDepartment}">
                                        <a href="<c:url value='${department.superDepartment.uri}'/>">${department.superDepartment.name}</a>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${not empty department.overseer}">
                                        <a href="<c:url value='${department.overseer.uri}'/>">${department.overseer.displayName}</a>
                                    </c:if>
                                </td>
                                <td>
                                    <ul class="inline list-actions">
                                        <li><a class="btn btn-success" href="<c:url value="${department.uri}" />">View</a></li>
                                    </ul>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <p>&nbsp;</p>
            <ul class="breadcrumb">
                <li><a href="<c:url value="/" />">Edifice</a> <span class="divider">/</span></li>
                <li class="active">Departments</li>
            </ul>
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        </div>
        <script type="text/javascript" src="<c:url value='/javascript/departments.js' />" ></script>
    </body>
</html>