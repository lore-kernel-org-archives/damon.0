Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A236C5BB;
	Fri, 15 May 2026 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805896; cv=none; b=Vbl6/6ZHciJWfe/ExoPJH7h80MuDN5lqn4yAKRgIKp1D/H0YoA4qk4mvllydaXPUUcnKdsOH7EIZhksAbZdpuu+JuaAvai0HqcGHN+hVqG7/ydA1Sz4PduVT8672qsiRxJxKGibXjJH5z4yKzbWeDFNvpvMGc4jJiGR4lIeA/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805896; c=relaxed/simple;
	bh=sbbC6q3YAKtgRh2ZitI4ryLVhWoQrxzmSYGFabzMLLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKrgoel9layw4Y+c+iJRrdFmPx0UMEM80IQefxAEUzePbnDSfhFvJmhtj3SePemc8EHPOfVDdzqcoPlYL8YGaJ1RnnbYz3tKfgjFCcjREawoNrr9lGcd/vqP0vs6M2SpSlz+GxRufEEBiRZ4Myooui2g0j5C/ictmu7buRvOq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC3oQj9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC3oQj9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48694C2BCF5;
	Fri, 15 May 2026 00:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805896;
	bh=sbbC6q3YAKtgRh2ZitI4ryLVhWoQrxzmSYGFabzMLLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hC3oQj9nucKnuU+6YJy3FkwES2Ekotc861SToqurZQRNAQQEbK6C3g1dhrnogi2ti
	 unmbMOARtbZ6ZlrXPLu2EKdub0j5eeEYW+DsKOJMsu5s7envDrRkuArN/RLDd6joh9
	 v01FtwbwpUzCTCmyjW2Iv9JUvxmMu267nzcmwdeWszB0bZMQlOlWqPZDHcWOQKcqH5
	 6oxzv1Vl6E0TEjoms1r7mKIyargGkWYnv4RDAEQDPnNLABvnNw15DrMzrTZnPW6Rx4
	 tP0n4VmK4oiNY+tz5temFkHwYoI0pmAXjNipkBzlHb4AsShDfyQrTaiwqVOSWvK7qV
	 8pCswqSlx9a8Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 22/28] mm/damon/core: introduce DAMON_FILTER_TYPE_MEMCG
Date: Thu, 14 May 2026 17:44:23 -0700
Message-ID: <20260515004433.128933-23-sj@kernel.org>
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

Belonging memory cgoup is another data attribute that can be useful to
monitor.  Introduce a new DAMON filter type, namely
DAMON_FILTER_TYPE_MEMCG, for monitoring of this attribute.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++++
 mm/damon/core.c       | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 36a1162b6185a..c3ecb35da6404 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -731,9 +731,11 @@ struct damon_intervals_goal {
  * enum damon_filter_type - Type of &struct damon_filter
  *
  * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
+ * @DAMON_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
+	DAMON_FILTER_TYPE_MEMCG,
 };
 
 /**
@@ -742,12 +744,16 @@ enum damon_filter_type {
  * @type:	Type of the region.
  * @matcing:	Whether this filter is for the type-matching ones.
  * @allow:	Whether the @type-@matching ones should pass this filter.
+ * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
  * @list:	Siblings list.
  */
 struct damon_filter {
 	enum damon_filter_type type;
 	bool matching;
 	bool allow;
+	union {
+		u64 memcg_id;
+	};
 	struct list_head list;
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ab8ac9ec8450d..2d4a63dcc47fe 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1422,6 +1422,13 @@ static void damon_commit_filter(struct damon_filter *dst,
 	dst->type = src->type;
 	dst->matching = src->matching;
 	dst->allow = src->allow;
+	switch (dst->type) {
+	case DAMON_FILTER_TYPE_MEMCG:
+		dst->memcg_id = src->memcg_id;
+		break;
+	default:
+		break;
+	}
 }
 
 static int damon_commit_filters(struct damon_probe *dst,
-- 
2.47.3
