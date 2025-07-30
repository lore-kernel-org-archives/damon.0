Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3722D660D
	for <damon@lists.linux.dev>; Wed, 30 Jul 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896004; cv=none; b=V9giv4ICARSx4m8JpCDBnfu5Bsnv3efoFPrqsq24sVfIQzNC4GeSYwWRWkrWX7HNkdMNdH5KXgTkeIDa1PK1elw7rLxYSgZUH9FQkBFxeZ9lBCeeJ7aUXDedQMf+GeaVIBX67p5uHLEwuF3pncHaGECPggDIx7vBuAYNtGXt0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896004; c=relaxed/simple;
	bh=5MtdqOrWp9XL+/7P8KF0tm7XQYdo1i1gdInDgtxB8uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMgLAc1X5OFmtKk1v4zVvL5964aIwKTOQht0iqeXwUX37S4y1BY1axdACMKQxJE4+Ozhhm5V6uQ8a+1uyMnJxLMjWrrkMBp963I1nP6LS2QZBrWXGkm/il8XdJL2uI1TDTbb9Qs5ULvVmOJOG2D8qylLXngTeMXAtE8F8u6m7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGnDffha; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGnDffha"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so422525e9.3
        for <damon@lists.linux.dev>; Wed, 30 Jul 2025 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753896001; x=1754500801; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ2a6DHl3z5np980mAJ2X98cngKs2SsQ+pYCL8WCFTA=;
        b=gGnDffhaDov66B1KN0AQ38KqXxyRxr3nhM4Z04cAbseroupaQaFJ3JsW/INU4hiBUu
         gTJDm1aTAyo/VBW37vMBe3zi4R3012adrQOjrGmyo6BZNDfjErzvlqfDuDp9AC3UsDOW
         lO2Hjz5bZPqNNkDFnP8O5CfjqoVn8sk4KB3WBmE5jvitDSfGTZ/LSyAs6T4AdFBhiB+M
         2XMxCc5SnEd2wqRxJtg2lHL6yY5lNs7aukS4bGCMe6KeW6z2k/wZyk2ORHGD7MSc+M5/
         MTaKm1+Fvqz7o6kJBsU7n8eKIrto2opJ9fMvMsCYdy0Ozx0TIXah0sD0O3qpK/pUbR4c
         vnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896001; x=1754500801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQ2a6DHl3z5np980mAJ2X98cngKs2SsQ+pYCL8WCFTA=;
        b=xLLOKWIkbBfvG1qQtMdbCrnrMhudgdCTdV9ARcwrDDE0+nvDZMMChOvZM0R/fn6eph
         RPH6yQi12576kXExCI49mBWeHcR2gVEy3SWrZ5rlXIMT2PSBXNYUnjkWe6h9hxXsImqj
         y0FqI0Es2GkNLSlo80ljFzhDSmOIJ7vGOpTzFmVYRXCPWP/XphrKF4xEDqvGOvcxHLE6
         qyaWnRo6NDWk2Frqe/I9DtExue3MJMsEUkcY43S0QLhQfOBoGlZLdZ1PmF2fU8Li7R89
         hExeDuNGc0is92IGyKAeTkuU75lAAizG/LLO6cuPo3VBVMyf3YsU7/gqN9QOz5dKLaNx
         /1Ww==
X-Gm-Message-State: AOJu0YwfErvV28uEW9x+Rdz2sQoEmB5vrEJBacf9170J0Mrk6GgJfmtN
	LQ7iA+jiLTo6Csis1d76vQhpsFW6NEL0nX1Msqwfa1Como05IcmxRKqw
X-Gm-Gg: ASbGnct/8KtMN4xKOKDrHoCV99znqakaS4lAh7hjQW5+Yvw7M5JlHqfZhSuNViNwfy6
	HAG6mWrt4cLaQFOZx4z3+RwekF7zfrpfPz5fsJxA247ewzDrBlB0bS9MDlQULagUM8B8sXebEki
	wdbLL/KAn/giC68b/qwObvEXbjJEK3ScOLpmD/x1dYtaQLXw1z1bobzlHGBatydbf4LuQUHwE5m
	hRvFTL/Df6Bu4sK33oVj64ToM9Hfg3qy/mTtGOfX6IZzo8kUYBJEiQ5W26bCzb2ha91l3nCjjS3
	PCLVA/PTi7RBjMJn2tY8BOjIuWdDUlO1xllF5A6V7EUuYj/29M6lpMfLGinuPKSw6Qmj6oTx9Sp
	igsHPdoREBKYYsOo=
X-Google-Smtp-Source: AGHT+IEHjDXRiZsxpAsVevWpg7SdTkCsFSlZa/tie3LLi8D0AnSzcwlEavp7Qck5/rRCdYnNe8zb1w==
X-Received: by 2002:a05:600c:8119:b0:456:1c44:441f with SMTP id 5b1f17b1804b1-45892be164dmr40383595e9.31.1753896000435;
        Wed, 30 Jul 2025 10:20:00 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:40::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfcadsm37360005e9.18.2025.07.30.10.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:20:00 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon: Move has filter to ops-common
Date: Wed, 30 Jul 2025 10:19:55 -0700
Message-ID: <06734aa15198e542f9defbc1d29fc0731671c3d8.1753895066.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1753895066.git.pyyjason@gmail.com>
References: <cover.1753895066.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves damon_pa_scheme_has_filter to ops-common. renaming
to damon_scheme_has_filter.
Doing so allows us to reuse its logic in the vaddr version
of DAMOS_STAT

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/ops-common.c |  9 +++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 11 +----------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 99321ff5cb92..3ebfa356ca46 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	return nr_migrated;
 }
+
+bool damon_scheme_has_filter(struct damos *s)
+{
+	struct damos_filter *f;
+
+	damos_for_each_ops_filter(f, s)
+		return true;
+	return false;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 61ad54aaf256..8d5c5c7631ac 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
+
+bool damon_scheme_has_filter(struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 53a55c5114fb..daeceed981a0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -262,22 +262,13 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	return applied * PAGE_SIZE;
 }
 
-static bool damon_pa_scheme_has_filter(struct damos *s)
-{
-	struct damos_filter *f;
-
-	damos_for_each_ops_filter(f, s)
-		return true;
-	return false;
-}
-
 static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
 	unsigned long addr;
 	struct folio *folio;
 
-	if (!damon_pa_scheme_has_filter(s))
+	if (!damon_scheme_has_filter(s))
 		return 0;
 
 	addr = r->ar.start;
-- 
2.47.3

