Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0073783BE;
	Mon,  6 Jul 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346799; cv=none; b=JL6ZcnXepMR8ClLIB+xSMhuOVJX0ljkSjFis2c5q/1jEWfPiyc9aiBKai5yjlxwrJR/u1hnTL4XYUKRECExPkfu1Qf+sUzNEAtu9pMQrm8/i5jujzMbx2J5lxo8rP1BmuVTf81O2BHLVhoGRMNAHihIINMtKG0CuXtOHz0+9Bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346799; c=relaxed/simple;
	bh=2GgULBFQpYDO6EvdC9vnTe3kQ/SAYL9X8uFLgsMgTWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMsHCsKi2xsDekpm+sGDk+AK7XZvlPNBwmaiXA6lKpJgsEjtTTAU3ZZAJl4VlPN3wil2kgAka7dOApBVbuTvAiI5CrI9Fcbl/JKTnuxnyoBmyVnEPcwM0N5laaKlzNHErh7pJGYH4HcQ34IF+RRtEVBl5S0u4BrrBjY45K25Vgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1pre629; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1pre629"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7571F00A3E;
	Mon,  6 Jul 2026 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346798;
	bh=D62Tcr+yrJC0pq2paze4YieMWP4BsC6k5oHO7N7uukw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e1pre629Abm3Wss18IAovngoVEas4lAgpSXEC7hslJUpIQxq+v0nsDGk+Djmvt6qo
	 4nNwW1K9ONc9yrmK7SqGuVbeophwH2MsOJpikH/EAWdbaxQ9Bqi+GYFgqSFRfNbxhv
	 Z6kmNcgKFtrzQrfNydpo4i/PLvYi7CvcLie8DXtGsgRuuverfxs6hL8kfIbEFSOBzO
	 v+iHpK+5r6m5OOg7DNLGbQYzVK2YHUgIyrfgI1LPYayodihtSFp+CNoP8R5Gfi8N4r
	 iZg29W1l26JDLsR0DecNqzcMrxDuSC7Nthye7IhvIcN+iHIxgnWAdS7vSYMPJ2PT1g
	 WqrZ3byWxaiBQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/11] samples/damon/mtier: do not stop first context for damon_start() failure
Date: Mon,  6 Jul 2026 07:06:17 -0700
Message-ID: <20260706140628.87414-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706140628.87414-1-sj@kernel.org>
References: <20260706140628.87414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_start() was able to fail while keeping the first context running.
mtier hence stops the first context in the case.  damon_start() is
refactored to avoid that.  The error handling is no longer necessary.
Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index e567f4edd80ea..90881e8bd441f 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -193,8 +193,6 @@ static int damon_sample_mtier_start(void)
 	if (!err)
 		return 0;
 
-	if (damon_is_running(ctxs[0]))
-		damon_stop(ctxs, 1);
 	damon_destroy_ctx(ctxs[0]);
 	damon_destroy_ctx(ctxs[1]);
 	return err;
-- 
2.47.3
