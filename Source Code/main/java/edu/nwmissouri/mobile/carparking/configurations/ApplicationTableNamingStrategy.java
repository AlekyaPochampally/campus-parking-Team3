package edu.nwmissouri.mobile.carparking.configurations;

import org.hibernate.boot.model.naming.Identifier;
import org.hibernate.engine.jdbc.env.spi.JdbcEnvironment;
import org.springframework.boot.orm.jpa.hibernate.SpringPhysicalNamingStrategy;

public class ApplicationTableNamingStrategy extends SpringPhysicalNamingStrategy {

    @Override
    public Identifier toPhysicalTableName(Identifier name, JdbcEnvironment jdbcEnvironment) {
        String tableName = super.toPhysicalTableName(name, jdbcEnvironment).getText();
        tableName = tableName.toUpperCase();
        return Identifier.toIdentifier(String.format("CP_%s", tableName));
    }

}
