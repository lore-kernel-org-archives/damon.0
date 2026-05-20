Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54E2374745;
	Wed, 20 May 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258551; cv=none; b=K0D72bEmvX8FSy+eQSuzvacV9nw3lwdp36Lt4i4f82bMIzTK0awhL/kq5gVwx1WYU2Hwc3BJ/lHP7SFuF8ackninysCGbIsARo0qkTkRQlYWodnDlJS++ITiqLlUbISMDLCFx+DJP7/vxV3LENq51CZ1qDjdumFGGeHMrJ/yNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258551; c=relaxed/simple;
	bh=U3R/VpB5fsj2Kzc8E2SVAl/KkIrkOZVOd6iQ6EUqjEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSaECEN/lgL3Uliz1/mTlMbqXJBCiY1kUidfdfbPKyNZAdfYbuXG9sM0sxZtd3Ul/KcGztnmSgSZhB6HEFrm6B9xIKi/aCX+Obz/nDb/H/5fZ4yoryJbLmzdbBeW/ht5BI5M8/oPmORE8Q9Wmg0jVHzdtorZfSL1wvorgqTFogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZHxq3jQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZHxq3jQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8481F00893;
	Wed, 20 May 2026 06:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258549;
	bh=lFIspApNE5pg+37NC/h+0JPjyuQa8BCwW93puC6WNUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZHxq3jQWCrHS++tn92TnVdD6zBgrV6BBPNn8Ha50C5DypTJaqZKG1NuySYTb2i74
	 o9o430sNdQkvVKwvb7izM6f+bWMMZjzbV4Hx1p4mbsCXi5VMCGCzvu18HaqezGgpEm
	 k6Wbal/09nScQxMs+W0gGn4xtI+NW4Na+xjyU2cIusnzIKmJaZ6L09raKbekpkBjdK
	 J2RSXQSZv4HcFSjjiY6/E7vTPGWtkiItWcn1NosDTw0Fcyht0yi4k0bunPoD0bhJ/z
	 +9HiwplnJ4GDp4zHvF1MsZz4yGKdbjWr2FynWifqdydze9TJKmKz4NHpMBmChTvA3Q
	 DYSWbT6OKQyRQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/14] mm/damon/core: hide damon_add_region()
Date: Tue, 19 May 2026 23:28:37 -0700
Message-ID: <20260520062858.167011-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_add_region() is being used by only DAMON core, but exposed to
DAMON API callers.  Exposing something that is not really being used by
others will only increase the maintenance cost.  Hide it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 -
 mm/damon/core.c       | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4014fd0d463cb..b9370c1779cba 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1024,7 +1024,6 @@ static inline void damon_insert_region(struct damon_region *r,
 	t->nr_regions++;
 }
 
-void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index e8cf3632115e5..7d1de6ff54eba 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -250,7 +250,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	return region;
 }
 
-void damon_add_region(struct damon_region *r, struct damon_target *t)
+static void damon_add_region(struct damon_region *r, struct damon_target *t)
 {
 	list_add_tail(&r->list, &t->regions_list);
 	t->nr_regions++;
-- 
2.47.3
