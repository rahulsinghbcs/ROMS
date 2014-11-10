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
package uk.org.rbc1b.roms.db.project;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;

/**
 * Dao for project availability.
 *
 * @author ramindursingh
 */
public interface ProjectAvailabilityDao {

    /**
     * Get list of ones who have not been sent email.
     *
     * @return list
     */
    @Transactional(readOnly = true)
    List<ProjectAvailability> findUnnotifiedVolunteers();

    /**
     * Update volunteers who have been sent an email.
     *
     * @param projectAvailability the row
     */
    @Transactional(readOnly = false)
    void updateNotifiedVolunteers(ProjectAvailability projectAvailability);

    /**
     * Gets the list of volunteers who have been selected for dates to attend
     * who have not been notified.
     *
     * @return list
     */
    @Transactional(readOnly = true)
    List<ProjectAvailability> findUnconfirmedVolunteers();
}
