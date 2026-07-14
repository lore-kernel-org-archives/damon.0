Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656442E8B67;
	Tue, 14 Jul 2026 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003686; cv=none; b=SLQKG1KALYz1BiLoKKsOEzFklijwif1mspBePA1DSD3AYn9pynQmy7gTWTnbXzfJoydTLwNyeUE17wNHJqhUz5RUDvDlMZOPmnTdW185KjMk9vLHIiTDkjtFQK8/0z9yJODjaYoj1Nn41j4AdTQj+8V+pkGPM/o1QIoxbBi+FPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003686; c=relaxed/simple;
	bh=dRXX2J+TsX65dbJuv4S6AqbJqGvS7BCYhLBktYK5WKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5Wcxp5CicdufOYp812SRhxRYSok+PnbprVG8samCTXNoByef11e7Rp84JPoQUjE0nTs+xRAZRaT/sZNIhbRyjsYMIWAZSJNJoKv4j8Gi7IFPd544K7KcNKe+dJuApsfFpcex6xqd4+fmAIuEvvDBjvq9o10yDXHbOHuKi1l1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mod0YMvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mod0YMvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF2B1F00A3E;
	Tue, 14 Jul 2026 04:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003685;
	bh=UrQWXD0bifnsUsYgqcN+mYTdFMuNVs+95dSBQVBP0NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mod0YMvxWwnNieAilRhZlXa4fBY4k1B/jJ17n9UWCbmMi8tkIdmEXYbLd0hemF6zl
	 HxM2L6kryfF9ldwH07+K0/KgPRPkPiFUU4xuZSIjEvAdK6Bs5vjTA7Xn8GTtV0jaPr
	 +wJAGhSpxF0iREV3CuCo/s5JHxuGknG0grRFJYdh+PhcuKRCWH1G2c35vfT7cDjGgs
	 2jl5pUDv6kjRvSOtroA90n4qKz3x1JOGpv/XLQpTaDf8vvvzFR+/ANK7xoSGHWHfJh
	 j7DJ2TUof92FhIrcYDeuWCrxBfjHJ3b2irKbJ1dI384MzRF7eA8pui8BffCThCxpJ9
	 lLO8+QNGPv66g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/10] mm/damon/sysfs: do not directly access damon_ctx->ops
Date: Mon, 13 Jul 2026 21:34:35 -0700
Message-ID: <20260714043437.95811-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714043437.95811-1-sj@kernel.org>
References: <20260714043437.95811-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_ctx->ops field is intended to be used by only the DAMON core
layer.  DAMON_SYSFS is directly reading the field to find if it is for
physical address monitoring, though.  Use the API function for the
purpose, damon_target_has_pid(), instead.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 60a1a9e4ada34..228ceb4df5f97 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2051,7 +2051,7 @@ static int damon_sysfs_add_targets(struct damon_ctx *ctx,
 	int i, err;
 
 	/* Multiple physical address space monitoring targets makes no sense */
-	if (ctx->ops.id == DAMON_OPS_PADDR && sysfs_targets->nr > 1)
+	if (!damon_target_has_pid(ctx) && sysfs_targets->nr > 1)
 		return -EINVAL;
 
 	for (i = 0; i < sysfs_targets->nr; i++) {
-- 
2.47.3
