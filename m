Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA671A0B0E
	for <damon@lists.linux.dev>; Tue, 29 Jul 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797218; cv=none; b=paEiv/byxK8yjln0/gHmYYO54MZFMAQqP9mroVlJWvTlDqChKaFUKKYzfQeIFmONFM1wma7QZzEJp4aB33ZJkKuHZ0wW2d4kaG4Yj6NHytquJWpLTKhbj71Qn/5PerLf5F9F/GsFIas9QC/n9dX5kXNyOYXYsyrNhREUd6N6PHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797218; c=relaxed/simple;
	bh=rEYZcKPuEoA+4icI2oULQiQiwjwKdMcQ+KF57c4W68M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXTprGR33y9nB/kElFzn/uaTTBe/JsaE+4y9B3I+RPsSw3QKkvS7OcqUhDzCN/Nh7vcK++wgi0PNZflIBC/kD7Yznv7nt2oQ7pf0EkT5YQBai72vZWIIj97m0gKoa+6DOz9cu4dWJ9TvDeJZG5b41/WyxCm+w21Tmcb3qzbxrlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMm0XKZm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMm0XKZm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4589180b266so972765e9.3
        for <damon@lists.linux.dev>; Tue, 29 Jul 2025 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753797214; x=1754402014; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX7fJLinetNknJ65ovuFB91/gF2qnwRLS3nsv9fgSbo=;
        b=FMm0XKZme61mo3YoXSps5ZqJo1PS6g7S8PcD3OvmrKbrc4T89jy416rRr/U7f1we+6
         aLbU0Im3XKajQcioudGMYzVFr3J0ArSy+R9NMZP6mQiHlHk33W8nii4mFg6we/hdUq1e
         Wquh7bWa1OZbs14d8SRItr3uWaj67Sgzxur0JBJHb/f6ljZCXdgWU1hS42KwylaTSWys
         la0X5npA4iaekGxiYGpIj3L3Q3Kjj1sly+/1Mpgbiu3sTevsRRC3X4uNpTOMvsigLMM0
         kWrsOPoGJxGUU6NJPBjVW8CYzwgHTPBow1OtpbgHyF7CMbTonYmpt8U3iIpod7KasB1P
         Aehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797214; x=1754402014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX7fJLinetNknJ65ovuFB91/gF2qnwRLS3nsv9fgSbo=;
        b=bj8xb0QjYj5o/J0y7LwneWlItRcmO9X+Qsp5wJXfvYmhkLM3zDeUuKylGFeMTXkRkk
         aQnc2vNheIReAzAehumMa5Px463qvKzOIyzdSRbuzrzcOqZDwselvxaKOkozKzp0h2fA
         LTbF02VveSMJmviaWKx6VDjjTO9Dgckn/MIspK6AzKaSANlvzp78hlZI+wC6sJyiHbgR
         7c7LpdQ07RvSvIpxo9AAXBPU1ORMP/bwguMwDqVBAn1UKRHI/T3LrCmzGzY0nUOec+tw
         gDU0bEcg83ygnSs6ILg53HzOvIfl078CIKKjXrr8WMLRCxk6Iurh3n3TJ3opJup3WMZg
         Pojg==
X-Gm-Message-State: AOJu0YwAb9VYegiIHkRgDiy72juf5LKgTAG17TZVboDNeYExtscSovyI
	AOnUVfplxtTzlAJSoACGQTW0EwuaRs5MOcFbirhX+iMRPnTozhOJrCc0
