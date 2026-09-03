Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB01E8332;
	Thu,  3 Sep 2026 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397424; cv=none; b=t5ZCYlQ14v7rySsFw0DlK6gC7LCESeCl+eSLqQ69jRnSFm1XAqM2ZhdvG1XYhFBA3AncdS+0+0d2ZeGZbP7221E9A3YZphSAT3B6Hh+OfgHgDu7n5jdNNYWHEv7yihegfgcqU+bD20HEdzJNP+VGCNIK1chDyNQJCPuXSHIIyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397424; c=relaxed/simple;
	bh=+w3rxutfnYBNIul7l279XZJ8W0YahLijvuvU2FVYbRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjgfqII7MvEwftmiIB1gTNAsYpw7lEVGJfHeKgShZ9ZTnHw1+7xGHWNKhtMnM6uJsriIA8Iku5zQg4wNiju4uda6sMRkbpj4bHA49bvrHnnnzZfbVkkvICU61NOsEPcWDcZ1pf/gVCVs0Vb/Ed3cT9irRVnRrgZq7mij7VazGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LodVKFzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LodVKFzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611081F00A3A;
	Thu,  3 Sep 2026 01:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397423;
	bh=a+KFNc38yAs5cF8y2PPkR2gfi2v/4V0wSG+v466VkTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LodVKFzm7cPA/XKyLRrziPacDwGJLlxAjosgz7vkLzndAd43UwGSSmeTy3nRv2M7/
	 P6Lstm9ApfK3wchi1TzvLIWDnUw4W2iM5ybBascq3HepMB8FEbtGlopObj8r9LweMG
	 LaSH7hLz0s1lSfUaTG+bgYyPiZFhCuyvAOGGcRSgOVvq+0OkH42gIyECD34Uzw6Xvx
	 +Q2MT8DiCFKURE+bUs4iEZnP9Ce3aFeFd06bLbXhJe31queYCqZM0u7jc1ZFAt/He+
	 vO+lzpR02gxrpahg8y4YHOto7X8/N5J72vykyibw7X9QMZeneaPHd2OrjbT1AERYWu
	 UQjWF0VZiOpJA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] mm/damon/lru_sort: remove unnecessary damon_call() param validation
Date: Wed,  2 Sep 2026 18:03:33 -0700
Message-ID: <20260903010334.93622-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903010334.93622-1-sj@kernel.org>
References: <20260903010334.93622-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT avoids passing NULL or unstarted damon_ctx to
damon_call() with its own validation.  The validation is no longer
needed, because the DAMON core layer now handles the corner cases
itself.  Remove the unnecessary check.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index bd847829a9907..f25ee7326e87c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -346,8 +346,6 @@ static int damon_lru_sort_commit_inputs_fn(void *arg)
 	return damon_lru_sort_apply_parameters();
 }
 
-static bool damon_lru_sort_damon_has_started;
-
 static int damon_lru_sort_commit_inputs_store(const char *val,
 					      const struct kernel_param *kp)
 {
@@ -368,10 +366,6 @@ static int damon_lru_sort_commit_inputs_store(const char *val,
 	if (!commit_inputs_request)
 		return 0;
 
-	/* Skip damon_call() if ctx has not successfully started. */
-	if (!damon_lru_sort_damon_has_started)
-		return -EINVAL;
-
 	err = damon_call(ctx, &control);
 
 	return err ? err : control.return_code;
@@ -422,8 +416,6 @@ static int damon_lru_sort_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	if (!damon_lru_sort_damon_has_started)
-		damon_lru_sort_damon_has_started = true;
 	return damon_call(ctx, &call_control);
 }
 
-- 
2.47.3
