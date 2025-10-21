Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A51F099C
	for <damon@lists.linux.dev>; Tue, 21 Oct 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063832; cv=none; b=aCn4RgyoIoag9edrV4x4grYppBNkzwf9LrHuy/BVh4MkulU83D8TUKEZQURv5Nxg6XXg7u76nAG+ZJ/cdHIjb3vZOf3glveZWbSa+kue8emdyRtzjnQnPZKZDcdY5JdLmHEbSMj3B5mLc64rdWgwsZHHTZNy3236YOCkW/365/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063832; c=relaxed/simple;
	bh=PXx5eLkbxk9JSDFEIVcWzFW4mmXCb7V+VCISbaH2UAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPn+3ZjIgrZPZo8cSwpOMKPLU0fCPSPbvki+Um4T57bkOucrEzYUa96+erfNhL8HF673lJPBEUdA+LodkXOi+PrdexT2C9d8n9zde5S07tEi5iRxgXcrj/Z7UVAUQlwdu0yl+9hUvNazkbp+rCB/o6A6Dkj6j8aORmO/8UFWM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbEoKfAw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbEoKfAw"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso3993305a12.3
        for <damon@lists.linux.dev>; Tue, 21 Oct 2025 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761063831; x=1761668631; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rHjyJNySjOtG/oaWeyGKlZi0ukwWvydylLz+ummOiU=;
        b=BbEoKfAw5iM9rejmMUtS//R73Byb+vgdf9JpJ/VmUZwSks07RcZykTEm17TUNHxO7k
         28dM5IjPlaziPR2Jk7gufZpxxhJb8eqWNpkODoitJYH/ZJthUmR5LfPsrcf3x6aTlHb9
         SARVOTjtakkS/zjKSollt6ZUDrmib/uFwZBL5DRRBr6xCEn5xSYKXJ8JPFbJu5oxb3GN
         z+arn4eIeZIOlIiVDSpuvq63aunWKSJWP52cn0pGdBtx4w7UkRhG0sr+DGmdGcNIkeOI
         6WXuXS/kYnKYWWR9saQh7tHQjgutd7LVvQYPnZfykA42L8rPGKvTu4/CIDeu2C2Ls88n
         BTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063831; x=1761668631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rHjyJNySjOtG/oaWeyGKlZi0ukwWvydylLz+ummOiU=;
        b=Z+Cf0Crz0T+ZxpIyAqVV6m5XpL66Yk0W+c1EBpbcv0PpsR9cBgzkFudbksxSCQbLoX
         xsOxmHfpYP7OlBq68izchzgTFiwvFKNxONVU0zEWJkNEDSYsSFMOoTBD1I6IR6OiT1BZ
         /01ThUD69GZAiYbMxd4XPX3GVYCKBmjPExHl7fyUhYuG92jQfLqG6T4QOflc81Okb9qf
         HW1VKWht0g6IdljZ5xKvSx7XFNeTD3IpDfXSj5csGhNPYT+Jyn6wH0DMZRYEfPUrIeG8
         fG/QqAc4BCwofKS1q61is73NqsAuswNXO2IFzKQZabnj2lLDI/BYSX9Y08aZHWqhvheL
         Phcw==
X-Forwarded-Encrypted: i=1; AJvYcCXMEOTyMEynWDwgxiaPq9NPGsKvw7ymCouAJr4qAlsJRRIdMxp21cHW4yeKmNEChputJYM7gg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxvct0wUmm3HTe5foUeGZBAqDD1JRyr2afF8G7iqNdxOJaMdWeH
	Rg7j3JV1wm+oifjGs1Jgdxblc44LfIbrbIoCgyy7mJTIisGWB1SLAlQN
X-Gm-Gg: ASbGncslfMRXd5sBGVOYp9cP1gcHqeoqwWKuUASojq3ObH4gizLwhnR4o40A5Q6OM3B
	6LZBGmma3FhmhxlmuLJLY0j2WZvvqYCVtGq0ja/I1rUni5ksxGlTfjoGZo+mzWZPa1Y9v0rvzyU
	8xlLthy1402rdZb8lZcTed9a9cnQnc4g/z3VCIQEXHY7s7+ER/zIB9dFxh6cNoGy8IF8DHO8ZMk
	l2wZyty1aX/IsBWNPqxdr/+GbYBIbYCKhwi6By1HEkfvlSncKNAboKlCE7t6ZOCl5D5zHmuNjNq
	eHAuqydbueJn6K97/LvyUflM4nTpJs2a7MaC7CwkqSDmBVU7quoERaRkogHXeKm25ptY8PSQIZ8
	CCf4ZBF5WdPot1+XBPIKXnHYl+HQ4aeq+Kkdvb/keFC4TnYRpix+nTS7YvBbM2BFE/Hhpy1KSjh
	CdfGu5w9lus3ZJWreO0No=
X-Google-Smtp-Source: AGHT+IHkHuRO/cGncKISQZWD1qXwaE7w5T+jTVF2YE5Hm+JwJpfutTKAmSOGddAAEiei3b1lnpM3QA==
X-Received: by 2002:a17:902:f64a:b0:269:9e4d:4c8b with SMTP id d9443c01a7336-290ca403110mr218424325ad.21.1761063830609;
        Tue, 21 Oct 2025 09:23:50 -0700 (PDT)
Received: from LilGuy ([2409:40c2:1050:6e5a:c22e:8b12:2301:3845])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-292471d5938sm113390265ad.58.2025.10.21.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:23:50 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] mm/damon/sysfs: Remove misleading todo comment in nid_show()
Date: Tue, 21 Oct 2025 21:53:24 +0000
Message-ID: <20251021215323.29734-2-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO comment in nid_show() suggested returning an error if the goal was
not using nid. However, this comment was found to be inaccurate and
misleading.This patch removes the TODO comment without changing any
existing behavior.

This change follows feedback from SJ who pointed out [1] that wiring-order
independence is expected and the function should simply show the last
set value. and [2] checkpatch.pl complain about number of chars per line

No functional code changes were made.

Tested with KUnit:
- Built kernel with KUnit and DAMON sysfs tests enabled.
- Executed KUnit tests:
  ./tools/testing/kunit/kunit.py run --kunitconfig ./mm/damon/tests/
- All 25 tests passed, including damon_sysfs_test_add_targets.

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Suggested-by: SeongJae Park <sj@kernel.org>

[1] https://lore.kernel.org/lkml/20251020151315.66260-1-sj@kernel.org/
[2] https://lore.kernel.org/lkml/20251021010847.68473-1-sj@kernel.org/
---
 mm/damon/sysfs-schemes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6536f16006c9..760279092b4f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1112,7 +1112,6 @@ static ssize_t nid_show(struct kobject *kobj,
 	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
 			damos_sysfs_quota_goal, kobj);

-	/* todo: return error if the goal is not using nid */

 	return sysfs_emit(buf, "%d\n", goal->nid);
 }

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
--
2.51.0

