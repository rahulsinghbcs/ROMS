<%--
    Display the volunteer interview session invitation form.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="pageTitle">Interviews
        <fmt:formatDate value="${interviewSession.date}" pattern="yyyy-MM-dd" />
        <c:if test="${!empty interviewSession.kingdomHall}"> - <c:out value="${interviewSession.kingdomHall.name}" /></c:if>
    </c:set>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
        <h1><c:out value="${pageTitle}" /></h1>
        <hr />
        <dl class="dl-horizontal">
            <dt>Invited:</dt>
            <dd>${interviewSession.getAttendingVolunteerCount()} (${interviewSession.declinedVolunteerCount} declined)</dd>
        </dl>
        <div class="row-fluid">
            <div class="entity-list-results">
                <table class="table table-bordered table-condensed table-striped table-hover" id="session-invitation-list">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Forename</th>
                            <th>Surname</th>
                            <th>Congregation</th>
                            <th>Region</th>
                            <th>Comments</th>
                            <th>Status</th>
                            <th>Invite</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${volunteers}" var="volunteer">
                            <tr>
                                <td>${volunteer.id}</td>
                                <td><c:out value="${volunteer.forename}" /></td>
                                <td><c:out value="${volunteer.surname}" /></td>
                                <td>
                                    <c:if test="${!empty volunteer.congregation}">
                                        <a href="<c:url value='${volunteer.congregation.uri}' />"><c:out value="${volunteer.congregation.name}" /></a>
                                    </c:if>
                                </td>
                                <td><c:out value="${volunteer.rbcSubRegion}" /></td>
                                <td><c:out value="${volunteer.comments}" /></td>
                                <td><c:out value="${volunteer.interviewStatus}" /></td>
                                <td>
                                    <input class="a-invite" type="checkbox" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <ol class="breadcrumb">
            <li><a href="<c:url value="/" />">Edifice</a></li>
            <li><a href="<c:url value="${listUri}" />">Interview Sessions</a></li>
            <li class="active"><c:out value="${pageTitle}" /></li>
        </ol>

        <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        <script type="text/javascript" src="<c:url value='/javascript/volunteers.js' />" ></script>
    </body>
</html>
