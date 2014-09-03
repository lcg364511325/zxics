//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088511258600473"
//收款支付宝账号
#define SellerID  @"jiahao123@wiss.com.cn"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"1tqiswt2h1n3vjzzgbrleih00df6xthf"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAL6EakvPmpxSCv15HP7mPQgTqkJxljCkyCcjSPMLVNoyhamcPbqFAHsOQzuxyqBs0CASzeqYTqrjR5neTq7NvucfBMnAcn46p169nIakVaE2/SFXmsrf8/sSLSJc3316wyIitxlbBf7XBYSJYwjjxGOQRodBRvCAjvAEJxJtejx5AgMBAAECgYEAqdA/KsmmBvW95AaDCNTRy5QzqzuxYjROT0xNJo2QGVj0+KRSBSGttwGUfe3QLUQwEpaQQi112S3yUTzspzSulagODL8wGyynVNHL5VjOskC/0/K7yrjnwLkXWYxvngLrGQzxF6Fma2n2TMtMehNEaFaEjLQQgCIK68gnvZ4FUU0CQQD9X7epGzxlfs35hF+5Djt3rHFZkUNgaWDZgW2KvOR9csKTBccqM94mkAEy9wMo8kUP8fGijYX+931nOpc46OevAkEAwH3rOghpQhKrNGVAaJptRAB5AgEkyQCKL8zkR3hCVm9IYeZjzTL1W8UL6v+d5veicHHPWN8qXM0BmBDTaESAVwJBAPeQKIFgjTiWF2bvAiBsWYpqwS3Ek1KGZAzhO0jNm2s/UAIbKSiBGVQQbDuBwmKlpPkZawFqyjv/UVYll1ARsR0CQCNVed5XOOsV/jNJ+r64yiHXbF7/0r7KyJLpq2WrH5I6LzE5V0yNdBh6XSuv7E4/WqQFYChSHraWMxq0y/mxyVUCQQDFExF4bKFq8nYqlI7VDL64wYQfU1ylGiOYpwnKl+z+Lp2HAl8zfyLx9kIIF1bTXW0JuiKCj9qmlPvTjexIQ1Kz"


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC+hGpLz5qcUgr9eRz+5j0IE6pCcZYwpMgnI0jzC1TaMoWpnD26hQB7DkM7scqgbNAgEs3qmE6q40eZ3k6uzb7nHwTJwHJ+OqdevZyGpFWhNv0hV5rK3/P7Ei0iXN99esMiIrcZWwX+1wWEiWMI48RjkEaHQUbwgI7wBCcSbXo8eQIDAQAB"

#endif
