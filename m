Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE3277C8D
	for <damon@lists.linux.dev>; Wed, 10 Dec 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345649; cv=none; b=Pp+rz8uP3y4FVq/6sxdwyU6m8QA9CroQR+6a7QwTtjCqp/d1+B3DHWwOEw0GuXeRpBRzM+gZB9HCuBCPjX2O5OXYQKf1U6s6mujpOCNnP+6tSNvm6QYjS0dalwKCDZx/vctGRWIru43IXqv5Z0a2rDAviINDTGvvPMLpOYzIDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345649; c=relaxed/simple;
	bh=iXyaFAhfE/nAYuhTqSDEgou2JXUnvr/ADdInEDndNn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbOVgj2dlyf/oxET/Gr14+49NTqCblzZc/wEi0d8H68DJErVMUYmXYMAfUpyrnoKMIv5PQ26Eav44mhwkKNQa17QiV0xMLEu+LQLXBmELjR79NyKAXCZ/e+cNmnCP/PCgJXqgU7IfZIY6gz/qanae/buZj+JtBJXRwFM6ZRvzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQfL4CDG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQfL4CDG"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so7788010b3a.0
        for <damon@lists.linux.dev>; Tue, 09 Dec 2025 21:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765345647; x=1765950447; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjPKi0vMLz/w6qpgbXNP/kuhIoVt0nM5db2+kyo0mvU=;
        b=ZQfL4CDGepaiFq9yIxhNCngAgkjER9KFjK6VAqz8bHHv3ymVBw6fNy8/riEN6207yV
         bZ2FB20FWCAoPo1+1NF0fXBNyTXpr5nAJqGGoMGR9JnuBQE1kH6a8r8ohJS4jLzm92L8
         qgF4z9czsNEh4iiPel66Wi0Xz85iZNdGVrGkvOGDOtidis5XKi+84ENVquib7K0+EhNr
         dLRxBWxAVgiHMHm2/DGuA7C0/beRvpWIfIHEUWrBLdnsB8vawOst1MHSET8funacv1NF
         gB6TvPlBr/pPAofWEDMvJ7nxQryXdp6/jTm361H2XQUD42kKbgGJZRnrtuYm0ZXMJe2f
         4ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765345647; x=1765950447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjPKi0vMLz/w6qpgbXNP/kuhIoVt0nM5db2+kyo0mvU=;
        b=ekfpMgZQ0f6dABsA9tq4/xbZeXsp0v8YSLV9mBWG7CBiejClr5bfI23jG/c+lucbT2
         5gd/aUtGOBp7QmWh6t88YLagb0xfk2zK3+Y51iQfbIGdaQlhqXaFAK0UWAS9iulRDg6u
         66mxTBbZeAP0iZzijq9c47yf51kYd5mHMiEPAdiWvc8bT94WhtOixZvz90C0vJgHt8aS
         mb4ZeftftX+ugi0R1psIpcYLabf4LIwu5FjmdkNoOTYJJLmM7YAtBcjajdNoK/Tx5blm
         ISeHcLex2p2HETKYS9SXsl+JINkl9pTVV4kgLRO63JMC/1OrkPqHc4MthRI5gnEAiqAd
         NfOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTIRHBPeMPjlskPKZ52EMxoxuVGL3nCUoVHT9HBzEJsyOfeF7uxwNI7g/S5Bjgzh2r9OARkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcH6Q1j1n5g2C2J61SqlGHIfJX50SEddLrs8CDcIj5UfKUZdh/
	Cx9kMkkVizJEEEJPA6ViKp7yO2Ia9jPUTWz6R7Yie/xA924LEW00dYkY
X-Gm-Gg: ASbGncvBSzwU1btcLuAR0i/CtVF/i4fqoj/+uElGmkPlakrfmsN5s5agqIyDGgH9mia
	R8EAc/Pk4uD//QiBY3Vh7Oe2zUq8aHdde16zZzr4jx05QHCvsyHpBNMD8lWSS9GhU1lohPMGf+b
	NGzMvvEpbnVfXY3FYXqXvWXaOTOF19X+81UTib5BYR1PCkxzuW6ZDuAreLBiSl6ny1jduZhTVDn
	5BSHz1Ef1BHY1cofO5/mbAtrGloTBK7E4KIiuq2ql36sA29+YhLpGSiz0IhCXz3xDVSqADhErr0
	VEyNgJs2aaG8zNWXDGhrJntGUTvmWsQV8CGolBZGOb9FvneW2neQ3956yS/EuuWDAa8xcWq4FxS
	bi/W1+/TodSDjodfgfdskC+n7XRLzrsQBOrqi38eoCIsA/kaH5OQmYh8xMbToNhib1z/5I0P8UO
	E+ND8T9NB4EYLpReFU3bKEXZzurgqA5w==
X-Google-Smtp-Source: AGHT+IEwc7JOsazcwKpzU7ZHBl+xfNwWtdPzPxJDIDg8Q6HfKB4pbwai0Nw0QrSKvHi5o+uJJlmImg==
X-Received: by 2002:a05:6a00:cd2:b0:7f0:2d21:878e with SMTP id d2e1a72fcca58-7f22e0a14admr1193730b3a.25.1765345647036;
        Tue, 09 Dec 2025 21:47:27 -0800 (PST)
Received: from LilGuy ([2409:40c2:1295:13e8:41e8:60cd:6181:4fad])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7e29f3e52c8sm17808011b3a.10.2025.12.09.21.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 21:47:26 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] mm/damon/sysfs: check for online node in target_nid_store
Date: Wed, 10 Dec 2025 11:17:07 +0000
Message-ID: <20251210111708.46959-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'target_nid_store' function previously accepted any integer value
written to the 'target_nid' sysfs file without validation. This allowed
users to set invalid Node IDs (e.g., -1 or 9999).

This patch adds a check using 'node_online(nid)' to ensure the input
is a valid, online node. If the node is invalid, it returns
-EINVAL. This change also resolves the TODO comment "error handling
for target_nid range".

Test:
Built kernel successfully with CONFIG_DAMON_SYSFS=y. Verified the fix
using a bash script that first creates a DAMON scheme, resets
'target_nid' to a valid value (0), and then attempts to write
invalid values (9999 and -1).

Confirmed that writing 9999 and -1 previously succeeded (incorrectly),
but now fail by rejecting the write and retaining the valid value (0)
as expected.

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 mm/damon/sysfs-schemes.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6536f16006c9..b18321e64423 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2244,11 +2244,18 @@ static ssize_t target_nid_store(struct kobject *kobj,
 	struct damon_sysfs_scheme *scheme = container_of(kobj,
 			struct damon_sysfs_scheme, kobj);
 	int err = 0;
+	int nid;

-	/* TODO: error handling for target_nid range. */
-	err = kstrtoint(buf, 0, &scheme->target_nid);
+	err = kstrtoint(buf, 0, &nid);
+	if (err)
+		return err;

-	return err ? err : count;
+	if (!node_online(nid))
+		return -EINVAL;
+
+	scheme->target_nid = nid;
+
+	return count;
 }

 static void damon_sysfs_scheme_release(struct kobject *kobj)

base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
--
2.52.0

