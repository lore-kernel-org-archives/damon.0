Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25E2F745C;
	Sun, 26 Apr 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236756; cv=none; b=qWBUG6AGLUUbFGcg5RQ5hjPKkq1AJpZucNNA0iGl1Fes4KWVSaq92/zn0j6HcNMobb5LO+X3A4kvrm6kxuHNuF65HRtCd5TzdOoJflGH9MUoNe3namSyM3yNzYlLGQZmtKY7GZ85kDTNwx/7bdHjlyNiLPem4cIryI43ihTNg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236756; c=relaxed/simple;
	bh=wQ5jrgZcCcBYXHxkXe5BHmR4YJYJ4CSttqynLoS/qrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZLt30bgI1O/hkauq0LXtawbVjnXTeG2ihiRaFdAizcfx3fKZCXsLIg8rhg5aIvK9PzgJPLSf5J8dExPz4pQXmAMqP6JAT06JzhsC7UarJD0UpP5PlxuHw0n1fsKW92rhzGEKzew6AtZeLUDhDc76J4eOEEmcciQOnNi06WCkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVBouhCn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVBouhCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC08C2BCC6;
	Sun, 26 Apr 2026 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236756;
	bh=wQ5jrgZcCcBYXHxkXe5BHmR4YJYJ4CSttqynLoS/qrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVBouhCnGZ8rz+3zC5fPPGDXlLEnJ7IYAnHrjKhKdRldcrRnYNjB/4y0E2qWRv8Ko
	 bYZakYEIUOv7m+AXJ5r+WN/V1lcdPFRmVoso3wXahATS8iBfrm9flDwD3TJMR4qnbE
	 V33sUp57SXx1Livw0cjPDxcQYpJceJg8r+/cMo0T+P9pBSg/7EWKkhBzLBPS3g2u/X
	 sGl+oHOVYRi7dz2Lfe2hZvMkqLTKPwChlcd19cVf0VLS6OuL0Fk0E340N9FkABj817
	 U2P5CwZ0/1j249CEcMzQVZizaCZ3LfDfsNnREc0bAuFUv7o1adK7Gy4fbmXcxlk8sm
	 XRRh/l3wyfAog==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/19] mm/damon/core: introduce damon_region->probe_hits
Date: Sun, 26 Apr 2026 13:52:06 -0700
Message-ID: <20260426205222.93895-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-1-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an array for the per-region per-probe positive samples count.  For
simple and efficient implementation, add a limit to the number of data
probes and set the array to support only the limited number of counters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 ++++
 mm/damon/core.c       | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3290792eab547..766d6daa52a3e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -16,6 +16,8 @@
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define DAMON_MIN_REGION_SZ	PAGE_SIZE
+/* Maximum number of monitoring probes. */
+#define DAMON_MAX_PROBES	(4)
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
@@ -52,6 +54,7 @@ struct damon_size_range {
  * @nr_accesses:	Access frequency of this region.
  * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
  *			each sampling interval.
+ * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
@@ -80,6 +83,7 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	unsigned int nr_accesses_bp;
+	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
 	unsigned int age;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2ab1d6dd47da4..d4779b647a495 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -225,6 +225,7 @@ static void damon_verify_new_region(unsigned long start, unsigned long end)
 struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
+	int i;
 
 	damon_verify_new_region(start, end);
 	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
@@ -235,6 +236,8 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.end = end;
 	region->nr_accesses = 0;
 	region->nr_accesses_bp = 0;
+	for (i = 0; i < DAMON_MAX_PROBES; i++)
+		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
-- 
2.47.3
