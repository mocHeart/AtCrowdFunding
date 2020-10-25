package com.moc.crowd.util;

import org.junit.Test;

public class CrowdUtilTest {

    @Test
    public void testMd5() {
        String source = "123123";
        String md5 = CrowdUtil.md5(source);
        System.out.println(md5);

    }

}