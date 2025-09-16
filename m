Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46993CA5E;
	Tue, 16 Sep 2025 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993718; cv=none; b=IWECSYYtFZeRxR9YFKDsz6I1HQChY7T/GNZUtd/KTwjMATjxKelyPt3WcDteEoas3vDQuFwzOQ0tvtTec8HHF8SOkjtO/MxvlnXKv5hbemr5jbBBj0ZZjHT2HuEBx9seEpoOofWNHG5g4cZ1lHvcFCNlJ6RgxgoSs8YMDX9+D10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993718; c=relaxed/simple;
	bh=9JcNBf3R6YvBmotNSylUCQN1TyYW4gyunQci2uE4WFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQvA8PLXmx/IW8Kr2wOcWmXCt6ofUnMYdSQHGn6oXpuyRHSPf8S0+FMMuw1jRodOeM4jo87r3kgRZGK5l61X+WcEjIFegfaPzmj+yBFpLPIWoNWsPKKF3W4Ij9JCi5PN0JA2/6k2gV4BukhfNuO4cW9dNJCKfxFRft0nWCQEIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5leU4h2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5leU4h2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DA3C4CEF9;
	Tue, 16 Sep 2025 03:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993717;
	bh=9JcNBf3R6YvBmotNSylUCQN1TyYW4gyunQci2uE4WFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5leU4h24iIaQ6mZznhs9PW6jvp8aW8gZKhwvsdZb92V5iSdWE4qTRHkBXPc3DSlN
	 zf8/lD+fNNViNqCKK93TyvvbwHLPBUJF3+Gc3SzYGR1EY/n7VxH2Mkd5qsJseb5d3X
	 cy2kjGjooVQEZx/AMAxwPeysfx1rdiKEvykqzJ8jXW8euso5Q4uuqD+d919dr+HXZ8
	 dvntW0cZb1QExRthOwA6JBaPgI0uwI82JcchB/nd5BYH/Q7AMBkkmACjfcAA48toSF
	 Z/+/OaQ+E2AB0j661UN20M8C9o/mtPmEMy/PF+j5A4Jf60ut8zTIiRKvOmqMet24Tv
	 fBPY6Stm1IdMQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/7] mm/damon/core: implement damon_initialized() function
Date: Mon, 15 Sep 2025 20:35:05 -0700
Message-Id: <20250916033511.116366-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916033511.116366-1-sj@kernel.org>
References: <20250916033511.116366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If DAMON is tried to be used when it is not yet successfully
initialized, the caller could be crashed.  DAMON core layer is not
providing a reliable way to see if it is successfully initialized and
therefore ready to be used, though.  As a result, DAMON API callers are
implementing their own hacks to see it.  The hacks simply assume DAMON
should be ready on module init time.  It is not reliable as DAMON
initialization can indeed fail if KMEM_CACHE() fails, and difficult to
maintain as those are duplicates.  Implement a core layer API function
for better reliability and maintainability to replace the hacks with
followup commits.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index aa7381be388c..cae8c613c5fc 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -938,6 +938,7 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 }
 
 
+bool damon_initialized(void);
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 bool damon_is_running(struct damon_ctx *ctx);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 775121ae7a9b..93848b4c6944 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2863,6 +2863,16 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		r->nr_accesses++;
 }
 
+/**
+ * damon_initialized() - Return if DAMON is ready to be used.
+ *
+ * Return: true if DAMON is ready to be used, false otherwise.
+ */
+bool damon_initialized(void)
+{
+	return damon_region_cache != NULL;
+}
+
 static int __init damon_init(void)
 {
 	damon_region_cache = KMEM_CACHE(damon_region, 0);
-- 
2.39.5
