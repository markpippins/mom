package com.angrysurfer.mildred.entity.service;

import javax.persistence.Entity;
import javax.persistence.Table;
import com.haulmont.cuba.core.global.DesignSupport;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import com.haulmont.cuba.core.entity.BaseIntIdentityIdEntity;
import com.haulmont.cuba.core.entity.annotation.Lookup;
import com.haulmont.cuba.core.entity.annotation.LookupType;
import java.util.List;
import javax.persistence.OneToMany;
import com.haulmont.chile.core.annotations.Composition;

@DesignSupport("{'imported':true}")
@Table(name = "mode_state_default")
@Entity(name = "mildred$ModeStateDefault")
public class ModeStateDefault extends BaseIntIdentityIdEntity {
    private static final long serialVersionUID = -3770016726999216523L;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open"})
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "mode_id")
    protected Mode mode;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open"})
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "service_profile_id")
    protected ServiceProfile serviceProfile;

    @Composition
    @OneToMany(mappedBy = "modeStateDefault")
    protected List<ModeStateDefaultParam> params;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open"})
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "state_id")
    protected State state;

    @Column(name = "priority", nullable = false)
    protected Integer priority;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open"})
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "effect_dispatch_id")
    protected ServiceDispatch effectDispatch;

    @Column(name = "times_to_complete", nullable = false)
    protected Integer timesToComplete;

    @Column(name = "dec_priority_amount", nullable = false)
    protected Integer decPriorityAmount;

    @Column(name = "inc_priority_amount", nullable = false)
    protected Integer incPriorityAmount;

    @Column(name = "error_tolerance", nullable = false)
    protected Integer errorTolerance;

    public void setServiceProfile(ServiceProfile serviceProfile) {
        this.serviceProfile = serviceProfile;
    }

    public ServiceProfile getServiceProfile() {
        return serviceProfile;
    }


    public void setParams(List<ModeStateDefaultParam> params) {
        this.params = params;
    }

    public List<ModeStateDefaultParam> getParams() {
        return params;
    }


    public void setMode(Mode mode) {
        this.mode = mode;
    }

    public Mode getMode() {
        return mode;
    }

    public void setState(State state) {
        this.state = state;
    }

    public State getState() {
        return state;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setEffectDispatch(ServiceDispatch effectDispatch) {
        this.effectDispatch = effectDispatch;
    }

    public ServiceDispatch getEffectDispatch() {
        return effectDispatch;
    }

    public void setTimesToComplete(Integer timesToComplete) {
        this.timesToComplete = timesToComplete;
    }

    public Integer getTimesToComplete() {
        return timesToComplete;
    }

    public void setDecPriorityAmount(Integer decPriorityAmount) {
        this.decPriorityAmount = decPriorityAmount;
    }

    public Integer getDecPriorityAmount() {
        return decPriorityAmount;
    }

    public void setIncPriorityAmount(Integer incPriorityAmount) {
        this.incPriorityAmount = incPriorityAmount;
    }

    public Integer getIncPriorityAmount() {
        return incPriorityAmount;
    }

    public void setErrorTolerance(Integer errorTolerance) {
        this.errorTolerance = errorTolerance;
    }

    public Integer getErrorTolerance() {
        return errorTolerance;
    }


}