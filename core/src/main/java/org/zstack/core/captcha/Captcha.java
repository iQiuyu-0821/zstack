package org.zstack.core.captcha;

import org.zstack.header.core.Completion;
import org.zstack.header.core.ReturnValueCompletion;

/**
 * Created by kayo on 2018/7/5.
 */
public interface Captcha {
    int getAttemptsForCurrentResource(String resourceUuid);

    void increaseAttemptCount(String resourceUuid);

    void resetAttemptCount(String resourceUuid);

    void generateCaptcha(String targetResourceUuid, ReturnValueCompletion<CaptchaStruct> completion);

    void verifyCaptcha(String uuid, String verifyCode, Completion completion);

    void refreshCaptcha(String uuid, ReturnValueCompletion<CaptchaStruct> completion);

    CaptchaVO refreshCaptcha(String uuid);

    boolean verifyCaptcha(String uuid, String verifyCode);
}
