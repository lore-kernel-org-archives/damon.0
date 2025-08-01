Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4357915383A
	for <damon@lists.linux.dev>; Fri,  1 Aug 2025 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089234; cv=none; b=nXi5VoUw9sQwjN7ETbtN2rbgY5TD6DeYsN4xnOicj7QNUqgQKrOW4frhbfPhxXOpA3mOQ8sIi1Q5RoRntCFNC6ure+KFWGehkqukRUr3gpN98Uar9rsIZfUNPhtyMKGu5LFRAhEWjhlBk7a8AKCvVz4SfvTIQhTOV5qlPXGDZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089234; c=relaxed/simple;
	bh=6VWhFqgFIIIqZ6lhYXMM3FSKkMvZt2i3RrAM7/Vd2mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTUHaEHkfh4Iop/1wDY+4zYKMEJyVQHWccC+O2+ZVefS7VUwyPdKk9tDGmG1BHx2GLEIy2yHdUCfW5COmHMn+7fbX/n7wzTcO0OLhPkH05gzsDBNBkq49Tu/B/F+o6CbrJJ0am5dk0hQDpeg3iF8B2bANcI82r0uSQnbOmAsSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePZbtd8Q; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePZbtd8Q"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so1902570a12.1
        for <damon@lists.linux.dev>; Fri, 01 Aug 2025 16:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754089230; x=1754694030; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abqEG4k6EI+O4I+vteJ6XJztfIuJJUkYy/PS43p6Afw=;
        b=ePZbtd8QzzmIsWWzlOqy5SYTr2GcQ+9T8ZgtuoOq2uHcaLeiKaUUgesLW7vIwavJP+
         nBAN65veTLhESkRk4D4qUNsCBZ4gH+keOdtw0Lr/2rDuSEcgohp9zpkU+bXhQ2PZ9Her
         PBsTSzpP7ucb9aU3gxN2W9FjDHZgDKlUCjC3kFipdoo3Nf5eV4XJ5U5klcshNdP6G8Ax
         U6Z9nvc2AJPDBjkOmsr+aIQPH3lKoPqSalXHI4NjP3HCYOs9CxjIACAooTGzmoM3nZGh
         Gb6ykFGvLb3jPPLu4IrVz1cUzwVH+QG8/0sHVTs0JWoPjqaZaWBMgG89QlBiV2Z0ZO9M
         hG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754089230; x=1754694030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abqEG4k6EI+O4I+vteJ6XJztfIuJJUkYy/PS43p6Afw=;
        b=I/nFf9BIWJUhvhqTYhSeu8a0ZndaYDyOz0OirGcyfU4dQhvVxwaWWvEA+OLcokS9nA
         qdg+BX8hDoYa62NR5/YAFyd8djhbYWw5dVgi/UTxm/ftcVFk7ZrJYkEzmR5Y+hx/Ibng
         MVzKlpvMoh+3HkJt5igyiUoydTIT7s74y1nk1m3aOJ9QxPMnmk23hh0LsRWcNIuVgT9A
         ITHSfQJAm928EVsF9oxRP1BRrbSvZNvBdIBYmbcFeRPLmi2xN8fjAq2xCJXLUuEDP3Zk
         qbYI0hKVMStJfhSKpVWUsjQ8t1XvU3TWWam1x9vWbEVQgYr4ZaVk2yGgssGqWarFfPUn
         /TjQ==
X-Gm-Message-State: AOJu0YyrdOrS5D3WJdCCDkS4sc2p1r1iP/J4Jp02W3KRgKCVlOTwRG72
	kG2NkCnMgsUh8qxT1DaP5ptSepdxMfsw4LZF+8eMc1qenjXnu1qKuJnF
X-Gm-Gg: ASbGncuY3UhWoAg6nLXISuAnOFSeO5zNQGSOamQAlLY82Z+ctObAuOs8oFZS07bJzd4
	sJgVxLShHIqx2mIKinY5GOuDOi6F2u1a6UercqmpENH4TWuPHkbktMAWN+tjM2xB4xhqBjsWUCg
	mlGjXmpUh92qAipzWXEMdf2Rh0epGiJ8oClGtbk3icokyQoDHPbOKzAjz1KOFE8NFCMybT33tS5
	dD7B6VLH0xObAuo77RJLnismGbNkAX62B9teJUIQV/XYtzu4s2kkjT5sUIZ1YFHlb88mixt/DO+
	y8KI2prP53fOG84iChtEhCD/Zr89CgpsJFl6Q4Q1YpXzN+2B3R6fJBi/ukm8PRwPVlOw04uBvZe
	jEL1m8cSidhv/NP1elpI5VatwX3X6OHnEwgO8h9INXYFrU6YoE+dU/FyPEC+gSpaf4QKefE8=
X-Google-Smtp-Source: AGHT+IGJBab9bvw4VnN4YTk8kzAMWhGzABK21zAIbErqjtzD57IzqR8o7kVbKYxaiRnwlzZ5i9LCkw==
X-Received: by 2002:a50:cc03:0:b0:615:b6b9:d873 with SMTP id 4fb4d7f45d1cf-615e715d669mr677090a12.24.1754089230336;
        Fri, 01 Aug 2025 16:00:30 -0700 (PDT)
Received: from rs3labsrv8.iccluster.epfl.ch (nat-icclus-192-26-29-9.epfl.ch. [192.26.29.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffa17csm3279290a12.49.2025.08.01.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 16:00:29 -0700 (PDT)
From: pyyjason@gmail.com
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Yueyang Pan <pyyjason@gmail.com>
Subject: [PATCH v3 1/2] mm/damon: Move has filter to ops-common
Date: Fri,  1 Aug 2025 22:59:50 +0000
Message-ID: <a290e7913a1c39f605b8cceafd86d41c2dbebf82.1754088635.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754088635.git.pyyjason@gmail.com>
References: <cover.1754088635.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yueyang Pan <pyyjason@gmail.com>

This patch moves damon_pa_scheme_has_filter to ops-common. renaming
to damon_ops_has_filter.
Doing so allows us to reuse its logic in the vaddr version
of DAMOS_STAT

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/ops-common.c |  9 +++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 11 +----------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 99321ff5cb92..de5404477242 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	return nr_migrated;
 }
+
+bool damon_ops_has_filter(struct damos *s)
+{
+	struct damos_filter *f;
+
+	damos_for_each_ops_filter(f, s)
+		return true;
+	return false;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 61ad54aaf256..d3d36bca90b9 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
+
+bool damon_ops_has_filter(struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 53a55c5114fb..9d9cdcc10b8e 100644
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
+	if (!damon_ops_has_filter(s))
 		return 0;
 
 	addr = r->ar.start;
-- 
2.43.0

