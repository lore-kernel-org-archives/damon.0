Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14B2FB97B;
	Sun, 26 Apr 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236756; cv=none; b=N5RiJabLdugYYwg75HQECCVS+s4lBao18OnLYQFkrHs4ilVs2lVL20ursxhirTm8dxRxxvgwz/eGvVLoGoRAm+i5dqgim87sxydElYr2PpHmn3UTQVjh7xpTo6PYLdUK8OfC/hdyG0AGNXEwnN9azONXbSFrYqmg5bIyWgOd+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236756; c=relaxed/simple;
	bh=eeiUmDXDACMbPx16b5hdV72jEFWacDugbdDQW4vjkpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYxiKqAjm3omh6WyYd/Nh6xtOpmHiZ4Diqz8rcCD/IyeMSRJ4uAR/NXR6DwG/KUnplHQeUizv5EwEDexSi9qwZ8XBV2oM+yw9V/nMbkGiJQNYXgJV9Eu5KMfst1soh8SJXVGQbfvqrk3FjZg21QBzxxlbmvwjvDWFIh4LyAJrZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXMKqhsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXMKqhsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDD0C2BCAF;
	Sun, 26 Apr 2026 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236756;
	bh=eeiUmDXDACMbPx16b5hdV72jEFWacDugbdDQW4vjkpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXMKqhsQ5FoHGqmoLFZYr3lIcs2q57qa/lQj1+BBzHZ1w2UubNCRvee/ZMw/MzLxb
	 kXtHOuZXZneHfiZIyWEP785KCR9MZFl4ck3t6TFIllQrSyoM0UmRZQfkuQcDIdllXe
	 jS28y9pkO4ol6pOBWw47bC6B04X/7xAGdFOn6ljQOO7ao79j/i3/jIXzX8/JTatk4j
	 Wm2HswnkcWuDwZBTKm6j1Z0WhWVu3C+mov2cf2wMDvTQu8+RJnOHUqWFzM9v7d113y
	 DZMbbP9WwWbpUl7Qx0ismbDLp9ccDL8gbnn/kVSVGxKKs9lDNvkWoQz3wrDfkihcin
	 9OvrzP3HkxDEQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/19] mm/damon/core: introduce damon_ops->apply_probes
Date: Sun, 26 Apr 2026 13:52:07 -0700
Message-ID: <20260426205222.93895-7-sj@kernel.org>
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

Extend damon_operations struct with a new callback, namely apply_probe.
The callback will be invoked for data attributes monitoring.  More
specifically, the callback will apply damon_probe objects to each region
and update the per-region per-probe counters for the number of
encountered probe-positive samples.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 766d6daa52a3e..4266fcb121a33 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -632,6 +632,7 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
+ * @apply_probes:		Apply probes for each region.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
@@ -675,6 +676,7 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
+	void (*apply_probes)(struct damon_ctx *context);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_region *r, struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
-- 
2.47.3