X-Gm-Gg: ASbGnctEZPeGQFNycnK0+cBVzaqCAD8BrSgOhLd946k3J8e7OEootyGBIKqCdwD3kc0
	ts4xTPJFKRdmPamoC92QurBqFEbNZFKGhZvuSolsavi1AXHQAl+hfQR00DIrU31x2K7iqULLm57
	BnA/2HW+aEQR6xNF91IYgYciM1mRBNPxvvCsfFsq8RE2okZ9bHJYXrSKf8P07P7hEffhWXFEIO9
	Np1NKmbU2u+qGTYuzogJZNlZ7WvFpI5m3nS/jx48NiA5A/WxVz8ROq4P1PvLjLM7RoXi9tgvp3N
	W5F5Pe41Y08UMc1/xtdfO3iAKIcYeirpEnpqYkL+FUdzEVvEt37+jTWj+oYEIU1oWjcU6ECQg6G
	lZsBTwBA8W/G6K0Q=
X-Google-Smtp-Source: AGHT+IHiE+mOd2kK/xVH8sQHnsd++XnU+kJq3zliaNuGl67gbnun1ianmf1AcZJq+E+PA+1qbb5MuA==
X-Received: by 2002:a05:600c:3f09:b0:456:1a69:94fd with SMTP id 5b1f17b1804b1-458855d3dbemr84280485e9.0.1753797214014;
        Tue, 29 Jul 2025 06:53:34 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:53::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5e6232sm26786655e9.32.2025.07.29.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:53:33 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	PanJason <pyyjason@gmail.com>
Subject: [PATCH v1 1/2] mm/damon: Move invalid folio and has filter to ops-common
Date: Tue, 29 Jul 2025 06:53:29 -0700
Message-ID: <2e143ff5789954b2c3c5b97b12569bc324cff087.1753794408.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1753794408.git.pyyjason@gmail.com>
References: <cover.1753794408.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: PanJason <pyyjason@gmail.com>

This patch moves the damon_pa_invalid_damos_folio and
damon_pa_scheme_has_filter to ops-common. renaming them
to damon_invalid_damos_folio and damon_scheme_has_filter.
Doing so allows us to reuse their logic in the vaddr version
of DAMOS_STAT
---
 mm/damon/ops-common.c | 19 +++++++++++++++++++
 mm/damon/ops-common.h |  3 +++
 mm/damon/paddr.c      | 29 +++++------------------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 99321ff5cb92..7d3b48cc0f86 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -412,3 +412,22 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	return nr_migrated;
 }
+
+bool damon_scheme_has_filter(struct damos *s)
+{
+	struct damos_filter *f;
+	damos_for_each_ops_filter(f, s)
+		return true;
+	return false;
+}
+
+bool damon_invalid_damos_folio(struct folio *folio, struct damos *s)
+{
+	if (!folio)
+		return true;
+	if (folio == s->last_applied) {
+		folio_put(folio);
+		return true;
+	}
+	return false;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 61ad54aaf256..4e905477fdce 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -21,3 +21,6 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
+
+bool damon_scheme_has_filter(struct damos *s);
+bool damon_invalid_damos_folio(struct folio *folio, struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 53a55c5114fb..a8b7048e871e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -114,16 +114,6 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	return scheme->ops_filters_default_reject;
 }
 
-static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
-{
-	if (!folio)
-		return true;
-	if (folio == s->last_applied) {
-		folio_put(folio);
-		return true;
-	}
-	return false;
-}
 
 static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
@@ -152,7 +142,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
 		folio = damon_get_folio(PHYS_PFN(addr));
-		if (damon_pa_invalid_damos_folio(folio, s)) {
+		if (damon_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -192,7 +182,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
 		folio = damon_get_folio(PHYS_PFN(addr));
-		if (damon_pa_invalid_damos_folio(folio, s)) {
+		if (damon_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -239,7 +229,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
 		folio = damon_get_folio(PHYS_PFN(addr));
-		if (damon_pa_invalid_damos_folio(folio, s)) {
+		if (damon_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -262,28 +252,19 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
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
 	while (addr < r->ar.end) {
 		folio = damon_get_folio(PHYS_PFN(addr));
-		if (damon_pa_invalid_damos_folio(folio, s)) {
+		if (damon_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
-- 
2.47.3

