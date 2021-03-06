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
package uk.org.rbc1b.roms.db.common;

import org.apache.commons.lang3.StringUtils;
import uk.org.rbc1b.roms.controller.common.SortDirection;

/**
 * Base criteria used for search requests.
 */
public abstract class AbstractSearchCriteria implements SearchCriteria, Cloneable {
    private static final int DEFAULT_MAX_RESULTS = 10;
    private static final int DEFAULT_START_INDEX = 0;
    private Integer maxResults = DEFAULT_MAX_RESULTS;
    private String search;
    private Integer startIndex = DEFAULT_START_INDEX;
    private SortDirection sortDirection;
    private String sortValue;

    /**
     * @return true if the result is being filtered
     */
    public boolean isFiltered() {
        return StringUtils.isNotBlank(search);
    }

    /**
     * Clear any filtered values.
     */
    public void clearFilter() {
        search = null;
    }

    public Integer getMaxResults() {
        return maxResults;
    }

    @Override
    public void setMaxResults(Integer maxResults) {
        this.maxResults = maxResults;
    }

    public String getSearch() {
        return search;
    }

    @Override
    public void setSearch(String search) {
        this.search = search;
    }

    public Integer getStartIndex() {
        return startIndex;
    }

    @Override
    public void setStartIndex(Integer startIndex) {
        this.startIndex = startIndex;
    }

    public SortDirection getSortDirection() {
        return sortDirection;
    }

    @Override
    public void setSortDirection(SortDirection sortDirection) {
        this.sortDirection = sortDirection;
    }

    public String getSortValue() {
        return sortValue;
    }

    @Override
    public void setSortValue(String sortValue) {
        this.sortValue = sortValue;
    }

}
