package com.angrysurfer.mildred.entity.elastic;

import javax.persistence.Entity;
import javax.persistence.Table;
import com.haulmont.chile.core.annotations.NamePattern;
import com.haulmont.cuba.core.global.DesignSupport;
import javax.persistence.Column;
import com.haulmont.cuba.core.entity.BaseIntIdentityIdEntity;

@DesignSupport("{'imported':true}")
@NamePattern("%s|name")
@Table(name = "query_type")
@Entity(name = "mildred$QueryType")
public class QueryType extends BaseIntIdentityIdEntity {
    private static final long serialVersionUID = -6091710891841670641L;

    @Column(name = "`desc`")
    protected String desc;

    @Column(name = "name", length = 25)
    protected String name;

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getDesc() {
        return desc;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }


}