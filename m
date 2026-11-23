Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446798;
	b=hZhHvCRNtL/aCnTtVE9c5/5DLFrK8JhhsI/R9DlxpLyuFzF2o0cqGq5S440PDmLgS9oz
	 c12hhmaWiyZ7Ts20gFL2l8aUbl+YzEUHSuPoJAbOB6ki0/RaVQvOnanYTvQiN5jh2KhMF
	 DTkHCSSgTxegQEwWuKU0YuG0kKQ9OcToXXlq2CuQ+iq79iR0+osAgdlELCwY3nrSdSMxX
	 nCReMFgmFHmHWZXkPxZ0BA8+VUonaattsmbmWU69Hn8oKMp4csYR5poQeYoZLRPlClozd
	 BpR9KZ5tdISEvButw45lVCRrXzAOZDX0b72VzLbtbHu9u6KOeqeOxj+awg8z/8v5W7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mLxLJ8l0Ff3sL09Q96DcxX0CNZnNS+MEVi4Fs2AfUmE=;
	b=KhT4zjhxLyAfmjbCvKc08shbRIBCx4lID2crFn9of/zf2Zsl/a2kLLUzAm63Exn00f4J
	 YEj0P2a6FUiMSqvPBuqoavEu/g78ZnBI0LDdoTo0kL987pp0CVAYAHGS/LNWoG9/C0QUw
	 1xTlFep5vIHBbyAD9YUcEOWbg+l4ioIktecsMNlA2c8QL46p0AdmT6Vqo4u8S0S9FFftq
	 dWJWB7GVxrXeGa/CbDeS5u0n2EXmatCiuD5cpnbmN/lortBByjdyehBpCJvd19xTAHkIy
	 TF19gveqK1PrNdX+f9aGIlSgJ2/+14hnfPLyMBGGfYAgSNLsrwi9tdOQ7IcUfxLAcJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6IPU5uk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C6606A32A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6IPU5uk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3361F000D0;
	Mon, 23 Nov 2026 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446797;
	bh=mLxLJ8l0Ff3sL09Q96DcxX0CNZnNS+MEVi4Fs2AfUmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6IPU5ukO3vA+LUlcrhEnvvQFNumCquDdR3nGXDG/Y0gkprdJ/DBsdGnG4gh0F1+F
	 WaJN3CXG7bUCxnBU+ERr3gBF1epY0/BGg/VxqbfnpvnBXTCss8U7/3JNEk7YtsRFR9
	 6nVk1KGyUqv0AfAhDQ1EIxEZlWSdsCTIC6RK8xLwHd3i7Ka4+Srw/IaT+lAzdrOxVi
	 hkSeTnq/v9BjNpJWDe+dTwP7tU7boOOWbl3uKXFNwMQD/y7Ly70R3USNGy896mZBs/
	 j0IrXfWIJ6p3/xoGUTcNzQUb7FDLcpQ2j6uEh46pI15AcZItAHIHIiCEbvhjcNA2NE
	 WMmdYt5/Za/rQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mattathias Pinchover <mattathias.pinchover@uber.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH v3 1/6] mm/damon/core: introduce sz_ops_filter_passed_last stat
Date: Mon, 23 Nov 2026 07:13:02 -0800
Message-ID: <20261123151309.82675-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123151309.82675-1-sj@kernel.org>
References: <20261123151309.82675-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

DAMOS stat sz_ops_filter_passed shows the total bytes that passed
operations layer-handled DAMOS filters, accumulated from the beginning of
the scheme's execution.  Users who want the amount for only the latest
apply interval, e.g., the size of a workload's anonymous memory that is
cold as of now, need to keep the previous values in user space and
compute the difference with the help of nr_snapshots.  Because
nr_snapshots is increased once per target per apply interval, the
computation is complicated and error-prone, especially for contexts
having multiple targets.

Introduce a new DAMOS stat, sz_ops_filter_passed_last.  It is
updated at the end of each apply interval of the scheme with the amount
of sz_ops_filter_passed increase in the interval.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++++
 mm/damon/core.c       | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 06bd92981af21..3aff5c525132b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -351,6 +351,9 @@ struct damos_watermarks {
  * @sz_applied:	Total size of regions that the scheme is applied.
  * @sz_ops_filter_passed:
  *		Total bytes that passed ops layer-handled DAMOS filters.
+ * @sz_ops_filter_passed_last:
+ *		Bytes that passed ops layer-handled DAMOS filters in the last
+ *		apply interval.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
  * @nr_snapshots:
  *		Total number of DAMON snapshots that the scheme is completely
@@ -379,6 +382,7 @@ struct damos_stat {
 	unsigned long nr_applied;
 	unsigned long sz_applied;
 	unsigned long sz_ops_filter_passed;
+	unsigned long sz_ops_filter_passed_last;
 	unsigned long qt_exceeds;
 	unsigned long nr_snapshots;
 };
@@ -578,6 +582,8 @@ struct damos {
 	 * @action
 	 */
 	unsigned long next_apply_sis;
+	/* @stat.sz_ops_filter_passed at the start of the current apply interval */
+	unsigned long sz_ops_filter_passed_at_start;
 	/* informs if ongoing DAMOS walk for this scheme is finished */
 	bool walk_completed;
 	/*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 986404b547ebd..a99663f1f7ef0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -769,6 +769,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	 * or damon_attrs are updated.
 	 */
 	scheme->next_apply_sis = 0;
+	scheme->sz_ops_filter_passed_at_start = 0;
 	scheme->walk_completed = false;
 	INIT_LIST_HEAD(&scheme->core_filters);
 	INIT_LIST_HEAD(&scheme->ops_filters);
@@ -3532,6 +3533,10 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 		damos_walk_complete(c, s);
+		s->stat.sz_ops_filter_passed_last =
+			s->stat.sz_ops_filter_passed -
+			s->sz_ops_filter_passed_at_start;
+		s->sz_ops_filter_passed_at_start = s->stat.sz_ops_filter_passed;
 		damos_set_next_apply_sis(s, c);
 		s->last_applied = NULL;
 		damos_trace_stat(c, s);
-- 
2.47.3
