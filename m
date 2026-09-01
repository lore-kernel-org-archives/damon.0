Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BE480961;
	Tue,  1 Sep 2026 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269118; cv=none; b=cYCStFHSu/HdJGHepe3N+WQAWgm7P2D1Td76TibpjTsP2fOh6gBgQapkWeahEHrD9dRWXrAzJCGdDHcidp7BWTf6bbMJkC4YAb+nEyQn0byH//UIOEcdkTJmqAOFF0RAJ7OVCn4cMSEN9hS7OljksxY9AkkCZSmOc4QKIDurjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269118; c=relaxed/simple;
	bh=bYnhZzmEUV5gZA6RShFmEAIvutDPD7sX7y/nXrffjVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9lx+dQELvbHqhgZB+HB3CWKBqhSRkSX4gOhASVIchJ/lzFNNYd/qciVsvb3NJK59xjmoHSKUZgQKO7kGxAEvd3WIrZPmE0OZd9RjEkJQy3HXM1dbaHYtiU7S6qrRX0N5ERGBq/sjilNPyd5qjrB7EswyA8EcxXV3xDJvhY9vE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjHZ25Oz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjHZ25Oz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43551F00A3E;
	Tue,  1 Sep 2026 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269117;
	bh=IMsa03+GswfqkWjEdLMDvVsbH1S2RLUAm5b70sXm7PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjHZ25Oz9d82f4iu/ntoDLNgS2VHC5AmV6rh5E+Cdfgc3to7+yhLlvPEX2uChGZMo
	 R216F4gJzmaXRU/IB7ICEXe/Ksp5KLkNhyYIjR9PS1bWyF3EfkAN2Hc5Cqyfe3JkNa
	 orR7HlexcFuv7sl1bPktoBgTSYCyILVo1o8TPSQvfMqkXQIi/6oeEqtb9jY7YZiRIp
	 WhFjaHmYv1dYJfBY3Nec64S0vQ/zkfPTumWbhy4IDWr+AW4CUq7ljK0x80qyYrGnmV
	 JVqhyGLeIwJRWwDyfT931jmnYop3PfAVz267XUQMS2TKFZGcXa80Pnpo1xj/C3b7V+
	 SUrGZXhWZKFbw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 06/17] mm/damon/core: commit preps
Date: Tue,  1 Sep 2026 06:24:53 -0700
Message-ID: <20260901132506.99243-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_probes() is ignoring damon_prep.  Commit the prep actions,
too.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 85774dbca64b8..87ac428358ec0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -129,11 +129,34 @@ void damon_add_prep(struct damon_probe *p, struct damon_prep *prep)
 	list_add_tail(&prep->list, &p->preps);
 }
 
+static void damon_del_prep(struct damon_prep *p)
+{
+	list_del(&p->list);
+}
+
 static void damon_free_prep(struct damon_prep *p)
 {
 	kfree(p);
 }
 
+static void damon_destroy_prep(struct damon_prep *p)
+{
+	damon_del_prep(p);
+	damon_free_prep(p);
+}
+
+static struct damon_prep *damon_nth_prep(int n, struct damon_probe *p)
+{
+	struct damon_prep *prep;
+	int i = 0;
+
+	damon_for_each_prep(prep, p) {
+		if (i++ == n)
+			return prep;
+	}
+	return NULL;
+}
+
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow)
 {
@@ -1706,6 +1729,36 @@ static int damon_commit_targets(
 	return err;
 }
 
+static void damon_commit_prep(struct damon_prep *dst, struct damon_prep *src)
+{
+	dst->action = src->action;
+}
+
+static int damon_commit_preps(struct damon_probe *dst, struct damon_probe *src)
+{
+	struct damon_prep *dst_prep, *next, *src_prep, *new_prep;
+	int i = 0, j = 0;
+
+	damon_for_each_prep_safe(dst_prep, next, dst) {
+		src_prep = damon_nth_prep(i++, src);
+		if (src_prep)
+			damon_commit_prep(dst_prep, src_prep);
+		else
+			damon_destroy_prep(dst_prep);
+	}
+
+	damon_for_each_prep_safe(src_prep, next, src) {
+		if (j++ < i)
+			continue;
+
+		new_prep = damon_new_prep(src_prep->action);
+		if (!new_prep)
+			return -ENOMEM;
+		damon_add_prep(dst, new_prep);
+	}
+	return 0;
+}
+
 static void damon_commit_filter(struct damon_filter *dst,
 		struct damon_filter *src)
 {
@@ -1764,6 +1817,9 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 		src_probe = damon_nth_probe(i++, src);
 		if (src_probe) {
 			dst_probe->weight = src_probe->weight;
+			err = damon_commit_preps(dst_probe, src_probe);
+			if (err)
+				return err;
 			err = damon_commit_filters(dst_probe, src_probe);
 			if (err)
 				return err;
@@ -1781,6 +1837,9 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 			return -ENOMEM;
 		damon_add_probe(dst, new_probe);
 		new_probe->weight = src_probe->weight;
+		err = damon_commit_preps(new_probe, src_probe);
+		if (err)
+			return err;
 		err = damon_commit_filters(new_probe, src_probe);
 		if (err)
 			return err;
-- 
2.47.3
