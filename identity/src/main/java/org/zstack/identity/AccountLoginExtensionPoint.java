package org.zstack.identity;

/**
 * Created by kayo on 2018/7/5.
 */
public interface AccountLoginExtensionPoint {
    void afterLogin(String accountUuid);

    void failedToLogin(String accountName);
}
