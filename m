Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576833C195;
	Mon, 18 May 2026 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147686; cv=none; b=GsP5XatX9gzmr/weCJ9M8rxEdfoMThZEr0QvmGqR62IGH0T19K+dfUVBJ4O48mu/H2oU9Amyi350yKiMJM+FfrTD+/pEE6zcYRAn9DxAClSeOjzHiL+dZW2c4Mwsu14rHZAzs6IBUacL7NAZr0WF6JtX3RIzXkryQIiVkDMRsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147686; c=relaxed/simple;
	bh=bFwyAkRlbSFnPcn2Zfz8Cw3kNquyafjVVoSte7BT/A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZncC3CEcN2xigSPtwfedN05V4920HV+MPEUHBoHJ0wg/cXM1RwGlAXrz18cz3eQJpkLnypWdv9zA2K6KDgezHByUfxDJAL+50P/WiJSyB8F8qhjIGLBEAEJPSBDGBZj+UOGsBYQT/emCOHQo8wBaw3+6R3ZnrwEqf5rQuxVFXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzT2B5OG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzT2B5OG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EEDC2BCB7;
	Mon, 18 May 2026 23:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147686;
	bh=bFwyAkRlbSFnPcn2Zfz8Cw3kNquyafjVVoSte7BT/A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzT2B5OGWVhM6vAI/ZvXSIwb2csxeZ0L+L4eExWE8BlEiYxpultu72EMZcoLHfd6g
	 te6ZppepUwfP+VkZrELQpy+niKvkH3KjJjkt4dw55AUPuOSLiNn/hoYK3hjl0gRYJP
	 K1jvrYUASEWvFUOyCEg1keJE/akizF5DKo2bjW2SPClb/91IA9OGZ1SzHFFGAPYplb
	 fj4OpGpGQkMSwpPLZhZBe097JRS/uFj5TbQ/uGOSPddNkOmYsRGACqEbCVjkKUpE+/
	 auWI5dwWoSyYPF3aphwlI/gwp9CemEpe8IpvcDe3de6MRbjl0gsSfN2znMFAzOcbmT
	 yx4EbJItohhxg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/28] mm/damon/core: introduce damon_ops->apply_probes
Date: Mon, 18 May 2026 16:40:54 -0700
Message-ID: <20260518234119.97569-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend damon_operations struct with a new callback, namely apply_probes.
The callback will be invoked for data attributes monitoring.  More
specifically, the callback will apply damon_probe objects to each region
and update the per-region per-probe counters for the number of
encountered probe-positive samples.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3a30af119ac6e..1fb271a35e98f 100644
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
@@ -656,6 +657,8 @@ enum damon_ops_id {
  * last preparation and update the number of observed accesses of each region.
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
+ * @apply_probes should apply the data attribute probes to each region and
+ * accordingly update the probe hits counter of the region.
  * @get_scheme_score should return the priority score of a region for a scheme
  * as an integer in [0, &DAMOS_MAX_SCORE].
  * @apply_scheme is called from @kdamond when a region for user provided
@@ -673,6 +676,7 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
+	void (*apply_probes)(struct damon_ctx *context);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_region *r, struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
-- 
2.47.3
