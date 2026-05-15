Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0735AC09;
	Fri, 15 May 2026 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805888; cv=none; b=Uhug4FOtmrS6jZbI/0IWFK924HpyeO+LELDvZywwcRg+5X7+GZtt6iqUinpB3eVQ6dDWZS00kETVCqCRaa8aXrRhb17lCRgnxoNic/FgEQHypTVUcfq7oHScU0c/vy+KI76WvEqc+iPXVdlAQns8JTQZONhhmAVPDRNcJCMCMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805888; c=relaxed/simple;
	bh=RGEbpNfLmShGll7r/qhOT15wBkdAJslIsAuiy+doplM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Utgf6x3YCJUGcpdLReF9b9LNZ0rS24PbUDshdNm2Wf9opIHjgxdemQo394GOa2DabUqIGmA4HZjppoalEBs83+d1fbnRKXzAvRj2KZTdlQYA9qhf2EPcJ2WhHUF+mcphMGZBvTY7cnv0G3FcLBYCWxXw4kaDhvCYh2S+sbUACM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4plHV+z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4plHV+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51A1C2BCB3;
	Fri, 15 May 2026 00:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805888;
	bh=RGEbpNfLmShGll7r/qhOT15wBkdAJslIsAuiy+doplM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4plHV+zvCHT+StkDPdBBZvBwiNjctrHdOjsCcnY0UeVvnFiaupCWwQXzPFzG0sXr
	 /cA71aZ3g+I7zcPohcXC27wMJoQRyo0wsqFY7tdl87FjyCfhPa2+BryYJldO6hD5Ed
	 zD5W1sLC2YchBOmHBT5Q+3X0cE4qpOfR4aZbSRsKrgTly3VzgahdpqJE6dHCKxQF+y
	 05RdKOqONQuUcndlANvUKb9RQFV1Tg9BIYJX1HbQN/8AQm7nRpGUoW8jXMRs20qo9s
	 GnuYeJn44Z1yN+zFk+SncLuBAwQ+18N8RyQR9PyUtVpGkVowfNVDspkFYaORGpdNDa
	 0gcPT9ZxyPmUQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 06/28] mm/damon/core: introduce damon_ops->apply_probes
Date: Thu, 14 May 2026 17:44:07 -0700
Message-ID: <20260515004433.128933-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
index bf78ad849a9be..36a1162b6185a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -621,6 +621,7 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
+ * @apply_probes:		Apply probes for each region.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
  * @target_valid:		Determine if the target is valid.
@@ -664,6 +665,7 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
+	void (*apply_probes)(struct damon_ctx *context);
 	int (*get_scheme_score)(struct damon_ctx *context,
 			struct damon_region *r, struct damos *scheme);
 	unsigned long (*apply_scheme)(struct damon_ctx *context,
-- 
2.47.3
