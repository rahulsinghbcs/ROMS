<%--
    Form use to edit or create congregations.
--%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<c:choose>
    <c:when test="${!empty congregationForm.name}">
        <c:set var="pageTitle" value="Edit congregation" />
    </c:when>
    <c:otherwise>
        <c:set var="pageTitle" value="Create new congregation" />
    </c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<body>
    <%@ include file="/WEB-INF/views/common/titlebar.jsp"%>
    <c:choose>
        <c:when test="${!empty congregationForm.name}">
            <h1>Edit congregation</h1>
        </c:when>
        <c:otherwise>
            <h1>Create new congregation</h1>
        </c:otherwise>
    </c:choose>
    <hr />
    <c:url var="formAction" value="${submitUri}" />
    <form:form commandName="congregationForm" method="${submitMethod}" action="${formAction}">
        <fieldset>
            <label>Congregation name</label>
            <form:input path="name" maxlength="50" />
            <label>Number</label>
            <form:input path="number" maxlength="10" />
            <label>Kingdom hall</label>
            <form:input path="kingdomHallName" autocomplete="off" />
            <form:hidden path="kingdomHallId" />
            <label>Circuit</label>
            <form:select path="circuitId">
                <form:option value="" />
                <form:options items="${circuits}" itemValue="circuitId" itemLabel="name" />
            </form:select>
            <label>RBC region</label>
            <form:select path="rbcRegionId">
                <form:option value="" />
                <form:options items="${rbcRegions}" />
            </form:select>
            <label>RBC subregion</label>
            <form:select path="rbcSubRegionId">
                <form:option value="" />
                <form:options items="${rbcSubRegions}" />
            </form:select>
            <label>Publishers</label>
            <form:input path="publishers" maxlength="10" />
            <label>Attendance</label>
            <form:input path="attendance" maxlength="10" />
        </fieldset>
        <fieldset>
            <legend>Contacts</legend>
            <div id="coordinator">
                <form:hidden path="coordinatorPersonId" />
                <!-- use style display:none since the div is dynamically shown, based on the defined coordinator -->
                <div id="coordinator-unlinked" style="display:none">
                    <label for="coordinatorForename">Coordinator forename</label>
                    <form:input path="coordinatorForename" maxlength="50" />
                    <label for="coordinatorForename">Coordinator surname</label>
                    <form:input path="coordinatorSurname" maxlength="50" />
                </div>
                <!-- use style display:none since the div is dynamically shown, based on the defined coordinator -->
                <div id="coordinator-linked" style="display:none">
                    Coordinator: <span id="coordinator-linked-text"></span>
                    <a class="btn btn-edifice btn-xs" href="#">Unlink</a>
                </div>
            </div>
            <div id="secretary">
                <form:hidden path="secretaryPersonId" />
                <!-- use style display:none since the div is dynamically shown, based on the defined secretary -->
                <div id="secretary-unlinked" style="display:none">
                    <label for="secretaryForename">Secretary forename</label>
                    <form:input path="secretaryForename" maxlength="50" />
                    <label for="secretaryForename">Secretary surname</label>
                    <form:input path="secretarySurname" maxlength="50" />
                </div>
                <!-- use style display:none since the div is dynamically shown, based on the defined secretary -->
                <div id="secretary-linked" style="display:none">
                    Secretary: <span id="secretary-linked-text"></span>
                    <a class="btn btn-edifice btn-xs" href="#">Unlink</a>
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend>Strategy</legend>
            <label>Funds</label>
            <form:input path="funds" maxlength="50" />
            <label>Loans</label>
            <form:input path="loans" maxlength="10" />
            <label>Monthly income</label>
            <form:input path="monthlyIncome" maxlength="10" />
            <label>Strategy</label>
            <form:textarea path="strategy"  rows="4" cols="50" />
        </fieldset>
        <input type="submit" class="btn btn-edifice" />
    </form:form>

    <ol class="breadcrumb">
        <li><a href="<c:url value="/" />">Edifice</a></li>
        <li><a href="<c:url value="/congregations" />">Congregations</a></li>
        <li class="active">Edit Congregation</li>
    </ol>

    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
    <%@ include file="/WEB-INF/views/common/mustache-person-link-search-form.jsp"%>
    <%@ include file="/WEB-INF/views/common/person-link-modal.jsp"%>
    <script type="text/javascript" src="<c:url value='/javascript/thirdparty/jquery-numeric-1.3.1.js' />" ></script>
    <script type="text/javascript" src="<c:url value='/javascript/congregations.js' />"></script>
</body>
</html>
