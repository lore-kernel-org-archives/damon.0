Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96B346A08;
	Wed,  1 Jul 2026 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917306; cv=none; b=dpS30Ygmty3XbPZRTvQ6Dcx11WBKlFueh0i2zD4IrhXNBAibTDOPc59EY1Mfz3/8Omh5+s1hEvJoKubN2Mo7SP7trZW8f8iGJysW3765jW/NLblVO1VEGxCaOVhnEl4iPdvOEwwwoFaBbAzLV6dogWEQ1a8wehieH0B65J+iCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917306; c=relaxed/simple;
	bh=xCLqLgCKNFM7OsXaNMsFrof3DinIEFuKuI777DOc1xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2UJuFPJb7wkWnfuHpJspOWQya67lywwADWFx2C4VcJfFFcM+NAOJ+9BfCsH5fONXcuBhzF1KPMOrdssg5VF60td0caZOzXirlXWyNJCd8DwQmmHc+LYYaLgATcKlCdW7oX+6Y6PwmJ49aDTPuqGsR+xEhGDT65fPZCZl+0Jk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLZIGe82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLZIGe82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FEB1F00A3D;
	Wed,  1 Jul 2026 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917305;
	bh=uB0wjQbyJXJs6+1FcBUr/5yMvVVNvbMcMX8+dR3IIh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QLZIGe82b/josKxLiOhAusIeVZJoAGnTrd00a0d2IdpjQgIvJNp+is5Ssj6bOTZX4
	 LjNF6iqyVepf//2C8ENpA4PVGNynpwFKZSZ5g7gsaSj1Y8xX9JLsynz9U+pM+x4bV0
	 08c5TpAHmtrF36vG02rWE8O9rB7d0MSCieMtjqXH1I/SvhelHEmQDC1LQONDBmX8sr
	 E75iT+PPLEY5o4hKmETz8CDRggMeDQUC8avRVCIbJof2SOc2vbS/wliLfk3ro1qqpZ
	 0wi2TextAFx1jl1x0h4z5kqOYyvoFauHoHugdC+FSu+Wt+/0/AYSMAR5nUQj3zPJzy
	 L/nmZUT701chw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/8] mm/damon/core: do parameter testing commit on damon_start()
Date: Wed,  1 Jul 2026 07:48:04 -0700
Message-ID: <20260701144815.113325-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701144815.113325-1-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_start() and damon_commit_ctx() are two main DAMON core API
functions for setting whole DAMON parameters.  While damon_commit_ctx()
does holistic parameters testing, damon_start() just believes the caller
validated the whole thing.  Embed the holistic parameter check that is
already in damon_commit_ctx() into damon_start().  After this change,
the callers can safely call damon_start() without validating the
parameters.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 62c27002219cd..6b30cb6007e54 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1865,6 +1865,8 @@ static int __damon_start(struct damon_ctx *ctx)
 	return err;
 }
 
+static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src);
+
 /**
  * damon_start() - Starts the monitorings for a given group of contexts.
  * @ctxs:	an array of the pointers for contexts to start monitoring
@@ -1882,13 +1884,22 @@ static int __damon_start(struct damon_ctx *ctx)
  */
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 {
+	struct damon_ctx *test_ctx;
 	int i;
 	int err = 0;
 
+	test_ctx = damon_new_ctx();
+	if (!test_ctx)
+		return -ENOMEM;
+
 	for (i = 0; i < nr_ctxs; i++) {
-		if (!is_power_of_2(ctxs[i]->min_region_sz))
-			return -EINVAL;
+		err = __damon_commit_ctx(test_ctx, ctxs[i]);
+		if (err) {
+			damon_destroy_ctx(test_ctx);
+			return err;
+		}
 	}
+	damon_destroy_ctx(test_ctx);
 
 	mutex_lock(&damon_lock);
 	if ((exclusive && nr_running_ctxs) ||
-- 
2.47.3
