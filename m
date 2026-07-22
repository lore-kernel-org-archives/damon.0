Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD843D503
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720038; cv=none; b=H7gp6CKjmNbfH5awYrmgaWMq9pfPWyAt78Sn855xEJFi+NMJ5UQs6TtS9ci2bZtkJJ3luIU2m44l2D/1+M3HaLFc74hOxRAifrd88TRTc/fXbzHPTmK1Mczlv72ekCHjEcc3R8E2W2XN/4SDuIBYInPi91o4u42F/gztoyQ0M9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720038; c=relaxed/simple;
	bh=fdoT408pXeHyekonjoqrqHOqGsBjQl2gf0u8gJMxTvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAPVoDH0HmGAM8Kcf/rcBv8iA24OaLrwVQxoeKsM40tdNHzg0rgPxEUh/iwQOt7DsreIAUkdXNNNG1cwnM30wOrc9EKg0ArITKiG5qh6be74DFuAOsatwEcJuS34uqiKd4u4a1Vp0Oj36FPSBAd/gh7QJLd3GvsR52S5x1mBU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB6eM9Ef; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB6eM9Ef"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848743155bcso3526651b3a.0
        for <damon@lists.linux.dev>; Wed, 22 Jul 2026 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784720035; x=1785324835; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LUhTDedR70ZXXTiOjTiOLU7QAjd8TnaNf50qKPQfc+o=;
        b=cB6eM9Efd9nnclO6x5zEH6vgF7Qjh3rQmAcqvJCVxJw9wFdqEcZGb4yeTMVpGLzmfi
         i/HIqM7fIVFD/7i2kGZwjevqsCS+iBNnsJRH3LVmx0uwEQoi74vgNMMqbk7nIQhznmUz
         8HGs++M6W9YR9X6i9AldwUNse2fKrf3Wn0Tq77d3Y9tAaPmSdCsfbQUDP/bArH23d8Xi
         TbLmXGyxIdFu7UB5Wk+9DTgjzqmW1dQPcjL0ycDT5frZbteE4Qz3cM97lotk78dS6wxr
         j9xri0aBx52vRLAx5dRJUNkwL1Xa8LT5GAys+OWcEaskh3LJCLdqKsVkbEw1c9/7k/6f
         r6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784720035; x=1785324835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LUhTDedR70ZXXTiOjTiOLU7QAjd8TnaNf50qKPQfc+o=;
        b=KwzVOZvb1CNdeZ/NKOp43gvLoei5ppKoAsuCeKVUH8+dVfy2dSMjTgpgnDH1U39I1r
         pIfBwcIyQdP0/9xCLZOoX6Czf0X3QovONSyu8sVmFBJe2/9CxnvA761x/lNFwdLtWZA6
         oeiyT73TNbsbt7klFDqt7oQZ+Vfegj1Oi72pn8vbRS96pdpb+LWIsbEnZPXNKZhLG5oF
         vudiEE8Gv/PjmbNp6BZu51tQ6oZey1DyS1vWC6dQwrt9L4mJTAUtQksb2Ywkfo84P+0C
         ufU7S/OUgD1wh7jOEuZ2nJ5nldWV2y2uCYA4tEocPB3RS5L29F3s3hUf276P8wBYvie7
         8IDw==
X-Forwarded-Encrypted: i=1; AHgh+RoK0wTxcVJ69GMyznnUHXvzumLnEOSU0O4AZQsHSk+hnADoVl8VEXsavS46kKcd/3N4Kpqc7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwB5UBSDPnU6yi9Wvl2rxwWsYBsEGJmQmlGDumeW9nJWNKp9t7N
	2ofWd4j4VocnF1cvIsDD+Jat/uCEDZY1StCHx+sTfG8aaEwTVXYX63hl
X-Gm-Gg: AR+sD10NoHoh2/BGatWt2GYmtlQ8k77AQD/P573pp1LrypA7RqKldqS/oO4O7Q4/YcI
	asqmpbdoFSOOj4USokF3CxypqKsnzVD0Lq3kyM5GW6rP+iZHXbaBzPf79FaNEPRx1n8Wif0LZKU
	CA0UVzVRwLiWck9BCRH3zVN5VuJMkMZxj+rEnfOKzIkbjJK9jOMpvK7b09edWFfkTZiH757T+sE
	u2q289kOslIc22KZz9vLNYoQqVf7xsGpKHZu3ipRrhCmZx6EGg1T5tAP0l2bE7+UNVFzhW5SX/B
	dJ8SJcRzXlBtcdW1iJh/2lohPFop2h1VbfJd3PwGGxhK3InhIhkoJYexXdim80ex/3bjGCuIL9m
	wlczpij9nb6qnIHXl/QjNrSgp4yB4uUKZqftZ1yXuHO0i3Uw29QS+FcN0i2lB4FHSRCaz+xrt37
	93Zi4EqtcX8cLjHY+EKA==
X-Received: by 2002:a05:6a00:986:b0:848:7071:9863 with SMTP id d2e1a72fcca58-84c29532099mr22204146b3a.53.1784720034864;
        Wed, 22 Jul 2026 04:33:54 -0700 (PDT)
Received: from apt.tailc82bd0.ts.net ([140.123.97.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1c376esm980979a12.29.2026.07.22.04.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:33:54 -0700 (PDT)
From: Cheng-Han Wu <hank20010209@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Cheng-Han Wu <hank20010209@gmail.com>
Subject: [PATCH 1/2] mm/damon/core: remove unused damon_targets_empty()
Date: Wed, 22 Jul 2026 19:33:37 +0800
Message-ID: <20260722113338.302603-2-hank20010209@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722113338.302603-1-hank20010209@gmail.com>
References: <20260722113338.302603-1-hank20010209@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_targets_empty() has had no in-tree users since commit
5ec4333b1967 ("mm/damon: remove DAMON debugfs interface") removed
its last caller.

Remove the unused declaration and definition.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
---
 include/linux/damon.h | 1 -
 mm/damon/core.c       | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..8e5589ccf50f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1054,7 +1054,6 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src);
 
 struct damon_target *damon_new_target(void);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
-bool damon_targets_empty(struct damon_ctx *ctx);
 void damon_free_target(struct damon_target *t);
 void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx);
 unsigned int damon_nr_regions(struct damon_target *t);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..da97b2dc39d1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -795,11 +795,6 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }
 
-bool damon_targets_empty(struct damon_ctx *ctx)
-{
-	return list_empty(&ctx->adaptive_targets);
-}
-
 static void damon_del_target(struct damon_target *t)
 {
 	list_del(&t->list);
-- 
2.52.0

