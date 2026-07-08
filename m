Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD7358363;
	Wed,  8 Jul 2026 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478945; cv=none; b=D1Rxs/Uq3ZyamxI9x14zsw9ju4fDY/bZgJ9O7bgCHUaBKfY5luFAsCeRaZfu8tDi165IAETpxn9Y1X7X6U+RuUEw/iFzPnoIllLIORBzcvIKmy4ev2EXeZuNcoKPerzdSm0pXTxDfY3gRpAPKtblEj6NrKfy5uzFuFVIrlOzMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478945; c=relaxed/simple;
	bh=Rb6NbxjmP6P2KuwfZKGdkj8qrxwiVOFNJFX9NOhcYwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq+dm9FTX5WdYoi0eMS3cEYYhkvbvKnBbQZX4TghUOQm2Fu7TwPXqLgE9syMk65/m4Z2MtugCH4VH9qtL8w/0XYoHP5bRE2GYSrQNqIl9ssZpUVEYJR/xzUs63S8vCeVBZBVgkSwuz8HamSayFFYtTCQ0JVjkIYfZyOtl9QZwGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG6526t9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG6526t9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CF01F00A3E;
	Wed,  8 Jul 2026 02:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478944;
	bh=CNpIO+SPQXji8X+//JGLIeVACOioKXNsL/4ynMEtvQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PG6526t9LPAJzkR8FlalEABJoYHwEKNI43XnOAjFxJc7lWlQHFl1HCjGm+G4g7Gdc
	 NaNQocy+OM38vhhaLb6/rrC6BEBnTAIVfAxGj86h5IEYVvaIRB7bd5gVQghcB/0PrB
	 HJta2RuO5YRDeDcP/BGuewAd2xe28kMAcrljHTjhngjvRiuTUDk0yCW83Yd4GKLbHQ
	 r9+ExzaDgAgOIPnY/OKM+NVM5OugDI8UPmgFe9wGPtWWRhI8qFcV2XV3LhrEbNG2bX
	 6KZ4ZpHIAoo/+mTSmwVv0VmMzJ/j2R3O6Mvmv5f1MrJqjMqRuGPRtOxHYcQQHysJ1i
	 bcNFy+83brJvQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 3/7] mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
Date: Tue,  7 Jul 2026 19:48:49 -0700
Message-ID: <20260708024855.116614-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708024855.116614-1-sj@kernel.org>
References: <20260708024855.116614-1-sj@kernel.org>
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
