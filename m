Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93646378828;
	Sun,  5 Jul 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266966; cv=none; b=bK7PACWZuBxaigN3fYSAHOs/dcy6Vh1bErfJmguEnkXVRdyAyoevGvE2EHBE7Ia9TYCZvLfUAT9UCfGFQRKmZ7Y242PdvHCmcvKROSOye3TI1V51YUd3VlYgQK8qMFwU5l+EVXQBCTt/G0ae1UhopnK1ABG+k3kCZbU5sagXiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266966; c=relaxed/simple;
	bh=Kvg9OrQ43oPQ0781qqZUt2aE4b6/BWEXTvCLUXj9UDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlIh94U5MTtsLqZ7PG0UuMjFS+JjW5nJS7QHs+XZXEpV8QgRF3aQnV827tMYZTLMj6gFOuW/sLHwbyKRfKRzx9YZ9R0Q/f4H4yaoWenaAwv++bzWHDkMlnJMzemgfkKPN235/c+iY07EGXzUaxRmQ+U3L44TBsJEFdzxY+omi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUGyteFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUGyteFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524A71F00A3E;
	Sun,  5 Jul 2026 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783266965;
	bh=Y3unaNvAR5NVnY1x+9C1/8TjIcTr9Grgg5m5/eq+8dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUGyteFh2fFAb5tcklBMBqW+sSALFuDj6SxZKu2jo3cvRKZf1pA5jHZw7RgpvGkrW
	 tI1ON6VMz5kJWdqJHhHACJfn2OwPEFT8kqisFBumpz4lVDYdeVi8wltxf9oplhbDbg
	 MVvsjYC8nqFvxCskefyzEV6gmdhcQCxt/VNBaADB+lzzG2ivwiQ1qtXtz4LIWb36uP
	 h65fQI7WkRROkPAfueCYWjtvCDo3br7IEzLSD+BDbqSpbSowY3KyvP+9fGqvuOIEzI
	 AnhobfgLS7MUYP8irYX9H5Wig6FpZt+0fb7gOAGmyDE1MMMY0QMURgfBRktF5KXHpz
	 vWrClZtl+H+zw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mm/damon/core: do parameter testing commit on damon_start()
Date: Sun,  5 Jul 2026 08:55:53 -0700
Message-ID: <20260705155600.96555-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705155600.96555-1-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
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
 mm/damon/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 018dd5ff80324..ca301abcb9ec5 100644
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
@@ -1886,8 +1888,16 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 	int err = 0;
 
 	for (i = 0; i < nr_ctxs; i++) {
-		if (!is_power_of_2(ctxs[i]->min_region_sz))
-			return -EINVAL;
+		struct damon_ctx *test_ctx;
+
+		test_ctx = damon_new_ctx();
+		if (!test_ctx)
+			return -ENOMEM;
+
+		err = __damon_commit_ctx(test_ctx, ctxs[i]);
+		damon_destroy_ctx(test_ctx);
+		if (err)
+			return err;
 	}
 
 	mutex_lock(&damon_lock);
-- 
2.47.3
