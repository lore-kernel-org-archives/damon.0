Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D93B8139;
	Tue, 12 May 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596620; cv=none; b=LIRUkw409zOMQxNY9xBFJXic7FQ8t+gMA3yNuIVueacGGRcjS8n7jesoPsw9IgcIbeuGgyq98P3N6TAWeVmH99gTBiOKNIOU5CDmzd7Fy1FfXE2vFgaG2txG3uqfGfM8sWpthKClhO9T0dUoTd5rxSQoqXAZloFgC6RJrNBruA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596620; c=relaxed/simple;
	bh=T23N/ChU1TyBSEMb1nXX6ZXwE6Ou5N0n+X87B8zILMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYpuuLtZtPbAbnNWHO8mcYV2UMld6bg3tuZBKlHgk6NhTBkGBzKRSIb7GoZS+9Yzh7bEx4SX9C0hW4StXJoP/mJx/k/nslhFZmSfja2LHPEh80GxfmVu5UsFKWsI92TpA1yU/EU929M5mq1rzwfOKyAe280/14VbFnbLKGIYJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gChnE+XI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gChnE+XI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD50FC2BCF7;
	Tue, 12 May 2026 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596619;
	bh=T23N/ChU1TyBSEMb1nXX6ZXwE6Ou5N0n+X87B8zILMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gChnE+XIXVjHYSTSrJzhzIrChrpMfeVc28ptzi1qVaYtsdly1g0MvYt9NX8MY/SE4
	 EO5ozSd5Ddxi/+iuZAhDTPC1AhW/aYGjPNmy3pGG0JbrI/s9VnHPWryKQ/oVzEuXXn
	 +uAQ9g54Qcg2TfbrLvHqr7o35pki/UWCjqYz9s13XxTxKAYJKULE1PVtQm+06fpupq
	 b+594UHL4Tx6rh+Vc6sLVqyZOqu338vNaLH18d2uwRlIs5vvpEQ16ZKy/qzQ/y3Pzb
	 yEmcCOi8fsiL2/18Mo86a1yZDrRi6KR1wiP8UBDzDAGpOZiq3zf2kIeYuGw5HPX31o
	 Ci6a2CeYyLHvw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 06/28] mm/damon/core: introduce damon_ops->apply_probes
Date: Tue, 12 May 2026 07:36:21 -0700
Message-ID: <20260512143645.113201-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
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
index 19b780bfab051..e9ca40cdd9102 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -630,6 +630,7 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
+ * @apply_probes:		Apply probes for each region.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
@@ -673,6 +674,7 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
+	void (*apply_probes)(struct damon_ctx *context);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_region *r, struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
-- 
2.47.3
