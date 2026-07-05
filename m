Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5751226CF6;
	Sun,  5 Jul 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267313; cv=none; b=dIl6gs34hN6P4OTXLS9IgGWB0sfuoZarcyOsIgvnBfqw28+S6Lhh3FgDZYXBBSbLEG6fQ2gyQlwgnQCAp8My/jHrzdMGgLnORU562s7C7AF0GPDaxj+LHHjEyhR0b4ukEGthy22dCgkFQ/g9ovLvMLA/DvRz4tK5aZx7wlCD7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267313; c=relaxed/simple;
	bh=2GgULBFQpYDO6EvdC9vnTe3kQ/SAYL9X8uFLgsMgTWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cca00ujV4cJffyWyoEHSfEJJokUh8cynko0FRGft3AaVRAPeNFSqhsRRkQ8IBpPA1JttMX57xj7QjZ1C7cftRHfTqZkkdhhzJ0U/HFcFlbrvJhx8S5Wx31lklgd2GblSJzFfSHuv/QN6tIMgS5VrS8sv0TRDRk+4ckQL4YD+m7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h74txumM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h74txumM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5ED1F00A3A;
	Sun,  5 Jul 2026 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267312;
	bh=D62Tcr+yrJC0pq2paze4YieMWP4BsC6k5oHO7N7uukw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h74txumMZpI38qJ+8ds0UgfG76kuq4dBZvZsG8oRgWixjR2ioLpnk9v+4nwkRD6/u
	 Xz/1eZvdTrwXEp4IMCyTg+Ggi1TtktKm8ks1QKoC9z991+u0bmNKeUBV4H9899SevI
	 AvbqFRnI03L6MGvKzOOwd+oGm8Wl8BzFMqwDcAsJsGL1EmfNaZAlib9Jb6ss9RQc9Z
	 4jgwI3zptmWQHxcDStl4E6VnC8qxhFVemG0rk/VVMHifvZPrtr/7NMoWTn8LmwJZD2
	 fNC4kU9jX8zspaQJ5CiwwClmIXnyRx2e/jwfzE7t2PZNPW9Bfsh/hug1pgWx/QR4ue
	 BJOlbYx5UQPLg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 02/11] samples/damon/mtier: do not stop first context for damon_start() failure
Date: Sun,  5 Jul 2026 09:01:29 -0700
Message-ID: <20260705160142.97308-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160142.97308-1-sj@kernel.org>
References: <20260705160142.97308-1-sj@kernel.org>
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
