Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4C5908BA;
	Thu, 17 Sep 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654943; cv=none; b=t7Ii3CuKzjD4rVkZsW0t7WwAfJvSsk15BUAAsAsLyv2lolzoGTWNCnOUV2pRCwZs23Z3+qmrBykd0YdNuDs0xn2FZaHa8fvShqSrkc19zMh7n6sXbzP0KSwzp7+RQ6r8ijagwAmOQrgoLtkvHyxL2t0AzT4ig/Bs4AMGkwHBQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654943; c=relaxed/simple;
	bh=nDAldM3Lr3pL7yzRPMPnxv7C69196HziwrlczuuJCrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiWVtoo/1PLW0SP5/2a85DGadjG9+3Je8WoabebWtvIxp+TM+Ye6DQB3UGEXwy66kZabLyqk5YpEdpgE5U68kKKpw2Q+5gzaCHnjZbynLI44b/e0baNnTXUWlrU8PVPji5XWn+K9CXNZsHi2h1Vd2hPz50kTbGzEcxyTe+zyDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUgJetET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUgJetET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC631F00899;
	Thu, 17 Sep 2026 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654939;
	bh=vxln5uIYrxZ1tEvbRFMph3C1mcNz38/PEev4DXMWOvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUgJetETiqQ9ixDcx09zjkVJR5sv9CPI1MJByv+mOw/peXroSGR/wPBdPWuj0ZuCa
	 nm5n7ZclnKrkoI19TmdxYZwTP82kcp4Du8CvA7w+89hewHb7qlL8+Nt24lL6Bnbnh3
	 phtJB9QedHCryfeHu0gb6kllUio3zj8Fga/iZnZYFr3Q80Thru/81Z+YPO4pZQB965
	 7PNtOwMZUEnuPzSjhPtfx4a6lHpwRI+mlPuyi6hX79cRrLSLA3PgZaX73SkYGfWWTS
	 fG6+6lQqKthCa9wMuJUPr3lMF+4Svxsq36CFawLgBZ1BDmr9fI4wCu8A7RALuq1BzW
	 lCvRURuVrqKsw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/10] mm/damon/core: use abs_diff() in damon_feed_loop_next_input()
Date: Thu, 17 Sep 2026 07:22:00 -0700
Message-ID: <20260917142210.90829-3-sj@kernel.org>
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

damon_feed_loop_next_input() is open-coding absolute diff calculation
instead of the dedicated helper, abs_diff(), for no good reason.  Use
the dedicated helper.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 444c97c184027..de46072dc1a2f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2926,10 +2926,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
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
