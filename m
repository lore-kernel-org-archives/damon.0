Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23E39866
	for <damon@lists.linux.dev>; Thu, 19 Oct 2023 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe6x2sCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F74C433C9;
	Thu, 19 Oct 2023 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697744970;
	bh=JqMVIy0mCbZQnCjtrYElDQM3Dsnc1xV+CtQNq7jTX4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oe6x2sCUCq4JfvkLqpDa4AQ+8p4t2drxdj8w0WFjYf1hxoNLFLp0vaQyeQ2Fc7j+J
	 2dPCch5ISN4TtP+cfgKjTVNCyIucKm3x3veg9XYIDq0nZ4dw4WO49I1KZAiEq6mQae
	 DH+2HwS7+ej8MoOkb74v7OTx04+XRrJNyzlFwsK2oquSwLQYbewr/2rZMAZXriQUMv
	 wP5LugNRndnmkqm9QCG3rgRkJd5JOb8OBuvRjAFkg4352A/MgAeCdCe0ZPxyuoju6h
	 Ax7kASeHfQQLqMi3wUh8GQTMqxg65h0B92mS1Cxv7gGLnvwDjOk4281T9dP7jqX7BC
	 19G38VMbA3q2w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/5] mm/damon: implement a function for max nr_accesses safe calculation
Date: Thu, 19 Oct 2023 19:49:20 +0000
Message-Id: <20231019194924.100347-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019194924.100347-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
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

