<%-- 
    Document   : edit
    Created on : Apr 20, 2014, 5:35:07 PM
    Author     : ramindursingh
--%>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="roms" uri="/WEB-INF/tld/roms.tld"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:choose>
        <c:when test="${!empty userForm.userName}">
            <c:set var="pageTitle">Edit user</c:set>
        </c:when>
        <c:otherwise>
            <c:set var="pageTitle">Create new user</c:set>
        </c:otherwise>
    </c:choose>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
        <c:choose>
            <c:when test="${!empty userForm.userName}">
                <h1>Edit user</h1>
            </c:when>
            <c:otherwise>
                <h1>Create new user</h1>
            </c:otherwise>
        </c:choose>
        <hr />
        <c:url var="formAction" value="${submitUri}" />
        <form:form class="form-horizontal" commandName="userForm" method="${submitMethod}" action="${formAction}">
            <fieldset>
                <div class="row">
                    <h3 class="text-left">Volunteer</h3>
                    <div class="col-md-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <form:input class="form-control" path="personId" maxlength="10" placeholder="Person ID"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <form:input class="form-control" path="forename" maxlength="50" placeholder="First Name"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <form:input class="form-control" path="surname" maxlength="50" placeholder="Surname"/>
                            </div>
                        </div>
                    </div>   
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <form:input class="form-control" path="userName" maxlength="50" placeholder="Login Username"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <form:input class="form-control" path="password1" maxlength="50" placeholder="Password"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <form:input class="form-control" path="password2" maxlength="50" placeholder="Confirm Password"/>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>
            
                    <div class="row-fluid">
                        <div id="user-volunteer-user" data-user-id="${user.personId}"></div>
                        <table class="table table-bordered table-condensed table-striped table-hover" id="user-acl-list">
                            <thead>
                                <tr>
                                    <th>Application</th>
                                    <th>Department Access</th>
                                    <th>Non-Department Access</th>
                                </tr>
                            <thead />
                            <tbody>
                                <c:forEach items="${applications}" var="application">
                                    <tr>
                                        <td><c:out value="${application.name}" /></td>
                                        <td><roms:select selected="N" itemValue="${fn:toLowerCase(application.code)}Dept" /></td>
                                        <td><roms:select selected="N" itemValue="${fn:toLowerCase(application.code)}All" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                            </tfoot>
                        </table>
                    </div>
            <fieldset>
                <div class="col-sm-1 col-md-1">
                    <button type="submit" class="btn btn-default btn-success">Submit</button>
                </div>
            </div>
        </fieldset>
    </form:form>

    <ol class="breadcrumb">
        <li><a href="<c:url value="/" />">Edifice</a></li>
        <li role="menuitem"><a href="<c:url value="/users" />">Users</a></li>
            <c:choose>
                <c:when test="${!empty userForm.userName}">
                <li class="active">Edit</li>
                </c:when>
                <c:otherwise>
                <li class="active">New User</li>
                </c:otherwise>
            </c:choose>
    </ol>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    <script type="text/javascript" src="<c:url value='/javascript/users.js' />" ></script>
</body>
</html>