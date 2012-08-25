package uk.org.rbc1b.roms.db;
// Generated Apr 12, 2012 2:47:03 PM by Hibernate Tools 3.2.1.GA

/**
 * ProjectWorkStageId generated by hbm2java.
 */
public class ProjectWorkStageId implements java.io.Serializable {

    private String stageNumber;
    private String stageName;

    public String getStageNumber() {
        return this.stageNumber;
    }

    public void setStageNumber(String stageNumber) {
        this.stageNumber = stageNumber;
    }

    public String getStageName() {
        return this.stageName;
    }

    public void setStageName(String stageName) {
        this.stageName = stageName;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ProjectWorkStageId other = (ProjectWorkStageId) obj;
        if ((this.stageNumber == null) ? (other.stageNumber != null) : !this.stageNumber.equals(other.stageNumber)) {
            return false;
        }
        if ((this.stageName == null) ? (other.stageName != null) : !this.stageName.equals(other.stageName)) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 97 * hash + (this.stageNumber != null ? this.stageNumber.hashCode() : 0);
        hash = 97 * hash + (this.stageName != null ? this.stageName.hashCode() : 0);
        return hash;
    }
}
