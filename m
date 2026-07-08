Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642D23A9017;
	Wed,  8 Jul 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518857; cv=none; b=R+/897GyBSVpDvASBMLR6xVniXa3M2Ju8sHEj0gVsJ5Q4hcW67ziwNT3c2kZyV0GbmSDydgjQQsfViE811sW4NL+XXSIe8rh0APcIrw6OkIJAfTpnupaM2oZgVyreuss12sDA/PLC7vMnTB/CFWB8XI+Uj4YScreZn6sAoyTCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518857; c=relaxed/simple;
	bh=Rb6NbxjmP6P2KuwfZKGdkj8qrxwiVOFNJFX9NOhcYwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG/YI7tx3EplKldDGu9Vb0L90Hp61YYnyv0Es3GlmsawvDsr/DNayn9KeMTDDPawt9E4nsExqK+h8FuEoH/b0aKqp7szAm/KFDDxffAme/3J8JsNqbMxd1tBH/qjy4ixRW/dnd9zosixNMz7VH06MthDqDUvbsq8lJNeMzxWYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6x65DGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6x65DGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E62E1F00A3F;
	Wed,  8 Jul 2026 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783518845;
	bh=CNpIO+SPQXji8X+//JGLIeVACOioKXNsL/4ynMEtvQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q6x65DGGS/tT6/Mr0Okk5JH2CAITGHDYDHvuxBbfA3kmXINy8o+mGjeJJmasjB8gp
	 Do+wtskX4G/pOhLsLcqHp51pdiM/yRYowoRWo1BKNZyjQdbxJn11d8jW5uziae65Xj
	 4eF3b3mcj5oRxBosUCH76bQxk8gqlk64faCW182pdyjcKrIbd5pSloRgzFkIEbElZc
	 up2FBYRCNi+Qb+p33smhvk6w/A/GIp1jrqb8SKqFjmHO9tP4xqZ0z0B+Q0rf1jR9Fa
	 y3nPmCl/Jz1edwvT8xhJVwlMnDtyjuBvId+WKxjYKFqeLQK5wX6p41d4MxRPbN6E9t
	 SlYLSd3mFwmkg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
Date: Wed,  8 Jul 2026 06:53:53 -0700
Message-ID: <20260708135359.122587-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708135359.122587-1-sj@kernel.org>
References: <20260708135359.122587-1-sj@kernel.org>
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
