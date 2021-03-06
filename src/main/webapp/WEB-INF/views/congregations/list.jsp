<%--
    Document   : CongregationList
    Created on : 06-01-2013 18:12
    Author     : Ramindur Singh
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:url var="formAction" value="/congregations" />
<html>
    <c:set var="pageTitle">Congregation</c:set>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
            <h1>Congregations</h1>
            <hr />
            <div class="entity-list-results">
                <table class="table table-bordered table-condensed table-striped table-hover" id="congregation-list">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Kingdom hall</th>
                            <th>Circuit</th>
                            <th>Region</th>
                            <th>Subregion</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${congregations}" var="congregation">
                            <tr>
                                <td><c:out value="${congregation.name}" /></td>
                                <td>
                                    <c:if test="${not empty congregation.kingdomHall}">
                                        <a href="<c:url value='${congregation.kingdomHall.uri}'/>"><c:out value="${congregation.kingdomHall.name}" /></a>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${not empty congregation.circuit}">
                                        <a href="<c:url value='${congregation.circuit.uri}'/>"><c:out value="${congregation.circuit.name}" /></a>
                                    </c:if>
                                </td>
                                <td>${congregation.rbcRegion}</td>
                                <td>${congregation.rbcSubRegion}</td>
                                <td>
                                    <ul class="list-inline">
                                        <li><a class="btn btn-success" href="<c:url value="${congregation.uri}" />">View</a></li>
                                        <sec:authorize access="hasPermission('CONG', 'EDIT')">
                                            <li><a href="<c:url value="${congregation.editUri}" />">Edit</a></li>
                                        </sec:authorize>
                                    </ul>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <sec:authorize access="hasPermission('CONG', 'ADD')">
                <hr />
                <div class="entity-list-add-new">
                    <a class="btn btn-edifice" href="<c:url value="${newUri}" />">Create new congregation</a>
                </div>
            </sec:authorize>
            <br />
            <ol class="breadcrumb">
                <li><a href="<c:url value="/" />">Edifice</a></li>
                <li class="active">Congregations</li>
            </ol>
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        <script type="text/javascript" src="<c:url value='/javascript/congregations.js' />" ></script>
    </body>
</html>
