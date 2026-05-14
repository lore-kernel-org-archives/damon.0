Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE13E639A;
	Thu, 14 May 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767760; cv=none; b=gvceWfJ+R1K9BcQg9v++FthpPnuktp6fQmmNtWVw54S5NnZODQ+vROeP2/XwEJRL36MMw5CtURQt6f0ndg5Y1IuiMKrRZAJzptsIVd9SAAOi8ZYPwweiuycuYBYU8Z8a0NKKzEZsLQqDrlHTA4PQhmkb2FawPmYtFTrOVYtGL80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767760; c=relaxed/simple;
	bh=T23N/ChU1TyBSEMb1nXX6ZXwE6Ou5N0n+X87B8zILMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im2vgn4PoZtA6L2Ax+2IEjt3wWmcnmaXKLMD4pZ0okxOMuLVlMDCYaro+1VejvQvwSi8/at2c1EN72Z5Ngixpo57K05DTrkf7C45ijyAkHs49KncmB50KD+GTnrNOorzr10UUjfud+A3z/Wu2dD0w++rCCZCQQgPG4RRqfx9v9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYYPs19q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYYPs19q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E84CC2BCF6;
	Thu, 14 May 2026 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767760;
	bh=T23N/ChU1TyBSEMb1nXX6ZXwE6Ou5N0n+X87B8zILMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYYPs19qHtcWiTw8LuehBBrlHddIwu2W18Vg1Ngs1HEB6UkPqM/Uy3KM/aHSnL2N7
	 23XWZxPbT9VLCXxWyzGP/SKX0P9KPhVPuR1BrXIHcs4YkQ4kYcflLjn+X+OCNNVOP5
	 hxg5FTdpHbHxfDp9QcTUJqSMSQkkiCQaAQL5uL3v9BfzTTKOytVBrermkUTvNBUZzb
	 CfWzWh9ffNUoRYX4/TKGHcBh137ysiW//kWAGuw+TjcYuJjHJTjz+oaqpr/Qhp3sky
	 Kw4bI6hBmDtqiohRCCmu8jxxcY/tKBPr1zcgASOYqA7+4KNolkGOChUeQYdOa3gJ4O
	 snRL0B8mtkYqQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 06/28] mm/damon/core: introduce damon_ops->apply_probes
Date: Thu, 14 May 2026 07:08:39 -0700
Message-ID: <20260514140904.119781-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
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
