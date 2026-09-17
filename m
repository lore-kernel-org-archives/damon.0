Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5BB5908C0;
	Thu, 17 Sep 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654941; cv=none; b=F9bXfHSC7PNLxBHEj/AYOhEuA4JzzAoFWsTA31LJC3gi0hVUCeJ9kmzitgi/aZW7x+MRMHV65zumpwU36EDar8tb7rg9apfvtqgcpaGb4FpzPcTDBUAnPYeOOl8oYt23SbmaclWq4tlWRhjKxzcgEP/aQN7G+hz6LOKWK+IdxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654941; c=relaxed/simple;
	bh=VaDYdo4YPv5i47nFcp1UcmGveOFil6j1xbLCRiCXscg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNQ64N7wH4Wl9+m7S1pMxvBhKv3//uIdCtXFjklLOk8t6/H+1Bl/nPA+67Ht5P1Xt33RSK8MaYtcMClXYJTRcon5+ZR5J8/rKKadaL8qm0D4Y5EoSgqSrsY9EXk2Fd2QeZl2haHow3lY+Wo9nzZaSsPnfRHoKWwCllSti/YiJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5ExFZPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5ExFZPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698B91F0089A;
	Thu, 17 Sep 2026 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654939;
	bh=G4i9YVdly64+a304TiCv8nwcHkLss6xqStxGSND5/ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h5ExFZPJQqiTePp/WDl73sof3pqfsr/hdjFIOJ3lWzZVKGNrtN2V8/Ojg3ODcNRq7
	 1paKZ44w7an5o/r95vLVQv0bk4qiUZukq79QAXR2ZqdBkofCE0xLAl9TJrzFwtvJcE
	 ijDZn/rSTZtXH+MW1Bw8sNSFaZU7VsiiLNetPjm+IJqzE6WxgjoKHkrTLSE/rm3pXW
	 xZNQB4GzoKlISfZh6wVJLLic5/78/BKiecMDKc6zrvcbYIsEA/EYPmWYxkhH+jgMFs
	 +y2OjyLKNf7NF9FLh586Wz6pPCalP5v6BapcLU3zT4nHbgz4f1xG0lXfaKpNmzQuSp
	 2Z7RIfsHMLVHQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/10] mm/damon/core: use mult_frac() in damon_feed_loop_next_input()
Date: Thu, 17 Sep 2026 07:22:01 -0700
Message-ID: <20260917142210.90829-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_feed_loop_next_input() does its best effort overflow protection.
score_goal_diff is always smaller than goal (10,000).  Hence the
calculation can be replaced to use mult_frac() without concerning the
overflow.  Use mult_frac().

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index de46072dc1a2f..bc41ac7ecca43 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2927,11 +2927,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
 		return min_input;
 
 	score_goal_diff = abs_diff(score, goal);
-
-	if (last_input < ULONG_MAX / score_goal_diff)
-		compensation = last_input * score_goal_diff / goal;
-	else
-		compensation = last_input / goal * score_goal_diff;
+	compensation = mult_frac(last_input, score_goal_diff, goal);
 
 	if (over_achieving)
 		return max(last_input - compensation, min_input);
-- 
2.47.3
