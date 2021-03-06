<%--
    Author     : Oliver
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="pageTitle">Projects</c:set>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
        <h1>Projects</h1>
        <hr />
        <table class="table table-bordered table-condensed table-striped table-hover" id="project-list">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Kingdom Hall</th>
                    <th>Name</th>
                    <th>Minor Work</th>
                    <th>Requested</th>
                    <th>Completed</th>
                    <th>Coordinator</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${projects}" var="project">
                    <tr>
                        <td>${project.projectId}</td>
                        <td>
                            <c:if test="${not empty project.kingdomHall}">
                                <a href="<c:url value='${project.kingdomHall.uri}'/>">
                                    <c:out value="${project.kingdomHall.name}" />
                                </a>
                            </c:if>
                        </td>
                        <td><c:out value="${project.name}" /></td>
                        <td>${project.minorWork}</td>

                        <td><fmt:formatDate value="${project.requestDate}" pattern="yyyy-MM-dd" /></td>
                        <td><fmt:formatDate value="${project.completedDate}" pattern="yyyy-MM-dd" /></td>
                        <td>
                            <c:if test="${not empty project.coordinator}">
                                <a href="<c:url value='${project.coordinator.uri}'/>">
                                    <c:out value="${project.coordinator.name}" />
                                </a>
                            </c:if>
                        </td>
                        <td>
                            <ul class="list-inline">
                                <li><a class="btn btn-success" href="<c:url value="${project.uri}" />">View</a></li>
                            </ul>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="row-fluid">
            <sec:authorize access="hasPermission('PROJECT', 'ADD')">
                <hr />
                <a class="btn btn-edifice" href="<c:url value="${newUri}" />">Create new project</a>
            </sec:authorize>
            <a class="btn btn-edifice" href="<c:url value="${allProjectUri}" />">See all projects</a>
        </div>
        <br />
        <ol class="breadcrumb">
            <li><a href="<c:url value="/" />">Edifice</a></li>
            <li class="active">Projects</li>
        </ol>
        <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        <script type="text/javascript" src="<c:url value='/javascript/projects.js' />" ></script>
    </body>
</html>
