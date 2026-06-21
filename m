Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84232BCF4C;
	Sun, 21 Jun 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057453; cv=none; b=jL6WjrAs4AcQn4rASBKrH2oz6JfJDXIfnozrdQX3WbdFRO7uKO5PcZYzzHNb7AZETvggslgufkG4/4ulvVYN/GSQY4ejb8HQ0mK3lvtrwvAjerTHNPpV/45Hmyb+jTYbkHSe8zmN8Gg+VzFSCMLrChlPSAxKm3vS5wQy6IfNnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057453; c=relaxed/simple;
	bh=aIGhUJ4IoRlUb8jMftp99Tj2NImb49Pmhd/fzeAvk+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thlF0p4mNgcqSU9d1Hkwc86rZrDhwCXmB6Kk6/sXnNJtnBLiJQoc7xn98keAoRr57/ATgiEPalH7XjZ/hj87dNBRPDAKuWTy2u9bxziSlipN4atgy23a3RHJWdwbkLg6ceEJ9LpvkNLKwzjkdlptpovdp8W53gPdJ43dvS8Vb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C97Ow5Hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C97Ow5Hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075561F00A3D;
	Sun, 21 Jun 2026 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057452;
	bh=HUk5Cck1sJbUUjMgjgxqdG3j5G1J/Fn/sddbtTw+llU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C97Ow5HnfxplLkK+NVpgTZYd4oj2I9AULKD4yRHRT6klAV8l/mMgdXDxZSD0h8cLv
	 g1+m3EHaPtH+NtSdtYy4uBDgPf25Zhb+BBjxZFOG9RNOl0WTwrNnpmPkVU/kie/cqN
	 D6FshYCABVRPkSNTjRBHqIR3gzx5xzbNvhzUhxyP34lLh0iT91fG/WajZbQxp3zTX1
	 aa1v0MzHqTb+26CLeZcrbkq78r/LVHHlXsKqqG3sBn6XqxHSt6OMBxtq8YdAf6sNAU
	 AcIhWOZxqA2/Ms4lWjcZyK8Kzxa1SQ7Dz4B5J/+W30bBfv+1NaSNTjqmso3zA2R3j9
	 Ly81p9WjhCzwA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 06/17] mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions
Date: Sun, 21 Jun 2026 08:57:02 -0700
Message-ID: <20260621155715.87932-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_mvsum() returns a value same to nr_accesses_bp.  Also
the function is more simple and therefore more tolerant to errors.
Execution of the function would be more expensive than the simple read
of the field, but because the function is quite simple, the overhead
should be negligible.  Use it in the DAMON sysfs interface for
scheme-tried regions, instead of the nr_accesses_bp.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9d8fab32b80f7..30a007bcf82f4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -159,7 +159,7 @@ struct damon_sysfs_scheme_region {
 };
 
 static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
-		struct damon_region *region)
+		struct damon_region *region, struct damon_ctx *ctx)
 {
 	struct damon_sysfs_scheme_region *sysfs_region = kmalloc_obj(*sysfs_region);
 
@@ -167,7 +167,7 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 		return NULL;
 	sysfs_region->kobj = (struct kobject){};
 	sysfs_region->ar = region->ar;
-	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
+	sysfs_region->nr_accesses = damon_nr_accesses_mvsum(region, ctx);
 	sysfs_region->age = region->age;
 	sysfs_region->probes = NULL;
 	INIT_LIST_HEAD(&sysfs_region->list);
@@ -3124,7 +3124,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (total_bytes_only)
 		return;
 
-	region = damon_sysfs_scheme_region_alloc(r);
+	region = damon_sysfs_scheme_region_alloc(r, ctx);
 	if (!region)
 		return;
 	region->sz_filter_passed = sz_filter_passed;
-- 
2.47.3
