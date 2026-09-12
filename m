Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875673BE14A;
	Sat, 12 Sep 2026 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243704; cv=none; b=BfPQXI195AsVGvZx5GnXrrWsGV0gDvxEq3elWbpJxmVbSrzb8AIG6PCWPON4b7MeJQN+riwDTmRaSMLgwOxXUuLDFFHwpWTjrYinmsfRI+rc380aAvmym/47UxxDhuNIP28szqls/zAfV8VLO8Jt8rhLUvAioITZzr5kV19gExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243704; c=relaxed/simple;
	bh=fHPk3dI4o26S9Iu/P+a4K0qHy0oDutl1UCum8MHFi1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIvQNFdkkQ2hxv+CbmjZriVecwFG1e5NGCR7V+n1BIVrSWXkF2uO+0e/6k2zogvrwMC00L2qNtSNLP+Iw4fFUQi0LygLcJagMo6jHc0XYsl7iYDsXALBC+oVclx6MHvYqbtMDB0G4o1Vv3IgzjZzH1Bij/zR/D/z6BCrwT4pafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLar0xk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLar0xk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198421F0089B;
	Sat, 12 Sep 2026 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243703;
	bh=VxGvxt644mU37ynH6tDMhkQ6DkJqcqbvynSb2Y6zpJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLar0xk3+wrSqDaUCIrCVeEZhjtSPCRM4Lck/b2BMqT0oYQoVI+wSsLu5NpLCbekG
	 VJs+ZSntM6rRfTCgZIom2pkMMYn+M9+2z+DY9IYT4UTccJyjYwVWSrutpXogcj0Re8
	 iGDiwCiLKYKPF9UFCHnckXE+fCeyxymutvjZFHNFusakyvr59gSj0cA88wtCknHuLG
	 OmhCLDrw87SKqQGABG8imD8nEgXxdbfDewhfJZy6vRxMPn6oLX3yBeBsZLl88Mp8iH
	 ZXs1FV11liRqLbBRd4DZCswAjFOvmGspSlKXymiUOOw7Vj7vk+dw/h80fjix/TLfaM
	 Azf+4Ovx3PJyg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/9] mm/damon/core: use abs_diff() in damon_feed_loop_next_input()
Date: Sat, 12 Sep 2026 13:08:03 -0700
Message-ID: <20260912200814.145612-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912200814.145612-1-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_feed_loop_next_input() is open-coding absolute diff calculation
instead of the dedicated helper, abs_diff(), for no good reason.  Use
the dedicated helper.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 373339f961967..61bb25674cd23 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2920,10 +2920,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
 	if (score >= goal * 2)
 		return min_input;
 
-	if (over_achieving)
-		score_goal_diff = score - goal;
-	else
-		score_goal_diff = goal - score;
+	score_goal_diff = abs_diff(score, goal);
 
 	if (last_input < ULONG_MAX / score_goal_diff)
 		compensation = last_input * score_goal_diff / goal;
-- 
2.47.3
