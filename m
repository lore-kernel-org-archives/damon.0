Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0F35E1C0;
	Wed,  1 Jul 2026 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917307; cv=none; b=CBtuRqLir4xHdUOq9QPZnwJWd/rXBGNTGQ72U0UvM4lHZ2R7Yv2OFBRywumMfRhXhfFohMpFUHwy2UAlpVW1I/+iEhbEcmFrtd8JWn+LhlXUsMNdySEwwYdHyDOjE/wJg0lcE2zai59w9df6OSllntA8jAzXnF20PP7UO5M94Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917307; c=relaxed/simple;
	bh=bVI/yoXGy31smQ7HrzpZhw/q4TPXvx89CW3lmyFpUZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNlMS7LiPCvpwqJnCOGoME+53S9aU5mTksCoLVhq6bY8MXA6XI3x/dqEsIrfzuGgdoKO126gFNawab1rL4P5Rkf4um7Ylty/wcpplyOkttTyhoO/vlboc6+bb4uWjSSaeGqgg5GT5von6rN2d0mRWwl8DokpUBouakswP3I3v0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEFCPSeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEFCPSeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF03B1F00A3F;
	Wed,  1 Jul 2026 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917306;
	bh=z4feI/qU1SbwMydOJY76MHjKjfYHnoO820guZYu+4uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GEFCPSeLYMw1PQCmlpe9SPIj0AO5UrrMtNr1mhwwq+tIRgEPxBIfwU5aNCkorbFeA
	 JuLDYfKDA4DL0OdXoj4pcwl/hBnMZM0B/dOplIrc9Ei7t7g2CL2uUpx7brhIVijwk+
	 4szMC2LEcrKAjixcKHiIvFwF5ncWDeWcwE50sxE5774S+Xu8BlNq+XbPa5x8N35a4L
	 LQ6NOUWX6nqdYsaZgpvrEmKtk/kw5DD03rdS/ba67Ng6Wgtdpx4bbU8mN0KNxNWhBm
	 I6CA1Eh1MGdoZ0tJNJBQzDac97oQHWruQvEUcOsqSI3z/BA2sM9S57zCwewS9bogbc
	 Ug/Eb/2Yje0Dw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/8] mm/damon/reclaim: remove duplicated min_region_sz power of 2 check
Date: Wed,  1 Jul 2026 07:48:06 -0700
Message-ID: <20260701144815.113325-5-sj@kernel.org>
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

DAMON_RECLAIM validates the user input for min_region_sz.  The same
validation is done inside damon_start() and damon_commit_ctx().  Remove
the duplicate.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 11b70d0a9a6f0..6469b25cc34f9 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -208,11 +208,6 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
-	if (!is_power_of_2(param_ctx->min_region_sz)) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.47.3
