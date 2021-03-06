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
package uk.org.rbc1b.roms.db.application;

import java.io.Serializable;
import java.util.Date;
import org.hibernate.envers.Audited;
import uk.org.rbc1b.roms.db.UpdateAuditable;

/**
 * @author oliver.elder.esq
 */
@Audited
public class ApplicationAccess implements UpdateAuditable, Serializable {
    /**
     * Value set when the user has no access.
     */
    private static final long serialVersionUID = -6714506443989985762L;
    private Integer applicationAccessId;
    private Integer personId;
    private Application application;
    private char departmentAccess;
    private char nonDepartmentAccess;
    private Date updateTime;
    private Integer updatedBy;

    public Integer getApplicationAccessId() {
        return applicationAccessId;
    }

    public void setApplicationAccessId(Integer applicationAccessId) {
        this.applicationAccessId = applicationAccessId;
    }

    public Application getApplication() {
        return application;
    }

    public void setApplication(Application application) {
        this.application = application;
    }

    public char getDepartmentAccess() {
        return departmentAccess;
    }

    public void setDepartmentAccess(char departmentAccess) {
        this.departmentAccess = departmentAccess;
    }

    public char getNonDepartmentAccess() {
        return nonDepartmentAccess;
    }

    public void setNonDepartmentAccess(char nonDepartmentAccess) {
        this.nonDepartmentAccess = nonDepartmentAccess;
    }

    public Integer getPersonId() {
        return personId;
    }

    public void setPersonId(Integer personId) {
        this.personId = personId;
    }

    @Override
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public Integer getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(Integer updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Override
    public String toString() {
        return "ApplicationAccess{" + "applicationAccessId=" + applicationAccessId + '}';
    }
}
