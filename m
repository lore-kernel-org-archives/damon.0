Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10942254F;
	Tue,  7 Jul 2026 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432255; cv=none; b=GaDk1iY2GPgRDRYbUNN6SzheqTmHBL4+SsmZ3p8HEW5zm9riYE8BWajcUQff8SkLvKr0kFm0lh33LNHCq1yG87t6OaYHmeRuQhkavEOsyv7rp/hOF9w4hlDDvB/tJFyQeM6p4YTNNSjJzpCRg61rfzvYimd3VVZoLzq0vopJpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432255; c=relaxed/simple;
	bh=Rb6NbxjmP6P2KuwfZKGdkj8qrxwiVOFNJFX9NOhcYwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dayNSqrCmQDL6XQAdqrqxvBjjF17Z+c9FV7XB2MGkgcDJWZZ/xpSbKLsXZXGp224mJMfT7nUN1AmwdHUc3IRGhVeD6zpO1xGrw2igchW2CrZ2umfegDalfcR8lcRCrpZ8/hq6cLBfdzBkiu9QLbUU5OCalATlamQcsMHwzzKWtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9+XRwXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9+XRwXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D671F00A3D;
	Tue,  7 Jul 2026 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432251;
	bh=CNpIO+SPQXji8X+//JGLIeVACOioKXNsL/4ynMEtvQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E9+XRwXKny0XBWnxcaapAMrTKbV5zSRJOfIx0quQQCbI0or4ckcFsXMUqvWrt6qU7
	 /ENPuv+FYA/u4si6dS8gVF+QeZDWl/zNPz3PmYDCugiiuQBiMWNoyF09NtynIP90EW
	 a5yvVS55wTUztjmSMJ38VJUETFQS+qqByS86hEhegzN7Amn99h/FlQjlSxrHk88J+w
	 oaajX4+0a6j7TlWuEQ3qgY8HCoavTTpDyTtKkuUNYejnUdZ2jhEXw5efhiS5jr3qZ2
	 8AKD7j4K2ZV0hi4exsO6n/bDVcd6wLUwVnbsnlWaXLfarC+rQrqRPcFX+FRUoEi6Sr
	 lHjSwdlstCxJQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 3/7] mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
Date: Tue,  7 Jul 2026 06:50:32 -0700
Message-ID: <20260707135038.90068-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707135038.90068-1-sj@kernel.org>
References: <20260707135038.90068-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

accesses_bp_to_nr_accesses() actually converts a positive samples ratio
to the count.  Rename it to better describe what it really does and not
confusing for more general uses.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 177e5abc981ef..dea63083917b0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -876,11 +876,11 @@ static unsigned int damon_age_for_new_attrs(unsigned int age,
 	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
 }
 
-/* convert access ratio in bp (per 10,000) to nr_accesses */
-static unsigned int damon_accesses_bp_to_nr_accesses(
-		unsigned int accesses_bp, struct damon_attrs *attrs)
+/* convert sample ratio in bp (per 10,000) to count */
+static unsigned int damon_sample_bp_to_count(
+		unsigned int bp, struct damon_attrs *attrs)
 {
-	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
+	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
 }
 
 /* Convert nr_accesses to access ratio in bp (per 10,000) */
@@ -893,7 +893,7 @@ static unsigned int damon_nr_accesses_to_accesses_bp(
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
-	return damon_accesses_bp_to_nr_accesses(
+	return damon_sample_bp_to_count(
 			damon_nr_accesses_to_accesses_bp(
 				nr_accesses, old_attrs),
 			new_attrs);
-- 
2.47.3
