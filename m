Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818448;
	b=KAIzOMYbT49elc52B1K6qU+BaHI7BTzRmBARew1zuHzyo5amutR01yl/mYeLuKQY1lKJ
	 m5lOQg3rZuUrjJBmwJsjRPvsb41zO0G6S09GX7yrE5tlHCHKQ0caFG2Z/WOjxn64WC7BY
	 n1awGzDmYTAP4sDLY3RNj6YIIEMfCXxeKEs8aJS/ev+jA5S0N027HNz+OQuHTZVFe7Fge
	 3dgSa3c35w4OIuizC3E/8Fz7OKSEf2ZTbbltG8Kjfb3Q6o1V9cB+t882o4ULxh1k1m5VF
	 5wCyo+O7NXIleTRma5mvVwfjy6GNNgnO9J29bsaaf+N6fwXbyjItkT0Cb9H3PsJ/BQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818448;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ACRfM9U2ztel2rfr1ksCVqjT/nvZz93T+KydwhCu9s8=;
	b=gBJ+2yBUc7sT+p7A3FPr8r0BuAedFupjr+mQnqKndkfCAx2ulD5+ylD35qXtruipZybQ
	 rSXzbCplTPgFx92x3v2wMN1CDuap1IECBLD0sLXfUm8kojyetgyAbNhptv02hs0kMAksB
	 wtdQ02GbGwM9CPF9xJwYotNqFP0aghBrv7K25RSlR/9r5Vus6RBqhLhzfmGX5BX3x4sv9
	 D17aJtqiNknzCpHjOw4FLSxt/bxw34LqeyqO7TlqqetIsyLf5kdx1YIyhFcO2x52Q8p5U
	 fBEZeplyV74eRlAkAFzGsVd8q02os89U69rsB9F81/PllHG9irhoRmse18pzq458yTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cImsLGCP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A88F606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cImsLGCP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571A91F000C1;
	Fri, 27 Nov 2026 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818448;
	bh=ACRfM9U2ztel2rfr1ksCVqjT/nvZz93T+KydwhCu9s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cImsLGCPLUklWtjQAlQSVHslpdhQFh5EKqK7zGSJT6JTJA/q2sRpLueYWy4UMiSKD
	 R2bE698uWio9hCwx79zG6DKiDt3ZGQpur6MQcxYCSg4WDFHO4jrfh/qL6xi+npRPOA
	 okpheVbxNtdqv1NuaHm0zazL/5Bk0B0JChNMijA0bKdwXIJIY3xlLfZGd30+zcqn9B
	 Pd3nznDrOJmaGYaGao2Hmm3/L9eFrI5JXKTDjUrY/gXk4EbBhMSmHzEbKWLA6xcSQb
	 zdf1+Qg4zhreG3hfKlI6507dNVr9fXCc8xYtTQywq55O8ZX29wnze2oi7Xn1nOYF1u
	 heknTZPZgM5JQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 4/7] mm/damon/sysfs-schemes: drop redundant and racy zero target_value check
Date: Fri, 27 Nov 2026 14:27:15 -0800
Message-ID: <20261127222719.105510-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127222719.105510-1-sj@kernel.org>
References: <20261127222719.105510-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface disallowed zero target_value because it could
result in divide-by-zero in damos_quota_store().  Because similar checks
were duplicated to other DAMON API callers, a patch series that starts
with commit 610c4438fb66 ("mm/damon/core: error
damos_commit_quota_goal() for zero target_value") added a same check in
the core layer central parameters, and dropped redundant checks in
DAMON_LRU_SORT and DAMON_SAMPLIE_MTIER.  It forgot to drop that in the
DAMON sysfs interface.

Now the zero target_value check in DAMON sysfs interface is only
redundant.  Further, it has a time-of-check to time-of-use (toctou) race
with target_value_store().  It can confuse readers to believe [1] the
division-by-zero can still happen.  Drop the redundant and racy check.

[1] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 750f70f0c31b..b0d07994f6c0 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2917,9 +2917,6 @@ static int damos_sysfs_add_quota_score(
 		struct damos_sysfs_quota_goal *sysfs_goal =
 			sysfs_goals->goals_arr[i];
 
-		if (!sysfs_goal->target_value)
-			continue;
-
 		goal = damos_new_quota_goal(sysfs_goal->metric,
 				sysfs_goal->complement,
 				sysfs_goal->target_value);
-- 
2.47.3
