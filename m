Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8226FDBF;
	Fri, 10 Jul 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691225; cv=none; b=hWV0WSdPsACPKfCeCKJlzu/cYqi8hiwhCzD9SOTwjxOUcB6UeE1Eryvn41z5znYHa6dztALWKi5MJP0fnLvZQ0BNTheQ4Bd8IoFFWNKFacRPDdHpSXrmEDXLQdxVjQcGGYfTUqcNVztfg/nRnglI70vujoD1zSMnH0k5NTiSX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691225; c=relaxed/simple;
	bh=FUDNH0eJrLDSAAVi3uFy4nNHyMaqRcjcKNmGkrxGyKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwUPX2RtS+SEPNYeL+ZIA7X/2zljTlU7D13ZVup4e/Qp2p8n7sDil5pe8KfnotPyCVlEg+V2AWGzmQDOsYRTJEvB7fxEX6kLhWU5uxDn35lBiCWwxUCTxI3d6e7zLdiZmC+lxbQXotLbmuzIp/1pNUXP5jenWRD2xcZMGGmveWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAb63wrG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAb63wrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE6C1F00AC4;
	Fri, 10 Jul 2026 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691224;
	bh=gcmh3CO5nLFI9rnEGlo1ly2IEXcDgUHS1nJW1mHJiU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAb63wrGcdyPVzWcGEsZr/VhfWy51Kg4BNHyrUHPNheYf7pyRR6LjnpEy5NHwy0eP
	 meFzkD0wazEIBoI6hu7jaI/OPmZrpR0/Q7EElkGDDgiPGFa1GQPPD44Q3zk+irK6gM
	 FoIYFEz/pZ6OHtUXJEE1SeWh1eIs4zE7ZijlP1MzCiA8TbDl8ZEpQmoaH9DJbBCrsE
	 24eQJuikFqxA24dw5aIH+eMlWsXah5JNAxiIf1nnc1v0SgUE3EpTVtobgZfI5oHW4j
	 pjzt2/xnqCBJ3GDNpq1smbfDeLtAhAKruZTR7/RFmDBQFPgBrt7JJe1+Zn7mmXDOKf
	 ElYnn2cQKNdeA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 12/19] mm/damon/core: set samples in apply_probes() if probe weights are set
Date: Fri, 10 Jul 2026 06:46:41 -0700
Message-ID: <20260710134651.18084-13-sj@kernel.org>
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

When probe weights are set, the prepare_access_checks() ops callback is
not invoked, so sampling addresses of regions are unset.  Ask
apply_probes() to set those together in the case.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 65f91e3b58d2e..dd0612e1a408b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3777,7 +3777,8 @@ static int kdamond_fn(void *data)
 		if (!access_check_disabled && ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
-			ctx->ops.apply_probes(ctx, false, false);
+			ctx->ops.apply_probes(ctx, access_check_disabled,
+					false);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3
