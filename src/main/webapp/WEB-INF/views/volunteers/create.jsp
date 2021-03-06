<%--
    Create a new volunteer. The layout is based on the S-82 form.
--%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:set var="pageTitle">Create volunteer</c:set>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <body>
        <%@ include file="/WEB-INF/views/common/titlebar.jsp" %>
        <div class="container">
            <h1>Regional building committee volunteer application</h1>
            <hr />
            <c:url var="formAction" value="/volunteers" />
            <form:form class="form-horizontal" commandName="volunteer" method="POST" action="${formAction}">
                <fieldset>
                    <form:hidden path="personId" />
                    <div class="row">
                        <h3 class="text-left">1.(a) Legal name</h3>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="surname" maxlength="50" placeholder="Last"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="forename" maxlength="50" placeholder="First"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="middleName" maxlength="50" placeholder="Middle" />
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="row">
                        <h3 class="text-left">1.(b) Gender</h3>
                        <div class="col-md-12">
                            <div class="col-md-1">
                                <label class="radio inline">
                                    <form:radiobutton path="gender" value="M" /> Male
                                </label>
                            </div>
                            <div class="col-md-1">
                                <label class="radio inline">
                                    <form:radiobutton path="gender" value="F" /> Female
                                </label>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="row">
                        <h3 class="text-left">2. Dates</h3>
                        <div class="col-md-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="birthDate">(a) Date of birth </label>
                                    <form:input path="birthDate" placeholder="dd/mm/yyyy" class="form-control datepicker" data-date-format="dd/mm/yy" type="text" value=""/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="baptismDate">(b) Date of baptism</label>
                                    <form:input path="baptismDate" placeholder="dd/mm/yyyy" class="form-control datepicker" data-date-format="dd/mm/yy" type="text" value=""/>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="row">
                        <h3 class="text-left">3. Addresses</h3>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="street" placeholder="No & street" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="town" placeholder="Town" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <form:input class="form-control" path="postcode" placeholder="Postcode" maxlength="10" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="email" placeholder="Email" />
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="row">
                        <h3 class="text-left">4. Phones</h3>
                        <div class="col-md-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <form:input class="form-control" path="telephone" placeholder="Home phone"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <form:input class="form-control" path="workPhone" placeholder="Work phone"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <form:input class="form-control" path="mobile" placeholder="Mobile phone"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="row">
                        <h3 class="text-left">5. Current privileges</h3>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <label id="elderLabel" class="checkbox inline">
                                    <form:checkbox path="elder" /> Elder
                                </label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <label id="ministerialServantLabel" class="checkbox inline">
                                    <form:checkbox path="ministerialServant" /> Ministerial&nbsp;servant
                                </label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <label class="checkbox inline">
                                    <form:checkbox path="regularPioneer" /> Regular&nbsp;pioneer
                                </label>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="row">
                        <form:hidden path="spousePersonId" />
                        <h3 class="text-left">6. Name of mate, if married</h3>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="spouseForename" placeholder="Spouse forename"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="spouseSurname" placeholder="Spouse surname"/>
                                </div>
                            </div>
                        </div>
                        <div id="spouse-linked" class="alert alert-warning alert-dismissable span10" style="display:none;">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">Unlink</button>
                            Linked to an existing person in the database
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="row">
                        <h3 class="text-left">7. Work background</h3>
                        <div class="controls controls-row trades-row" data-index="0">
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="text" name="trades[0].name" class="form-control trade-experience-name" placeholder="Trade/Profession" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="text" name="trades[0].experienceDescription" class="form-control trade-experience-description" placeholder="Type of experience"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input type="text" name="trades[0].experienceYears" class="form-control trade-experience-years" placeholder="Years experience"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="col-md-6">
                                    <button type="button" class="btn btn-danger btn-xs trades-row-delete"><i class="glyphicon glyphicon-remove icon-white icon-align-center"></i>&nbsp;Remove</button>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="col-md-4">
                                <button id="trades-row-add" type="button" class="btn btn-edifice btn-large"><i class="glyphicon glyphicon-plus"></i> Add trade</button>
                            </div>
                        </div>
                    </div>
                </fieldset>

                <fieldset>
                    <div class="row">
                        <form:hidden path="emergencyContactPersonId" />
                        <h3 class="text-left">8. In case of accident or illness, notify</h3>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="emergencyContactForename" placeholder="Contact's forename"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:input class="form-control" path="emergencyContactSurname" placeholder="Contact's surname"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <form:select class="form-control" path="emergencyRelationshipCode">
                                        <form:option value="" label="Relationship" />
                                        <form:options items="${relationshipValues}" />
                                    </form:select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="emergency-contact-linked" class="alert alert-warning alert-dismissable" style="display:none;">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">Unlink</button>
                        Linked to an existing person in the database
                    </div>
                </fieldset>

                <div id="emergency-contact-additional-fields">
                    <fieldset>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <form:input class="form-control" path="emergencyContactTelephone" placeholder="Contact's home phone"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <form:input class="form-control" path="emergencyContactMobile" placeholder="Contact's mobile"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <form:input class="form-control" path="emergencyContactStreet" placeholder="No & street" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <form:input class="form-control" path="emergencyContactTown" placeholder="Town" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <form:input class="form-control" path="emergencyContactPostcode" maxlength="10" placeholder="Postcode" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <fieldset>
                    <div class="row">
                        <h3 class="text-left">Final Details</h3>
                        <div class="controls controls-row">
                            <div class="col-md-4">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <form:input class="form-control" path="congregationName" placeholder="Congregation" autocomplete="off" />
                                        <form:hidden path="congregationId" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label text-left">Form date:</label>
                                    <form:input path="formDate" placeholder="dd/mm/yyyy" class="datepicker form-control" data-date-format="dd/mm/yy" />
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div>
                        <input type="submit" class="btn btn-lg btn-success"/>
                    </div>
                </fieldset>
            </form:form>
        </div> <!--container div-->

        <br />
        <ol class="breadcrumb">
            <li><a href="<c:url value="/" />">Edifice</a></li>
            <li role="menuitem"><a href="<c:url value="/volunteers" />">Volunteers</a></li>
            <li class="active">Edit</li>
        </ol>
        <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        <%@ include file="/WEB-INF/views/common/person-link-modal.jsp"%>
        <%@ include file="/WEB-INF/views/common/mustache-person-link-search-form.jsp"%>
        <!-- mustache template used to display the person selection form -->
        <script id="volunteer-person-search-form" type="text/html" charset="utf-8">
            {{#existingPersonId}}
            <p>You are already linked to {{existingPersonName}}</p>
            <p><a href="#" class="matched-person" data-person-id="{{existingPersonId}}">Leave linked to {{existingPersonName}} (same as ignore)</a></p>
            <p><a href="#" class="matched-person" data-person-id="">Unlink {{existingPersonName}} (create a new person)</a></p>
            {{/existingPersonId}}
            {{#matchedVolunteers}}
            <p>Edit an existing volunteer:</p>
            {{#volunteers}}
            <p><a href="<c:url value='/volunteers/{{personId}}'/>">{{forename}} {{surname}}{{#congregationName}}, {{congregationName}}{{/congregationName}}</a></p>
            {{/volunteers}}
            {{/matchedVolunteers}}
            {{#matchedPersons}}
            <p>Link to an existing person (not currently a volunteer):</p>
            {{#persons}}
            <a href="#" class="matched-person" data-person-id="{{personId}}">{{forename}} {{surname}}{{#congregationName}}, {{congregationName}}{{/congregationName}}</a>
            {{/persons}}
            {{/matchedPersons}}
        </script>
        <!-- paste mustache scripts here -->
        <script type="text/javascript" src="<c:url value='/javascript/thirdparty/jquery-numeric-1.3.1.js' />" ></script>
        <script type="text/javascript" src="<c:url value='/javascript/thirdparty/phoneformat-574.js' />" ></script>
        <script type="text/javascript" src="<c:url value='/javascript/volunteers.js' />" ></script>
    </body>
</html>
