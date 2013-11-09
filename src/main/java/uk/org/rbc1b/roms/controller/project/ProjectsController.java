/*
 * The MIT License
 *
 * Copyright 2013 RBC1B.
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
package uk.org.rbc1b.roms.controller.project;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.validation.Valid;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.multiaction.NoSuchRequestHandlingMethodException;
import uk.org.rbc1b.roms.controller.common.DataConverterUtil;
import uk.org.rbc1b.roms.db.PersonDao;
import uk.org.rbc1b.roms.db.kingdomhall.KingdomHallDao;
import uk.org.rbc1b.roms.db.project.Project;
import uk.org.rbc1b.roms.db.project.ProjectDao;
import uk.org.rbc1b.roms.db.project.ProjectStage;
import uk.org.rbc1b.roms.db.project.ProjectStageActivity;
import uk.org.rbc1b.roms.db.project.ProjectStageActivityType;
import uk.org.rbc1b.roms.db.project.ProjectStageType;
import uk.org.rbc1b.roms.db.project.ProjectStageTypeActivityType;
import uk.org.rbc1b.roms.db.project.ProjectTypeStageType;
import uk.org.rbc1b.roms.db.reference.ReferenceDao;
import uk.org.rbc1b.roms.security.ROMSUserDetails;

/**
 * Control access to the underlying person data.
 * @author oliver
 */
@Controller
@RequestMapping("/projects")
public class ProjectsController {
    private static final String CREATED_STATUS_CODE = "CR";

    @Autowired
    private KingdomHallDao kingdomHallDao;
    @Autowired
    private PersonDao personDao;
    @Autowired
    private ProjectDao projectDao;
    @Autowired
    private ReferenceDao referenceDao;
    @Autowired
    private ProjectModelFactory projectModelFactory;

    /**
     * Display the list of projects.
     * @param model mvc model
     * @return view
     */
    @RequestMapping(method = RequestMethod.GET)
    public String showProjectList(ModelMap model) {

        List<Project> projects = projectDao.findProjects();
        Map<Integer, String> types = referenceDao.findProjectTypeValues();
        Map<String, String> statuses = referenceDao.findProjectStatusValues();
        List<ProjectListModel> modelList = new ArrayList<ProjectListModel>(projects.size());
        for (Project project : projects) {
            modelList.add(projectModelFactory.generateProjectListModel(project, types, statuses));
        }

        model.addAttribute("projects", modelList);
        model.addAttribute("newUri", ProjectModelFactory.generateUri(null) + "/new");

        return "projects/list";
    }

    /**
     * Look up a project id by name.
     * @param name project name
     * @return matched project id
     */
    @RequestMapping(value = "search", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Integer findProjectIdByName(@RequestParam("name") String name) {
        Project project = projectDao.findProject(name);

        return project != null ? project.getProjectId() : null;
    }

    /**
     * @param projectId project primary key
     * @param model model
     * @return view name
     * @throws NoSuchRequestHandlingMethodException when no project matching the id is found
     */
    @RequestMapping(value = "{projectId}", method = RequestMethod.GET)
    public String showProject(@PathVariable Integer projectId, ModelMap model)
            throws NoSuchRequestHandlingMethodException {

        Project project = projectDao.findProject(projectId);
        if (project == null) {
            throw new NoSuchRequestHandlingMethodException("No project with id [" + projectId + "]", this.getClass());
        }

        ProjectModel projectModel = projectModelFactory.generateProjectModel(project);
        projectModel.setStages(projectModelFactory.generateProjectStages(projectDao.findProjectStages(projectId)));

        model.addAttribute("project", projectModel);

        return "projects/show";
    }

    /**
     * Reorder the project stages by passing in the new stage id order.
     * @param projectId project to reorder
     * @param stageIdValues comma separated list of the stage ids, in the format stage-1, stage-3, stage-17
     */
    @RequestMapping(value = "{projectId}/stage-order", method = RequestMethod.PUT, consumes = "application/x-www-form-urlencoded")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void reorderStages(@PathVariable Integer projectId, @RequestParam("stageIdValues") String stageIdValues) {

        String[] stageIdValueArray = StringUtils.split(stageIdValues, ',');
        List<Integer> stageIds = new ArrayList<Integer>();
        for (String stageIdValue : stageIdValueArray) {
            Integer stageId = DataConverterUtil.toInteger(stageIdValue.replaceAll("stage\\-", ""));
            stageIds.add(stageId);
        }

        projectDao.updateProjectStageOrder(projectId, stageIds);
    }

    /**
     * Display the form to create a new project.
     *
     * @param model mvc model
     * @return view name
     */
    @RequestMapping(value = "new", method = RequestMethod.GET)
    public String showCreateProjectForm(ModelMap model) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        ROMSUserDetails user = (ROMSUserDetails) authentication.getPrincipal();

        // initialise the form bean
        ProjectForm form = new ProjectForm();
        form.setCoordinatorUserId(user.getUserId());
        form.setCoordinatorUserName(user.getUsername());

        model.addAttribute("projectForm", form);
        model.addAttribute("projectTypeValues", referenceDao.findProjectTypeValues());
        model.addAttribute("submitUri", ProjectModelFactory.generateUri(null));
        model.addAttribute("submitMethod", "POST");

        return "projects/create";
    }

