Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6625B0B8;
	Fri, 10 Jul 2026 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691225; cv=none; b=YHtamcAkX79vk7T17lLDFA+AZNZK6+ihT/m7YgJBNApjT0/+OpDYN9gqxq1Z7OvIEIIdyreAPtXC8G+UvY5G/6yl7YdMPocBfEQhW+vwHKCa2wVffmqyYv6Cp71RTltelGrEOSKByuL820cEpJJj6Tf0qFWRjxiXycjS7aexFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691225; c=relaxed/simple;
	bh=m097nX+o3GUQ1us51vIEofHr/BQDydOSq4G5qjcxZJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW1Nux24e7tfxKztNrszHTTKRwgs0FL11lcFtq6L5KqEJyZGUuNte/PYhNprgmBWSL4y9XRUIsNc0tCoE/n03iX2Rmal38hr6xBR7224iYITHfLXkb5jk2DtJ3Dtv7WrRSRa/vmjMkgbBVVuW/AEhWnhq8Ekbz4hsHofxlMcWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksQpn3Xo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksQpn3Xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298361F000E9;
	Fri, 10 Jul 2026 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691223;
	bh=J7ZtSpW2RnXSKPujLfG/ONrU6HhGNSKvAXYdnpd8R5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksQpn3XooyXtgVbh2itwhbSkyiYuLCCD2mosdPFGFU4SXeO0ieOfNZnvXiMVZjwbd
	 rhNRpgRuGwmc5qujiaBFyfqHttPfRubESbDw103op4z9jLEnxrnlImlMPk53V2re4H
	 N0ma6EvUOAkBjwRffgVYHOtANFWXjfgEA1bqbJEeNnOg1V0wIaWeBNByAllWdFHExB
	 PZQaxqLT/JOTACQ5LBldy8ATRdVBWPW2lDJA04fNU63xTcOGCJJeb8orWw5+e+1Pd4
	 aO/GDkryjXIver/KSmdaQDWAIq42YAvOPxwr4Gp1KS/Dq7KZdhewVboCTAwCTrLR8p
	 nRP5f5rS+Rp4A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/19] mm/damon/core: disallow probe_hits overflow on attrs only monitoring
Date: Fri, 10 Jul 2026 06:46:38 -0700
Message-ID: <20260710134651.18084-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
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
