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
package uk.org.rbc1b.roms.db.volunteer.qualification;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;

/**
 * Look up qualification information.
 *
 * @author Tina
 */
public interface QualificationDao {

    /**
     * Find the qualification matching id, or null if no match found.
     *
     * @param qualificationId qualification id
     * @return qualification
     *
     */
    @Transactional(readOnly = true)
    Qualification findQualification(Integer qualificationId);

    /**
     * Find all matching qualifications.
     *
     * @return list of matching qualifications
     */
    @Transactional(readOnly = true)
    List<Qualification> findQualifications();

    /**
     * Update an existing qualification.
     *
     * @param qualification a qualification to save
     */
    @Transactional
    void updateQualification(Qualification qualification);

    /**
     * Create a new qualification.
     *
     * @param qualification a qualification to save
     */
    @Transactional
    void createQualification(Qualification qualification);

}
