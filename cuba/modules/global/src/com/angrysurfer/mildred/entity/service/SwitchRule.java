package com.angrysurfer.mildred.entity.service;

import javax.persistence.Entity;
import javax.persistence.Table;
import com.haulmont.chile.core.annotations.NamePattern;
import com.haulmont.cuba.core.global.DesignSupport;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import com.haulmont.cuba.core.entity.BaseIntIdentityIdEntity;
import com.haulmont.cuba.core.entity.annotation.Lookup;
import com.haulmont.cuba.core.entity.annotation.LookupType;

@DesignSupport("{'imported':true}")
@NamePattern("%s|name")
@Table(name = "switch_rule")
@Entity(name = "mildred$SwitchRule")
public class SwitchRule extends BaseIntIdentityIdEntity {
    private static final long serialVersionUID = 3851438778458761312L;

    @JoinTable(name = "service_profile_switch_rule_jn",
        joinColumns = @JoinColumn(name = "switch_rule_id"),
        inverseJoinColumns = @JoinColumn(name = "service_profile_id"))
    @ManyToMany
    protected List<ServiceProfile> serviceProfile;

    @Column(name = "name", nullable = false, length = 128)
    protected String name;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open", "clear"})
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "begin_mode_id")
    protected Mode beginMode;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open", "clear"})
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "end_mode_id")
    protected Mode endMode;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open", "clear"})
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "before_dispatch_id")
    protected ServiceDispatch beforeDispatch;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open", "clear"})
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "after_dispatch_id")
    protected ServiceDispatch afterDispatch;

    @Lookup(type = LookupType.DROPDOWN, actions = {"lookup", "open", "clear"})
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "condition_dispatch_id")
    protected ServiceDispatch conditionDispatch;

    public void setServiceProfile(List<ServiceProfile> serviceProfile) {
        this.serviceProfile = serviceProfile;
    }

    public List<ServiceProfile> getServiceProfile() {
        return serviceProfile;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setBeginMode(Mode beginMode) {
        this.beginMode = beginMode;
    }

    public Mode getBeginMode() {
        return beginMode;
    }

    public void setEndMode(Mode endMode) {
        this.endMode = endMode;
    }

    public Mode getEndMode() {
        return endMode;
    }

    public void setBeforeDispatch(ServiceDispatch beforeDispatch) {
        this.beforeDispatch = beforeDispatch;
    }

    public ServiceDispatch getBeforeDispatch() {
        return beforeDispatch;
    }

    public void setAfterDispatch(ServiceDispatch afterDispatch) {
        this.afterDispatch = afterDispatch;
    }

    public ServiceDispatch getAfterDispatch() {
        return afterDispatch;
    }

    public void setConditionDispatch(ServiceDispatch conditionDispatch) {
        this.conditionDispatch = conditionDispatch;
    }

    public ServiceDispatch getConditionDispatch() {
        return conditionDispatch;
    }


}