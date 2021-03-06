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

import java.util.List;
import org.springframework.transaction.annotation.Transactional;

/**
 * Look up application user information.
 *
 * @author oliver.elder.esq
 */
public interface UserDao {

    /**
     * Look up the user by name.
     *
     * @param userName user name
     * @return user
     */
    @Transactional(readOnly = true)
    User findUser(String userName);

    /**
     * Look up the user by name. We do a prefix match on the name.
     *
     * @param userName user name
     * @return users
     */
    @Transactional(readOnly = true)
    List<User> findUsersByUserNamePrefix(String userName);

    /**
     * Look up the user by id.
     *
     * @param userId user id
     * @return user
     */
    @Transactional(readOnly = true)
    User findUser(Integer userId);

    /**
     * Find all users on the system.
     *
     * @return users
     */
    @Transactional(readOnly = true)
    List<User> findAllUsers();

    /**
     * Updates a user.
     *
     * @param user the user to update
     */
    @Transactional
    void updateUser(User user);

    /**
     * Adds a new user.
     *
     * @param user the user to create
     */
    @Transactional
    void createUser(User user);
}
