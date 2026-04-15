Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CCD29C325;
	Wed, 15 Apr 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216057; cv=none; b=nbnH1GTAjpJuTyRhhxUWOsCACE7a3hLshM+7uHQWqP9OacWPueOa6QX3pRORWVi1LnusyAfV6PmsGy8FOKDh+gy7l5JDg/XGxkrnRsfw6lyj5EV+RwwiKSns7tEbi6WFK/XhINQm+cSxR3Gb8ftsOhU+NE2vncGlQKI+aZ1MapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216057; c=relaxed/simple;
	bh=9rMAkySwPwOzbR0wIgkJ8MpOnAl8M9axmSlqMcxmgDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVY5a/VQz/giywZVUQLf1TjiL3d5a2eIZAEcdBXnaCLfkyrR2JZdWaL91QPCnZC7Pd6lUwerD+vv6ScnY06f36INKy6wlGC5gqOWQksoENH9OF8OK3tIUne4YMfe8XvTysbsbiyqIO566ujx4fd3hkmKMwoYE9rfD/5ULPnfRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK64Gw2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK64Gw2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD95BC4AF0B;
	Wed, 15 Apr 2026 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776216057;
	bh=9rMAkySwPwOzbR0wIgkJ8MpOnAl8M9axmSlqMcxmgDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aK64Gw2ur1hChS7ihUc5Z+ZtOlcOMO6rKxfPpk1x12xYtp19gCrx5YtOmmiBtsPLK
	 Nqfa/HwiNAbxNJge6BC928eI8Xc+Q58dLxSglm8rjoRI/Q0VzDq5xkrIa/gEO/Ubde
	 l8XKuPG8BsYipTEhAL6hqA/zB1rIyBUhkdlvhJ1AhokMkEbgtx5lmuI3LG4/jKUq9z
	 ezcuoQVS0T6tB+Q0hsPVTC2KFJidYWEnPxw3QxLYf5NgjD9Yih2CXxndfAnxqnLd+k
	 Gd6TIaEhRv86iDjoaTWErgw12wq+oISGaWy/z7ebg5f382XxNZ6wTKYOVlbm0jcSxw
	 zMZ31oUofRvSQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/7] mm/damon: introduce damon_set_region_system_rams_default()
Date: Tue, 14 Apr 2026 18:20:29 -0700
Message-ID: <20260415012048.76508-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415012048.76508-1-sj@kernel.org>
References: <20260415012048.76508-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_region_biggest_system_ram_default() sets the monitoring target
region as the caller requested.  If the caller didn't specify the
region, it finds the biggest System RAM of the system and sets it as the
target region.  When there are more than one considerable size of System
RAM resources in the system, the default target setup makes no sense.
Introduce a variant, namely damon_set_region_system_rams_default().  It
sets a physical address range that covers all System RAM resources as
the default target region.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  5 +++
 mm/damon/core.c       | 77 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5fb1dc585658b..c4cdaa01ea530 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1007,6 +1007,11 @@ int damon_kdamond_pid(struct damon_ctx *ctx);
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
+int damon_set_region_system_rams_default(struct damon_target *t,
+				unsigned long *start, unsigned long *end,
+				unsigned long addr_unit,
+				unsigned long min_region_sz);
+
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
 				unsigned long addr_unit,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 48633da449104..3cef74ba7f0f4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3186,14 +3186,20 @@ static int kdamond_fn(void *data)
 	return 0;
 }
 
-static int walk_system_ram(struct resource *res, void *arg)
+struct damon_system_ram_range_walk_arg {
+	bool walked;
+	struct resource res;
+};
+
+static int damon_system_ram_walk_fn(struct resource *res, void *arg)
 {
-	struct resource *a = arg;
+	struct damon_system_ram_range_walk_arg *a = arg;
 
-	if (resource_size(a) < resource_size(res)) {
-		a->start = res->start;
-		a->end = res->end;
+	if (!a->walked) {
+		a->walked = true;
+		a->res.start = res->start;
 	}
+	a->res.end = res->end;
 	return 0;
 }
 
@@ -3210,6 +3216,67 @@ static unsigned long damon_res_to_core_addr(resource_size_t ra,
 	return ra / addr_unit;
 }
 
+static bool damon_find_system_rams_range(unsigned long *start,
+		unsigned long *end, unsigned long addr_unit)
+{
+	struct damon_system_ram_range_walk_arg arg = {};
+
+	walk_system_ram_res(0, -1, &arg, damon_system_ram_walk_fn);
+	if (!arg.walked)
+		return false;
+	*start = damon_res_to_core_addr(arg.res.start, addr_unit);
+	*end = damon_res_to_core_addr(arg.res.end + 1, addr_unit);
+	if (*end <= *start)
+		return false;
+	return true;
+}
+
+/**
+ * damon_set_region_system_rams_default() - Set the region of the given
+ * monitoring target as requested, or to cover all 'System RAM' resources.
+ * @t:		The monitoring target to set the region.
+ * @start:	The pointer to the start address of the region.
+ * @end:	The pointer to the end address of the region.
+ * @addr_unit:	The address unit for the damon_ctx of @t.
+ * @min_region_sz:	Minimum region size.
+ *
+ * This function sets the region of @t as requested by @start and @end.  If the
+ * values of @start and @end are zero, however, this function finds 'System
+ * RAM' resources and sets the region to cover all the resource.  In the latter
+ * case, this function saves the start and the end addresseses of the first and
+ * the last resources in @start and @end, respectively.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_region_system_rams_default(struct damon_target *t,
+			unsigned long *start, unsigned long *end,
+			unsigned long addr_unit, unsigned long min_region_sz)
+{
+	struct damon_addr_range addr_range;
+
+	if (*start > *end)
+		return -EINVAL;
+
+	if (!*start && !*end &&
+		!damon_find_system_rams_range(start, end, addr_unit))
+		return -EINVAL;
+
+	addr_range.start = *start;
+	addr_range.end = *end;
+	return damon_set_regions(t, &addr_range, 1, min_region_sz);
+}
+
+static int walk_system_ram(struct resource *res, void *arg)
+{
+	struct resource *a = arg;
+
+	if (resource_size(a) < resource_size(res)) {
+		a->start = res->start;
+		a->end = res->end;
+	}
+	return 0;
+}
+
 /*
  * Find biggest 'System RAM' resource and store its start and end address in
  * @start and @end, respectively.  If no System RAM is found, returns false.
-- 
2.47.3
