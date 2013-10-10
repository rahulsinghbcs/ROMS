<%--
    Author     : oliver
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="pageTitle" value="Kingdom Hall: ${kingdomHall.name}" />
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
        <div class="container-fluid">
            <h1>Kingdom Hall #${kingdomHall.kingdomHallId}: ${kingdomHall.name}</h1>
            <hr>
            <dl class="dl-horizontal">
                <dt>Address:</dt>
                <c:choose>
                    <c:when test="${!empty kingdomHall.address}">
                        <dd>
                            <address>
                                <c:if test="${!empty kingdomHall.address.street}">${kingdomHall.address.street}<br /></c:if>
                                <c:if test="${!empty kingdomHall.address.town}">${kingdomHall.address.town}<br /></c:if>
                                <c:if test="${!empty kingdomHall.address.county}">${kingdomHall.address.county}<br /></c:if>
                                <c:if test="${!empty kingdomHall.address.postcode}">${kingdomHall.address.postcode}<br /></c:if>
                            </address>
                        </dd>
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
                <dt>Used By:</dt>
                <dd>
                    <c:choose>
                        <c:when test="${!empty congregations}">
                            <c:forEach items="${congregations}" var="congregation" varStatus="loop">
                                <a href="<c:url value="/congregations/${congregation.congregationId}" />">
                                ${congregation.name}
                                </a>
                                ${!loop.last ? ', ' : ''}
                            </c:forEach>
                        </c:when>
                        <c:otherwise><i>No congregations meet at this Hall</i></c:otherwise>
                    </c:choose>
                </dd>
                <dt>Title Holder:</dt>
                <dd>
                    <c:choose>
                        <c:when test="${!empty titleHolder}">
                            <a href="<c:url value="/congregations/${congregation.congregationId}" />">
                            ${titleHolder.name}
                            </a>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </dd>
            </dl>
            
            <ol class="breadcrumb">
                <li><a href="<c:url value="/" />">Edifice</a></li>
                <sec:authorize access="hasPermission('KINGDOMHALL', 'READ')">
                  <li><a href="<c:url value="/kingdom-halls" />">Kingdom Halls</a></li>
                </sec:authorize>
                <li class="active">#${kingdomHall.kingdomHallId}: ${kingdomHall.name}</li>
            </ol>            
            
        <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        </div>
     <script type="text/javascript" src="<c:url value='/javascript/kingdom-halls.js' />" ></script>
    </body>
</html>
