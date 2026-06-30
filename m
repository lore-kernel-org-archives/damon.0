Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F53DD500;
	Tue, 30 Jun 2026 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792507; cv=none; b=YWhh2qAYQgNWMLspWAM2FpfjYo7O2oncFJ7cVBV1b5myWANa2g1F+2yG2xlCOm04wI7M4eI2qv4ZBUM7JATebn+nYouiPnB7CEpxWqKDVDtSgCDsQSOo9/SsBhbPVUT0zaFGrFO6eu0U72NflAH4zWZ6eFpEu2UxyIsBu1ON3gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792507; c=relaxed/simple;
	bh=CMN9iU8vgz8xP+r6dIaL6i+7njMOOT2M28PNEbwShh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuC4M32SSD1UxCOScUDyGZvB7UmJOLzu+z6SYcQRBx9iEIs0A4BD3XPsS7QTMy/hlBRut2rd8utmvwvjGn0dyJT7V2Zfxk8eryHGyb2VV8DtFvZgD/Gq13u/AXU0Bfx9RquQDfiDezGs/MKRX2xVQ0bJnHvIWNdSCdOsdH/M+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF3MoQG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF3MoQG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D3A1F00A3D;
	Tue, 30 Jun 2026 04:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792506;
	bh=qVKKQyZNxinKbnhBlGVW7XhXLiIyfL9tA4LU8cChtL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mF3MoQG/P2hCjrSEvrbxYB5IrFcDVx2kd5qTnlBgzdPoRqt5e5hGTSGGxNK/ojTz8
	 1u8rcs6tmzSJv496Y9Pg7uw1iZG7T6CmiVpxseUg2EbzoeIRv6ooizXw3J55meeV8v
	 Rk9RndqGCivT43hCq6bejGBQHwthNOJqOpD17JE6zd4WmGLH6fc5tW61XP/WspvbZY
	 eCYPMzE18LEal/VJQ8bWvlUD//CkQgLO2OrBLV2kgZB19WM+HWm7u+nu3k1njf3Eh7
	 X897mGZvDc0+IcE0opQ420Ia4L5GhNC+VLdnW4o83iz3Yif83HaYQqf9QBPD2d5yuI
	 fUcyB+CoZaNuQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/18] mm/damon/sysfs-schemes: use damon_nr_accesses_mvsum() for damo regions
Date: Mon, 29 Jun 2026 21:08:00 -0700
Message-ID: <20260630040812.149729-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 41f93a1823bf1..dbf2b0515d582 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -157,7 +157,7 @@ struct damon_sysfs_scheme_region {
 };
 
 static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
-		struct damon_region *region)
+		struct damon_region *region, struct damon_ctx *ctx)
 {
 	struct damon_sysfs_scheme_region *sysfs_region = kmalloc_obj(*sysfs_region);
 
@@ -165,7 +165,7 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 		return NULL;
 	sysfs_region->kobj = (struct kobject){};
 	sysfs_region->ar = region->ar;
-	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
+	sysfs_region->nr_accesses = damon_nr_accesses_mvsum(region, ctx);
 	sysfs_region->age = region->age;
 	sysfs_region->probes = NULL;
 	INIT_LIST_HEAD(&sysfs_region->list);
@@ -3122,7 +3122,7 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (total_bytes_only)
 		return;
 
-	region = damon_sysfs_scheme_region_alloc(r);
+	region = damon_sysfs_scheme_region_alloc(r, ctx);
 	if (!region)
 		return;
 	region->sz_filter_passed = sz_filter_passed;
-- 
2.47.3
