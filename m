Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E923BED78;
	Sat, 12 Sep 2026 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243704; cv=none; b=JI8btvEMmMXDFXMmOEshf4oErIljS9FKnO6X5mmfRwXNaUeIVZdxv7Y1cAQbxAGG4adlhVEFjYnVJYMszpb/3ceQYc8J7fdMIwiK8yREM4Y4xd69BUGCEyj8lrFMa1AVY+KI2UXOM+5Xl7HTJJF2eeYxkCpivf6McpgScxFqYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243704; c=relaxed/simple;
	bh=lnN8yBlO5SqLcW4TZiSS6k10RAiAzY1fYevG0oy3Dso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzNvJ1f/Ack+zZvO85MuolDf6pMyIwIBwtna0ZHy+UwTdJcsmtL0uwGwloUvxLey5qVrVBlEs6e8gbe6/HjOiGCFSMoyxrxM2H63Sly3CFwzJjBDGyi0Wxh9BRCqEfrMQCT9dXKmbzqTtWR+BRfKrOBXb3bjBfdmq6EPi+CPHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojJaqsSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojJaqsSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6456E1F00898;
	Sat, 12 Sep 2026 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243703;
	bh=jlghyvZVNP8/XL0yY4KLFntdcCcvr5Jln0kHwD1ylXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ojJaqsSm35JPnh3SwZ7uQ9wBPo68CoQtaBz99FqPU3hETd9okd3Wa/EAhAh9CE8X8
	 vUvqGTGcOKoqMVisbqQ+8Y2lBEdiGgkO2gIQ1eqXEg4qj579gOaCixglPUJkZfBPL2
	 5UXe5PapAxYJWbQHwx7XxFAYOT+li0mw9Y4eBsw/1rVXBnWO4M7UeVa2jnr46TRqHz
	 k0a5oBALMN93AWKBId4DIr0qpQWdof7CmQu73mWCL1M/7AZFTeyi+H958MVaDDhgDu
	 fJqcThaaLnhOGY2NZxi13bbsBIAWibTZ2cflakSq7EPPjltFY6a/bWOS+31c56Gl8D
	 H0LbzKxr3+OnA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/9] mm/damon/core: use mult_frac() in damon_feed_loop_next_input()
Date: Sat, 12 Sep 2026 13:08:04 -0700
Message-ID: <20260912200814.145612-4-sj@kernel.org>
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

damon_feed_loop_next_input() does its best effort overflow protection.
score_goal_diff is always smaller than goal (10,000).  Hence the
calculation can be replaced to use mult_frac() without concerning the
overflow.  Use mult_frac().

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 61bb25674cd23..cf10f6d725c19 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2921,11 +2921,7 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
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
