<%--
    Display the skill details.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<c:set var="pageTitle">Skill - ${skill.name}</c:set>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<body>
    <%@ include file="/WEB-INF/views/common/titlebar.jsp"%>
    <h1>Skill: <c:out value="${skill.name}" /></h1>
    <hr />
    <dl class="dl-horizontal">
        <dt>Description:</dt>
        <dd>
            <c:choose>
                <c:when test="${!empty skill.description}"><c:out value="${skill.description}" /></c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </dd>
        <dt>Department</dt>
        <dd>
            <a href="<c:url value='${skill.department.uri}' />"><c:out value="${skill.department.name}" /></a>
        </dd>
        <dt>Category:</dt>
        <dd>
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
        </dd>
        <dt>Appear on badge?:</dt>
        <dd>
            <c:choose>
                <c:when test="${!empty skill.category && skill.category.appearOnBadge}">
                    <span class="glyphicon glyphicon-ok"></span>
                </c:when>
                <c:otherwise>
                    <span class="glyphicon glyphicon-remove"></span>
                </c:otherwise>
            </c:choose>
        </dd>
    </dl>
    <sec:authorize access="hasPermission('SKILL', 'EDIT')">
        <hr />
        <a href="<c:url value='${skill.editUri}' />" class="btn btn-edifice">Edit skill</a>
    </sec:authorize>
    <div class="clearfix"></div>
    <br />
    <ul class="nav nav-tabs">
        <li class="active"><a href="#volunteers" data-toggle="tab">Volunteers</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="volunteers">
            <div class="row-fluid">
                <div class="entity-list-results">
                    <table class="table table-bordered table-condensed table-striped table-hover" id="skills-volunteer-list" data-skill-id="${skill.skillId}">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Forename</th>
                                <th>Surname</th>
                                <th>Congregation</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                        <tfoot>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <br />
    <ol class="breadcrumb">
        <li><a href="<c:url value="/" />">Edifice</a></li>
        <li><a href="<c:url value="/skills" />">Skills</a></li>
        <li><c:out value="${skill.name}" /></li>
    </ol>

    <%@ include file="/WEB-INF/views/common/footer.jsp"%>
    <%@ include file="/WEB-INF/views/common/mustache-list-actions.jsp" %>
    <script type="text/javascript" src="<c:url value='/javascript/skills.js' />"></script>
</body>
</html>
