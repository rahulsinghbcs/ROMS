/*
 * The MIT License
 *
 * Copyright 2014 RBC1B.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package uk.org.rbc1b.roms.controller.volunteer.update;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;
import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import uk.org.rbc1b.roms.controller.common.DataConverterUtil;
import uk.org.rbc1b.roms.db.email.Email;
import uk.org.rbc1b.roms.db.email.EmailDao;
import uk.org.rbc1b.roms.db.volunteer.Volunteer;
import uk.org.rbc1b.roms.db.volunteer.VolunteerDao;

/**
 * Controller for checking and accepting requests to update contact details.
 *
 */
@Controller
@RequestMapping("/update-contact")
public class UpdateRequestController {

    private static final Logger LOGGER = LoggerFactory.getLogger(UpdateRequestController.class);
    private static final String BASE_URI = "/update-contact";
    private static final String UPDATE_REQUEST_TEMPLATE = "volunteer-contact-update-request.ftl";
    private static final String SUBJECT = "RBC (London & Home Counties) Volunteer Information Update";
    private static final int HTTPS_PORT = 443;
    private static final String EMAIL_PATTERN =
            "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
            + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
    @Autowired
    private VolunteerDao volunteerDao;
    @Autowired
    private EmailDao emailDao;
    @Autowired
    private FreeMarkerConfigurer emailFreemarkerConfigurer;
    @Autowired
    private ContactUpdateModelFactory contactUpdateModelFactory;

