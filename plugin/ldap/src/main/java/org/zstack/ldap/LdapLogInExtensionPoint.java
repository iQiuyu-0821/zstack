package org.zstack.ldap;

/**
 * Created by kayo on 2018/7/6.
 */
public interface LdapLogInExtensionPoint {
    void beforeLogin(APILogInByLdapMsg msg, String dn);

    void afterLogin(String dn);

    void failedToLogin(String dn);
}
