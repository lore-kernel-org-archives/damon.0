Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C239D6C8
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774592798; cv=none; b=h4NPho4GStOSN1v9RfrJRk42X9xrTOJH97bOwj9iZGC7x1pdT7VhDx4XnAghxNPZueVM4Gs4A0jRAi6knlClsJeFT25oE18ORBgwluuTEEwP49/H8W2CP0gAJj91ymVObdn3uMA07PeABTG37ulYGNMBJxn2glmLnjyEeb26vnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774592798; c=relaxed/simple;
	bh=S3rNCZOCe8f88ItUnqifha1d29xLwN/zuDv9CDO/+dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhTTD3C5dsCefh7XIRPg3V0Yvo25NqnFTV760g6T+OS80f713alAql57ZEruyovkQB6HcHCE3fFdS09mUh3LWFiBLp7SqOkCQu4ecsNAmZvOJsY3Z+DfuzV070ZdRa+t20zVGP7J93wjMcY+RKEhQUbrVvW1C4dgC+qE9A07NpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGn8VUov; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGn8VUov"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso237935a91.1
        for <damon@lists.linux.dev>; Thu, 26 Mar 2026 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774592794; x=1775197594; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfeL5siJ6xe6Uo5hQEXOS6s+/4tbof4Lxqs1l9wyAMQ=;
        b=aGn8VUovXSq46mYoUFK6Yo0WAJIWFc5x6szhiqNhh1I8beU7kZeHGqMejqNjyR8QZT
         lruwEYt5Md4YlbNmzNvO7HmB1gFGhi4KvwCJBoUhuxbugNfOBtyZKD8HFznKhYlkkoM8
         4ffyoew3WorGSD3RzW1ZFJfX50btEcEweuxYhBjBahzRTuHBakn3vn4xM2iO7nQ0KWwr
         ZvgoqWDCyMC9lxL1TC+6o45Vs+JjtFV/WHVxp92vkXKSdCOyGFOaLVlP3lU7eaR9YQRN
         5+9Lf5oCt0Ig03WxPAuiRXekkIhu+Fg2l86xBBD6y0bv6WPpt5XWLPzL+aH3AdnUTt4x
         B1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774592794; x=1775197594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfeL5siJ6xe6Uo5hQEXOS6s+/4tbof4Lxqs1l9wyAMQ=;
        b=L/V3esImnbxTSXLMcrybGRhsccFaSi7pu3UeUdUlGTW9VUFyAntH3fincPHhSVpFm5
         d393OQ4nLJYDH1aUopB98QydLRJm/IFHZ3HDJMJxNNydamIFuOH5PaaqeicRSPPVf2I4
         PaWZgYp9hlsnOlg5EFBIxMEznE3tHZbbUADtCyGyoxwkqKRtZRdy8s9jKudAW8h3bRX1
         ImHuAirl5ubrqIQM9kjvSmD8U3Xablfcc9fdvoTqN79fuBEyeq97ze6pVpcJx1cqnf0d
         EY7jjNFp4Q33Mvco6e1mnxsU8SqFKYXj4+t3yPgGkcQcCfQYFM+epRwF9yDQWKu9FBLu
         /nQA==
X-Gm-Message-State: AOJu0YwrqbeXLCvWO+XnV3JBBzLgXvEoGCZd+nuz7EEDP7MhWZxcXexJ
	rqFo5+vMhr44sMweUB9pgBpFa9hrzWWmgaHxEQeVacTHDwN4F/9wW0L5V9zP9Q==
X-Gm-Gg: ATEYQzx77Q6HOJKxCh9TiP1bznYsyIOqd8txbydTg4I23/I0Ld03gz4aDLuT1Q6Er5y
	sPIiVQrjdccPaEJjp6XeF+xppespBIL/Bs147WrArOzyLx1Aztx2UsAabGT7vXMBQJWTBz2H9iB
	Y0ofsE15AU2D9AUn58++RQpnmST7iKxx1edmI9om/IsmJ+ARkOL5DgL9s26eqcZdEiOLGpxk6Qc
	eDaVeI1Qf2RZYtrW+w4CAdIgwBm8u71aOFTIh+fv7IL0946yV9DeBNGjKdzbLlO7ism2p2f43Vv
	Y3C1q12649EQyaz9Y4BA2Nwj4ipLP9czXp8s1wONWL+EHJZG/DJUvm/DwJg1PGv5rgfk2ZH8KmO
	Zy/C4p6KDij4O851jOKQ64WBySithakFKoAN7SfscVWS6TP3a8xkJ0c2M9N+3IUh0Vxl6J7jje2
	S5juieDDJibjcW+ieEuTSc2NKnuJSQhQwtwQqmFg==
X-Received: by 2002:a17:90b:3ec5:b0:359:9016:1e72 with SMTP id 98e67ed59e1d1-35c30076ea8mr1429306a91.19.1774592794262;
        Thu, 26 Mar 2026 23:26:34 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a4ee7esm3533241a91.1.2026.03.26.23.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:26:33 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Fri, 27 Mar 2026 14:26:27 +0800
Message-ID: <20260327062627.66426-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
The 'addr_unit' must be a power of 2 for correct address alignment
calculations. Previously, writing a non-power-of-2 value
(e.g., addr_unit=3) would be accepted by the sysfs store callback, but
cause kdamond to exit unexpectedly during parameter application, failing
silently without returning an error to userspace.

Solution
========
Add an is_power_of_2() check in damon_commit_ctx() to reject invalid
inputs immediately with -EINVAL. 

When damon_commit_ctx() fails, the kdamond thread terminates as
designed.

The issue is found by sashiko [1].

[1] https://lore.kernel.org/20260325025317.86571-1-sj@kernel.org

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index db6c67e52d2b..6bad85a47a79 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1330,6 +1330,8 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	dst->maybe_corrupted = true;
 	if (!is_power_of_2(src->min_region_sz))
 		return -EINVAL;
+	if (!src->addr_unit || !is_power_of_2(src->addr_unit))
+		return -EINVAL;
 
 	err = damon_commit_schemes(dst, src);
 	if (err)
-- 
2.53.0