    /**
     * Accepts and checks requests for updating contact.
     *
     * @param requestForm the user form
     * @param response the http response to set
     * @param request the http request
     */
    @RequestMapping(method = RequestMethod.POST)
    public void acceptRequest(@Valid RequestForm requestForm,
            HttpServletResponse response, HttpServletRequest request) {
        LOGGER.error("UpdateRequestController:" + requestForm.getPersonId() + requestForm.getBirthDate());
        Volunteer volunteer = volunteerDao.findVolunteerById(requestForm.getPersonId());
        Date birthDate = DataConverterUtil.toSqlDate(requestForm.getBirthDate());
        if (volunteer == null) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        } else if (volunteer.getPerson().getBirthDate().compareTo(birthDate) != 0) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        } else if (!checkEmail(volunteer)) {
            response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
        } else {
            String uri = getSecureUri(request, volunteer);
            try {
                prepareEmail(volunteer, uri);
                response.setStatus(HttpServletResponse.SC_OK);
            } catch (IOException e) {
                response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
            } catch (TemplateException e) {
                response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
            }
        }
    }

    /**
     * Handles the request to update contact.
     *
     * @param personId the person id
     * @param datetime the datetime of the email
     * @param hash the hash
     * @param model the mvc model
     * @return contact update form
     */
    @RequestMapping(value = "/{personId}/{datetime}/{hash}/update", method = RequestMethod.GET)
    public String showVolunteerContact(@PathVariable Integer personId,
            @PathVariable String datetime, @PathVariable String hash, ModelMap model) {
        LOGGER.error("UpdateRequestController: Update for " + personId + ", " + datetime + ", " + hash);
        String uri = BASE_URI + "/" + personId + "/" + datetime + "/" + hash;
        Volunteer volunteer = volunteerDao.findVolunteerById(personId);
        if (volunteer == null) {
            return "update/contact-update-incorrect";
        }
        if (checkWithinTime(datetime) && checkHash(volunteer, datetime, hash)) {
            ContactUpdateForm contactUpdateModel = contactUpdateModelFactory.generateContactUpdateModel(volunteer, datetime, hash);
            LOGGER.error("Contact Update Request submitted for:" + contactUpdateModel.getSurname()
                    + ", " + contactUpdateModel.getForename() + ":" + contactUpdateModel.getPersonId());
            model.addAttribute("contactUpdateModel", contactUpdateModel);
            model.addAttribute("submitUrl", uri);
            model.addAttribute("submitMethod", "POST");
            return "update/contact-update";
        } else {
            return "update/contact-update-incorrect";
        }
    }

    /**
     * Handles update requests.
     *
     * @param personId the person Id
     * @param datetime the date and time of the original request
     * @param hash the hash
     * @param response the HTTP response
     * @param updateForm the updated contact form
     */
    @RequestMapping(value = "/{personId}/{datetime}/{hash}", method = RequestMethod.POST)
    public void acceptUpdate(@PathVariable Integer personId,
            @PathVariable String datetime, @PathVariable String hash, HttpServletResponse response, @Valid ContactUpdateForm updateForm) {
        LOGGER.error("UpdateRequestController: Contact Update Form for " + personId);
        Volunteer volunteer = volunteerDao.findVolunteerById(personId);
        if (volunteer == null) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        } else {
            if (checkWithinTime(datetime) && checkHash(volunteer, datetime, hash)) {
                LOGGER.error(updateForm.getForename() + " " + updateForm.getSurname());
            } else {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            }
        }
    }

    /**
     * Checks if the update request is within 24 hours of the email.
     *
     * @param datetime when the original request was sent
     * @return true or false if within 24 hours
     */
    private boolean checkWithinTime(String datetime) {
        DateTime now = new DateTime();
        return true;
    }

    /**
     * Checks that the hash is correct for the given volunteer
     *
     * @param volunteer who wants to update his information
     * @param datetime of the original request in email
     * @param hash of the request
     * @return true or false if correct
     */
    private boolean checkHash(Volunteer volunteer, String datetime, String hash) {
        return true;
    }

    /**
     * Checks for valid email. Later, we can add further email validation, etc.
     *
     * @param volunteer the volunteer to check
     * @return boolean if valid email or not
     */
    private boolean checkEmail(Volunteer volunteer) {
        if (volunteer.getPerson().getEmail() == null) {
            return false;
        }
        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        Matcher matcher = pattern.matcher(volunteer.getPerson().getEmail());
        return matcher.matches();
    }

    /**
     * Prepares an email to send to the volunteer.
     *
     * @param volunteer the volunteer to send
     * @param uri the URI
     * @throws exception for IO and template
     */
    private void prepareEmail(Volunteer volunteer, String uri) throws IOException, TemplateException {
        Configuration conf = emailFreemarkerConfigurer.getConfiguration();
        Map<String, String> model = new HashMap<String, String>();
        model.put("forename", volunteer.getPerson().getForename());
        model.put("httpsurl", uri);
        String text = FreeMarkerTemplateUtils.processTemplateIntoString(conf.getTemplate(UPDATE_REQUEST_TEMPLATE), model);
        Email email = new Email();
        email.setRecipient(volunteer.getPerson().getEmail());
        email.setSubject(SUBJECT);
        email.setText(text);
        emailDao.save(email);
    }

    /**
     * Gets the secure URI for a given volunteer
     *
     * @param request the https request
     * @param volunteer the volunteer
     * @return uri string
     */
    private String getSecureUri(HttpServletRequest request, Volunteer volunteer) {
        String uri;
        if (request.isSecure()) {
            uri = "https://";
        } else {
            uri = "http://";
        }
        uri = uri + request.getServerName();
        if (request.getServerPort() != HTTPS_PORT) {
            uri = uri + ":" + request.getServerPort();
        }
        uri = uri + request.getRequestURI() + "/"
                + volunteer.getPersonId() + "/";
        String datetime = getCurrentDateTime();
        uri = uri + datetime + "/";
        String token = getSecureToken(volunteer, datetime);
        uri = uri + token + "/update";
        return uri;
    }

    /**
     * Method that simply gets the current datetime.
     *
     * @return string representation of current date and time
     */
    private String getCurrentDateTime() {
        DateTime datetime = new DateTime();
        return datetime.toString("yyyyMMddHHmm");
    }

    /**
     * Gets the secure token.
     *
     * @param volunteer the volunteer
     * @param datetime for the current date time
     * @return token string
     */
    private String getSecureToken(Volunteer volunteer, String datetime) {
        String salt = System.getProperty("uk.org.rbc1b.roms.security.salt");
        if (salt == null) {
            salt = "Not Set";
            LOGGER.error("UpdateRequestController: System salt not set");
        }
        String text = datetime + ":" + volunteer.getPersonId()
                + volunteer.getPerson().getBirthDate().toString();
        ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
        return encoder.encodePassword(salt, text);
    }
}
