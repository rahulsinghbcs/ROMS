<%--
   Edit an existing project
--%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="pageTitle">Edit project</c:set>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
        <h1>Edit project</h1>
        <hr />
        <c:url var="formAction" value="${submitUri}" />
        <form:form commandName="projectForm" method="${submitMethod}" action="${formAction}">
            <fieldset>
                <label>Name</label>
                <form:input path="name" maxlength="50" />
                <label>Type</label>
                <!-- the type cannot be changed -->
                <form:hidden path="projectTypeId" />
                <p>${projectTypeName}</p>
                <label>Coordinator</label>
                <form:input path="coordinatorUserName" autocomplete="off" />
                <form:hidden path="coordinatorUserId" />
            </fieldset>
            <fieldset>
                <label>Kingdom hall</label>
                <form:input path="kingdomHallName" autocomplete="off" />
                <form:hidden path="kingdomHallId" />
                <label>Supporting congregation</label>
                <form:input path="supportingCongregation" maxlength="250" />
            </fieldset>
            <fieldset>
                <label>Request date</label>
                <form:input path="requestDate" class="datepicker" />
                <label>Visit Date</label>
                <form:input path="visitDate" class="datepicker" />
            </fieldset>
            <fieldset>
                <label>Priority</label>
                <form:input path="priority" maxlength="50" />
                <label>Estimated cost</label>
                <form:input path="estimateCost" maxlength="50" />
                <label>Constraints</label>
                <form:textarea path="constraints"  rows="4" cols="50" />
            </fieldset>
            <input type="submit" class="btn btn-edifice"/>
        </form:form>
        <ol class="breadcrumb">
            <li><a href="<c:url value="/" />">Edifice</a></li>
            <li role="menuitem"><a href="<c:url value="/projects" />">Projects</a></li>
            <li class="active">Edit</li>
        </ol>
        <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        <script type="text/javascript" src="<c:url value='/javascript/projects.js' />" ></script>
    </body>
</html>