    /**
     * Creates a project, creating the default stages and activities for the type.
     * @param projectForm projectForm bean
     * @return view name
     */
    @RequestMapping(method = RequestMethod.POST)
    public String createProject(@Valid ProjectForm projectForm) {

        Project project = new Project();
        project.setConstraints(projectForm.getConstraints());

        if (projectForm.getCoordinatorUserId() != null) {
            project.setCoordinator(personDao.findPerson(projectForm.getCoordinatorUserId()));
        }

        project.setEstimateCost(projectForm.getEstimateCost());

        if (projectForm.getKingdomHallId() != null) {
            project.setKingdomHall(kingdomHallDao.findKingdomHall(projectForm.getKingdomHallId()));
        }
        project.setName(projectForm.getName());
        project.setPriority(projectForm.getPriority());
        project.setProjectTypeId(projectForm.getProjectTypeId());
        project.setRequestDate(DataConverterUtil.toDate(projectForm.getRequestDate()));
        project.setStatusCode(CREATED_STATUS_CODE);
        project.setSupportingCongregation(projectForm.getSupportingCongregation());
        project.setVisitDate(DataConverterUtil.toDate(projectForm.getVisitDate()));

        Map<Integer, ProjectStageType> stageTypes = projectDao.findProjectStageTypes();
        Map<Integer, ProjectStageActivityType> activityTypes = projectDao.findProjectStageActivityTypes();
        List<ProjectTypeStageType> projectTypeStageTypes = projectDao.findProjectTypeStageTypes(projectForm
                .getProjectTypeId());

        Set<ProjectStage> stages = new HashSet<ProjectStage>();
        for (ProjectTypeStageType projectTypeStageType : projectTypeStageTypes) {
            ProjectStage stage = new ProjectStage();
            stage.setProjectStageType(stageTypes.get(projectTypeStageType.getProjectStageTypeId()));
            stage.setStatusCode(CREATED_STATUS_CODE);

            List<ProjectStageTypeActivityType> stageTypeActivityTypes = projectDao
                    .findProjectStageTypeActivityType(projectTypeStageType.getProjectStageTypeId());
            Set<ProjectStageActivity> activities = new HashSet<ProjectStageActivity>();
            for (ProjectStageTypeActivityType stageTypeActivityType : stageTypeActivityTypes) {
                ProjectStageActivity activity = new ProjectStageActivity();
                activity.setStatusCode(CREATED_STATUS_CODE);
                activity.setProjectStageActivityType(activityTypes.get(stageTypeActivityType
                        .getProjectStageActivityTypeId()));
            }
            stage.setActivities(activities);

            stages.add(stage);
        }
        project.setStages(stages);

        projectDao.createProject(project);

        return "redirect:" + ProjectModelFactory.generateUri(project.getProjectId());

    }

}
