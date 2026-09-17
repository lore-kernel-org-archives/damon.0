Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA5376BC2;
	Thu, 17 Sep 2026 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617947; cv=none; b=NA1Z1a4Gcqb0nGpBo9VxSifaosNWuTxHIDzy/FAS4kMVzjXCdUTxoQejrUmS+lbw44vk/+Ym7oZZ2WuH5/kUfMe5NU8CexI3PyjsacDcncpPZsJMKo3r6YGVBNReJNEzoq2TxUXeT0OfGloQ4W/khHO77DNIlb6dfE6ZKqdSHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617947; c=relaxed/simple;
	bh=Wko9Artoa0Z5PAQBQ/kk99efp8RqAhI6M/MZlshPmic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2YZ/s2iDCuuHgRpzZz1nWAxx+tz5rkx/6MGTt7V5xjc0dSHEpkfQ/k65SiC2pjvsr6TI+cNiVjEXbhA2LXhn5+qqz7Hn+38/Mg7TYfwI2eVtIW5EaA6VNZQTiOa3nVlblNeRLN8gIUN7qRBpaJ45vb0HYbJLYAuXfZdpN6T/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzPeRIQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzPeRIQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B1C1F00893;
	Thu, 17 Sep 2026 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617946;
	bh=D/xjDMKN2pxjPkDC8M/3Bvu7Q4EfB+XzLNhUIOrk264=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bzPeRIQdTet6vIjgw0TKaEd2PPKGqbVO5HgR63j0IO7vOgaQXJa6IxhOxtbiLjDaE
	 6d6fQ9V3myXQoQoiJsHWu/5etl4Ba5hN+tpswOdW8ohcByTXqED0efj8dyhQ+oXMdy
	 xChf8X+iYGadx5n+n88RDJJtGzIJnba/SDBzO5ttVtJp3FgkBKmqM9i0xizLBHKbWE
	 TlmJbeq2qX5n4ejwrwbGCFaoj6i1owKeiJCj1abJrdIG9sz3tabgh1SSYDH7AIzORE
	 cVW1cvyReVlDYASbq3G76ZRtohlqtnqXuXPD84gcvC++F6uEm7nsrvdjIvVvLjtos1
	 4iN3tKer6CB+A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 02/10] mm/damon/core: use abs_diff() in damon_feed_loop_next_input()
Date: Wed, 16 Sep 2026 21:05:28 -0700
Message-ID: <20260917040537.107341-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
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
index 707fdc82de3a5..0299729e79ed9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2927,10 +2927,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
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
