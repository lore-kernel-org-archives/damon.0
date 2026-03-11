Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036732D7F1;
	Wed, 11 Mar 2026 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206971; cv=none; b=poWKV5plwJilJcmzw/k2RwgplCzmhRyokghCTPGN1gt2GeqIzdCpAhxdC1jXmdpPRLUdoeFprZw1GLvdZ1qZD3vy16YhfGdVfTQ4gRiSxDRyTTLVhV4uo5/czTOLwhuSJYqZ7TavaXm999ao+tN3bze2HDZAHDLazuonXgI6SVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206971; c=relaxed/simple;
	bh=aGbllmaaq9J7Qd8uyVbLEXseWZd1bfmXTBQJFAjpS5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atq+I02fo3hVU39XLKzz9rTZfTkamZm6kiUXORd436PAZVHty/EwgitcgfuJd2xFmvRI/eH+bY7mb/mtbabhiYTWCBgH/P39MhAvEyJT7LJZuUOLKadwY0wjCdN59VDAUvCIZe7bkLHZbRU2V69Hjs+663XuD35UVuOyIf3Zld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6jRZJTO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6jRZJTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74136C2BCB1;
	Wed, 11 Mar 2026 05:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773206971;
	bh=aGbllmaaq9J7Qd8uyVbLEXseWZd1bfmXTBQJFAjpS5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6jRZJTOTU4p8b7NVG4ikk3Ufgt08EDESkq6teQ6x1piVHyuyBVy12Jopkr+JSBGR
	 4QUIxeZEbR1zhDZfR1KhtbTeL3gf30/ZXNRFyk61is+06IVPMMWhC7Fhyq6F1O0jVL
	 IHst+/bFywOsmwXmA0cs8u/XEiuhDmxyA3IGoLLMzepARhSRFOpaBDsmyIH9D2L8lK
	 CHZa5Y+Ntg2/gMQnRZE02bO707dvqaOEn6h0eYz0ekCsSa5pq6P/DAfNbleTESFid8
	 rTZ0po2uJjVdzTKF920YK1wkXR9dZgugdCkA7WDDvQcNGBfHKIPBpqGJ3eM0rWR+XH
	 89NfYufvRjUCg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] mm/damon/core: support addr_unit on damon_find_biggest_system_ram()
Date: Tue, 10 Mar 2026 22:29:23 -0700
Message-ID: <20260311052927.93921-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311052927.93921-1-sj@kernel.org>
References: <20260311052927.93921-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_find_biggest_system_ram() sets an 'unsigned long' variable with
'resource_size_t' value.  This is fundamentally wrong.  On environments
such as ARM 32 bit machines having LPAE (Large Physical Address
Extensions), which DAMON supports, the size of 'unsigned long' may be
smaller than that of 'resource_size_t'.  It is safe, though, since we
restrict the walk to be done only up to ULONG_MAX.

DAMON supports the address size gap using 'addr_unit'.  We didn't add
the support to the function, just to make the initial support change
small.  Now the support is reasonably settled.  This kind of gap is only
making the code inconsistent and easy to be confused.  Add the support
of 'addr_unit' to the function, by letting callers pass the 'addr_unit'
and handling it in the function.  All callers are passing 'addr_unit' 1,
though, to keep the old behavior.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3925720a172a6..aee61bf991baa 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3056,31 +3056,44 @@ static int kdamond_fn(void *data)
 
 static int walk_system_ram(struct resource *res, void *arg)
 {
-	struct damon_addr_range *a = arg;
+	struct resource *a = arg;
 
-	if (a->end - a->start < resource_size(res)) {
+	if (resource_size(a) < resource_size(res)) {
 		a->start = res->start;
-		a->end = res->end + 1;
+		a->end = res->end;
 	}
 	return 0;
 }
 
+static unsigned long damon_res_to_core_addr(resource_size_t ra,
+		unsigned long addr_unit)
+{
+	/*
+	 * Use div_u64() for avoiding linking errors related with __udivdi3,
+	 * __aeabi_uldivmod, or similar problems.  This should also improve the
+	 * performance optimization (read div_u64() comment for the detail).
+	 */
+	if (sizeof(ra) == 8 && sizeof(addr_unit) == 4)
+		return div_u64(ra, addr_unit);
+	return ra / addr_unit;
+}
+
 /*
  * Find biggest 'System RAM' resource and store its start and end address in
  * @start and @end, respectively.  If no System RAM is found, returns false.
  */
 static bool damon_find_biggest_system_ram(unsigned long *start,
-						unsigned long *end)
+		unsigned long *end, unsigned long addr_unit)
 
 {
-	struct damon_addr_range arg = {};
+	struct resource res = {};
 
-	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
-	if (arg.end <= arg.start)
+	walk_system_ram_res(0, -1, &res, walk_system_ram);
+	if (res.end < res.start)
 		return false;
 
-	*start = arg.start;
-	*end = arg.end;
+	*start = damon_res_to_core_addr(res.start, addr_unit);
+	*end = damon_res_to_core_addr(res.end + 1, addr_unit);
 	return true;
 }
 
@@ -3110,7 +3123,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 		return -EINVAL;
 
 	if (!*start && !*end &&
-		!damon_find_biggest_system_ram(start, end))
+		!damon_find_biggest_system_ram(start, end, 1))
 		return -EINVAL;
 
 	addr_range.start = *start;
-- 
2.47.3
