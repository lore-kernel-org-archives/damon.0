Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AB23BCED;
	Fri, 10 Jul 2026 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643044; cv=none; b=hUbEwsVVai7b8daPOB8+e0+FIyXu032pdRUuA3c9XIWoDU9qzD1sGKkb5RdLhExWBDL223y5xfpeWwKE6DZiPX8EXa+wtGCTvbXaahwYeYiRV30E6awxyr/GY9BOqmYuDPf8ExtIWcRixdkxEcBGl+obiao4nOGz+rIZsCTuogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643044; c=relaxed/simple;
	bh=FUDNH0eJrLDSAAVi3uFy4nNHyMaqRcjcKNmGkrxGyKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KL0KMe9drqJ0wUxUjDm7ufo/0rPTt+uzZ46e0Sj03Jxrovaz2GEIqUI6q1OL914wA4qPpagoqeJKHl1F7zzIut2iothuARTxIKIAWQXlWhfMduieyVSCod+q2jLQxiSAgd6dcTBW8SqvtN/xu58tbZ+Q/2NbJfaepWSPmtuEkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmw8spaI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmw8spaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC3F1F00A3F;
	Fri, 10 Jul 2026 00:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783643042;
	bh=gcmh3CO5nLFI9rnEGlo1ly2IEXcDgUHS1nJW1mHJiU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmw8spaIEiOHr9fuXewgQ8ToRh/yCTyAG1cYvF7+JCpMEds1D/AgzFKm1EW0R3dbB
	 YHKLnRgSQjp2A9/HF78rGjPsPkUOh9R8zmpM11+eXCTetdfcz/CRTew1GOR4qHraBe
	 wHRzLCqG8yN7Nrs4Cp40EL5uJq6e6ZR5YWDi0jdtPrINW9R4+EK92MFdQ8Xy+rJw5q
	 8k4Pkg80HldkibWY6dbDO2hKJP/ZqUZ+x9YTOeMUXOompcFi/M0XrcrgyVuqQnWajJ
	 b3rNwM4Y02UOhymsFoq/80ibELZMOLGooxdr9Ruk2FvBIIqmDkbEFDmBm/oH+uifXH
	 T4+6pMdpIloog==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 12/19] mm/damon/core: set samples in apply_probes() if probe weights are set
Date: Thu,  9 Jul 2026 17:23:38 -0700
Message-ID: <20260710002349.111414-13-sj@kernel.org>
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
