<%--
    Document   : skillsList
    Created on : 25 Jan 2013
    Author     : ramindur.singh
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:url var="formAction" value="/skills" />
<html>
    <c:set var="pageTitle">Departmental skills</c:set>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
        <h1>Skills</h1>
        <hr />
        <div class="entity-list-results">
            <table class="table table-bordered table-condensed table-striped table-hover" id="skill-list">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${skills}" var="skill">
                        <tr>
                            <td><c:out value="${skill.name}" /></td>
                            <td><a href="<c:url value='${skill.department.uri}' />"><c:out value="${skill.department.name}" /></a></td>
                            <td><c:out value="${skill.description}" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${!empty skill.category.colour}">
                                        <c:set var="categoryColour" value="${fn:toLowerCase(skill.category.colour)}" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="categoryColour" value="white" />
                                    </c:otherwise>
                                </c:choose>
                                <div class="label label-default category-colour-${categoryColour}">
                                    <c:out value="${skill.category.name}" />
                                </div>
                            </td>
                            <td>
                                <ul class="list-inline">
                                    <li><a class="btn btn-success" href="<c:url value="${skill.uri}" />">View</a></li>
                                    <sec:authorize access="hasPermission('SKILL', 'EDIT')">
                                        <li><a href="<c:url value="${skill.editUri}" />">Edit</a></li>
                                    </sec:authorize>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <sec:authorize access="hasPermission('SKILL', 'ADD')">
            <hr />
            <div class="entity-list-add-new">
                <a class="btn btn-edifice" href="<c:url value="${newUri}" />">Create new departmental skill</a>
            </div>
        </sec:authorize>

        <br />
        <ol class="breadcrumb">
            <li><a href="<c:url value="/" />">Edifice</a></li>
            <li class="active">Skills</li>
        </ol>
        <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        <script type="text/javascript" src="<c:url value='/javascript/skills.js' />" ></script>
    </body>
</html>
