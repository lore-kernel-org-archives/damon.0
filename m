Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C13AD509;
	Wed,  8 Jul 2026 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474381; cv=none; b=FG9S37GW1N0SPGcgdqFpJNdUw5/GXZSXgT8mXjqKDb24//gqZiwlj16WSeYrsz3tcGi4oOgwg6NUN6sl///AHcxCzwWg6RW0qxMKDgepxJ+2ioHIpEXzd9GRAz5tL3N4ynDZXw4BNcUx5pFWgi/tBdNvBFQ52SXxKw84LqR+V3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474381; c=relaxed/simple;
	bh=Rb6NbxjmP6P2KuwfZKGdkj8qrxwiVOFNJFX9NOhcYwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiBl70M2CgbraDIPtaHdmEFFwg8BVaKuX9GMuxedrCbwCrxhShWINRTSbSCojLPlrMsqivEIiGyY6lHjMXvG/vgjqy0eqVF/5ECLX3Nk4/nZutfGnfO2gOMAE6HziJHEPu0dpVaeBQ3jBaedYDNu+/nAK5SP3LlMgPpI9R3Stjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAHhW4Om; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAHhW4Om"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8090A1F000E9;
	Wed,  8 Jul 2026 01:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474379;
	bh=CNpIO+SPQXji8X+//JGLIeVACOioKXNsL/4ynMEtvQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YAHhW4Om8ZDCV+f6v4iF7XDkEWAjWBX4CCdPoFvA5JJcINE/q4gHVWDN460FZHs8f
	 ARzCIh4WLbzUnTjb9QeFe/hGgqf3WmTKNow34Trz8nO9uHw1ZxVKVOlH/tPoVI0Ut8
	 paKyl0QxJlpxvCeSozyV1pF5Z+2fX1VphFWzKIvTBIeTQ8lVueAMtorslKE87G5D5S
	 fTkTYrKtMjsgIMJ+dPZasZ3BxVBWX//MefVcn24SdVpogCzDvCfvegUvnC/KTfTAH1
	 2jh7/RzQiWSLGJije9OkwDihRF6/V6AAXAxDxJiPMw79XFvVom1gGrS5NLXmLyOgZr
	 TGrQNrCT9hqOQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 3/7] mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
Date: Tue,  7 Jul 2026 18:32:46 -0700
Message-ID: <20260708013252.95888-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708013252.95888-1-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
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
