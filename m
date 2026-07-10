Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14821ADC7;
	Fri, 10 Jul 2026 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643043; cv=none; b=dB2iDO10o7IRP+PtgtP6OOPyocTveUZN+qruXSwuFUoXGSPgd9gpPIyrMkMDoYny5YbUISvSQICgHwspajrsxNQT8WafifgEDqQq0hmuk0WPlE9eTAyEcirGstzLd/nqTEUO9zeM4gseYewmbcAChrDoeA1iMCmmO4jZbvNsVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643043; c=relaxed/simple;
	bh=m097nX+o3GUQ1us51vIEofHr/BQDydOSq4G5qjcxZJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzuDzLP7wL7ndZa6zXUidB0suUJc1HiXPPM2lxunVnXHTU2uBA8fAQ+SU74X1IgSruskrqNagvn4kOmv/A2NMyhDTd8st2OBT/h4iLyDCq83sPhlZ1f59FeVMQDEJrYBAF9ExAdqAaLATnL5TGH7+bRtw1DQ8A4iw9VKLGSCDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHhIGjxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHhIGjxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CFE1F00AC4;
	Fri, 10 Jul 2026 00:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643041;
	bh=J7ZtSpW2RnXSKPujLfG/ONrU6HhGNSKvAXYdnpd8R5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eHhIGjxQ/SBTQe5GOFzJmg5SSu76kqF82hukxoUyNj9heJzJYpOp83k5Vv9QdBxP7
	 Pmk+0dNKugklMrqYnicNpAOgZbLlkiaXSHtuIFDrt7C69Uf5TYT/QjTF5aWxAdTZL/
	 rzSoc036QhS9VedxsWAzsy0sZkpFwmagwUl0TPEDxGfILG6J391E8nC+AuWUweYb28
	 T3Mt1uIRzWMgqlg3zI7TAp6k4tz+fewkGxnIXsN+FoYUFM8Ff5HYj6K5bmtYC0L048
	 9GlBQ6rebhzaVzP2N/PXD+PVkdLhpBbuGP1tanG4g9XxaMjHHbp5pvp7oZvwDlPhic
	 JEI3igjw8YT1g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 09/19] mm/damon/core: disallow probe_hits overflow on attrs only monitoring
Date: Thu,  9 Jul 2026 17:23:35 -0700
Message-ID: <20260710002349.111414-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710002349.111414-1-sj@kernel.org>
References: <20260710002349.111414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When any damon_probe->weight is set, DAMON will do only probe
monitoring.  probe_hits is 'unsigned char'.  It could overflow when the
aggregation interval is larger than the sampling interval times 256.
damon_as_probe_weights() always return false, so such overflow cannot
happen.  Even if it happens, it only degrades the monitoring results.

That said, the overflow is not intentional.  It is better to be
prevented as long as the cost is not expensive.  Disallow the overflow
by adding a validation logic on the core layer parameters validation
function.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7d49420ea26c4..4f1425e56950b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1332,6 +1332,19 @@ static void damos_set_filters_default_reject(struct damos *s)
 		damos_filters_default_reject(&s->ops_filters);
 }
 
+static bool damon_valid_probe_params(struct damon_ctx *ctx)
+{
+	unsigned long sample_interval;
+
+	if (!damon_has_probe_weights(ctx))
+		return true;
+
+	sample_interval = ctx->attrs.sample_interval ? : 1;
+	if (ctx->attrs.aggr_interval / sample_interval > U8_MAX)
+		return false;
+	return true;
+}
+
 /*
  * damos_commit_dests() - Copy migration destinations from @src to @dst.
  * @dst:	Destination structure to update.
@@ -1736,6 +1749,9 @@ static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 		}
 	}
 
+	if (!damon_valid_probe_params(src))
+		return -EINVAL;
+
 	err = damon_commit_schemes(dst, src);
 	if (err)
 		return err;
-- 
2.47.3
