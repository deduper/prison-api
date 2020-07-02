package net.syscon.elite.repository.jpa.model;

import lombok.NoArgsConstructor;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue(NonAssociationType.DOMAIN)
@NoArgsConstructor
public class NonAssociationType extends ReferenceCode {

    static final String DOMAIN = "NON_ASSO_TYP";

    public NonAssociationType(final String code, final String description) {
        super(DOMAIN, code, description);
    }
}
