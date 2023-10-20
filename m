Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D41200B8
	for <damon@lists.linux.dev>; Fri, 20 Oct 2023 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk1FqpYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5437EC433C8;
	Fri, 20 Oct 2023 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697822602;
	bh=Rn9BHGv/kMTRWnOOhqqlR6v0d9H0u3tnTjx9VDJfJCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lk1FqpYByQMbf59yh0U8YLgrRJ43zTSnfY5ztYkNwJxmOlrcYYzGMmulb64GWPd27
	 WDnr/ul64sOEPEBEX/FpDD7+OZxQ8uoE0Z3aJRmivH6ITsRSScdktkyKelkVw9EWzz
	 /YvbiC+RTKd5QA6LA86beLXArsehV6tLDXXWVWr1ZBYHK8TVlWJvgdQu8eDE1kLNFp
	 Y09FFWInvtPhlAqZAV2wcN8olPgLL4o0Xj8ujhKXQCa21H/maEShe4WpqSSEIrcXg/
	 zChMs5xWAxN9PsyWly2J4u8y1YAbo07mJij27Eu/Tj0CAYBsIe7S6DVGlYjXB2W8SE
	 DJbKUg/VjiXzA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jakub Acs <acsjakub@amazon.de>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] mm/damon: implement a function for max nr_accesses safe calculation
Date: Fri, 20 Oct 2023 17:23:13 +0000
Message-Id: <20231020172317.64192-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020172317.64192-1-sj@kernel.org>
References: <20231020172317.64192-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maximum nr_accesses of given DAMON context can be calculated by
dividing the aggregation interval by the sampling interval.  Some logics
in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
shouldn't be zero.  Such case is avoided since DAMON avoids setting the
agregation interval as samller than the sampling interval.  However,
since nr_accesses is unsigned int while the intervals are unsigned long,
the maximum nr_accesses could be zero while casting.  Implement a
function that handles the corner case.

Note that this commit is not fixing the real issue since this is only
introducing the safe function that will replaces the problematic
divisions.  The replacements will be made by followup commits, to make
backporting on stable series easier.

Reported-by: Jakub Acs <acsjakub@amazon.de>
Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 27b995c22497..ab2f17d9926b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -681,6 +681,13 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 	return ctx->ops.id == DAMON_OPS_VADDR || ctx->ops.id == DAMON_OPS_FVADDR;
 }
 
+static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
+{
+	/* {aggr,sample}_interval are unsigned long, hence could overflow */
+	return min(attrs->aggr_interval / attrs->sample_interval,
+			(unsigned long)UINT_MAX);
+}
+
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
-- 
2.34.1

