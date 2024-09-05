Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CF192D96;
	Thu,  5 Sep 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557051; cv=none; b=bpR6ytBZolR3tNAQ9tDkYI/9ajQlZIPCdOyS6Wj96HFZIvq9DGBS2BxWWX6/+ALdaWzFx6D+Gaszfk1QKgdW0YE+Td4jS50DdVoB9rVyR411Q+h9kV3n+oY6OQGhtJM1Gsexfy+2N/PRx5hZLcV/YynPVQaVoWsZcQZX/fwR8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557051; c=relaxed/simple;
	bh=qZcBj0EB8G0ORdOMeKcxDRY4297XFxFpbti5X8aE3Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PY57gG8kCH+7P7tLBLxvOD8YmOCqiZMc6NG/DSKvNwsTFZNlDw/nuCu0KTU3eB5gtDdzp366rYCJ0+x0patC8XqBNOSB8tJG8AOwY7PxEMTp3i9tVOqgH10a1qOROVtpL0UkgmgfiY/WBRlCUDltTc1MorXHsbZEQm2A7XV6JfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah7zBwWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah7zBwWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76494C4CEC6;
	Thu,  5 Sep 2024 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725557050;
	bh=qZcBj0EB8G0ORdOMeKcxDRY4297XFxFpbti5X8aE3Ng=;
	h=From:To:Cc:Subject:Date:From;
	b=ah7zBwWiGJ0NIp2n9juU/LpFhavcxTGPFb1NfC5DhDhAoxksbi7YROk8Ak7Kz/ufM
	 XnSJH1Sy8EkaUblI3N/n01OShRkyv5/YMuQSpL2XpG4ziUd/0aXBOkY4j7PPNJ2GKO
	 IMoB38EnGTrZ+ohqsG14MA8fYM9VWTyCf2qChOatOXakanv4fLze6xFl/kMRjx8WDi
	 P8KjGXy6DJ2jO7vOSNsvAN/vm6fTiRRR8E22k4fFJlSe5oc+yDjuW1/YNfqeuF2H3Q
	 8kYeKdqzHQuquIhh2Srf6GyqIuRw2pYY5/i2HWwai1sDl193xChSbe2ikYsIWZA7my
	 urWo/1Frt/H2Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm/damon/core: avoid overflow in damon_feed_loop_next_input()
Date: Thu,  5 Sep 2024 10:24:05 -0700
Message-Id: <20240905172405.46995-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_feed_loop_next_input() is fragile to overflows.  Rewrite code to
avoid overflows.  This is not yet well tested on 32bit archs.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/944f3d5b-9177-48e7-8ec9-7f1331a3fea3@roeck-us.net
Fixes: 9294a037c015 ("mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
As mentioned on the commit message, this is not yet sufficiently tested
on 32bit machines.  That's why this is RFC.

 mm/damon/core.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 32677f13f437..1d951c2a1d85 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1494,15 +1494,36 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
 		unsigned long score)
 {
 	const unsigned long goal = 10000;
-	unsigned long score_goal_diff = max(goal, score) - min(goal, score);
-	unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
-	unsigned long compensation = last_input * score_goal_diff_bp / 10000;
 	/* Set minimum input as 10000 to avoid compensation be zero */
 	const unsigned long min_input = 10000;
+	unsigned long score_goal_diff;
+	unsigned long compensation;
+
+	if (score == goal)
+		return last_input;
+
+	/* last_input, score <= ULONG_MAX */
+	if (score < goal) {
+		score_goal_diff = goal - score;
+	} else {
+		/* if score_goal_diff > goal, will return min_input anyway */
+		score_goal_diff = min(score - goal, goal);
+	}
+
+	if (last_input < ULONG_MAX / score_goal_diff)
+		compensation = last_input * score_goal_diff / goal;
+	else
+		compensation = last_input / goal * score_goal_diff;
+
+	/* compensation <= last_input <= ULONG_MAX */
+
+	if (goal > score) {
+		if (last_input < ULONG_MAX - compensation)
+			return last_input + compensation;
+		return ULONG_MAX;
+	}
 
-	if (goal > score)
-		return last_input + compensation;
-	if (last_input > compensation + min_input)
+	if (last_input - compensation > min_input)
 		return last_input - compensation;
 	return min_input;
 }
-- 
2.39.2

