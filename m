Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764983F0A99;
	Wed, 20 May 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289404; cv=none; b=jAKcUncISgflP6tggguRU668l5KQMc2A4MbhubSHsEHjJeEJZ5XGZlCDQktfex2QZliuOqvsX95eN3jmlIUQ7X65pOUZp6vGOB1H7XegeQgq3yakpTCNYr0FiU2FumwpLOMxi8sdlJOQD7cgyg9AtFcpkT+lw1qd7gd7dSzWM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289404; c=relaxed/simple;
	bh=VQHyb17cPuxRJcgPBDayEOQwcwW8AT/T/v4GmQ4BmyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFcO2I5TF59WZvlvL07KyUk1JFjEQ7tZYebMCrjx98vLGRe8/GCHhH60IwVF20uglIbshroRhS38z31rQ3ZZBjdKtzE3n+PZ5HX7GuPg0qd1/eNN/okJLzOJgt0i1FTVqZGFGmtkocM11CW0519CtnSWmJoQxSjrVFf/koigzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccwhAOED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccwhAOED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AF01F000E9;
	Wed, 20 May 2026 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779289403;
	bh=cKMYreO0fJ6K2NQBHB0YB/VMVoRVOkqTPgCMvuDnzSM=;
	h=From:To:Cc:Subject:Date;
	b=ccwhAOED6qKyLpnVxZpflqp6L40gksi+/8sUEO3OLyFkxb+iOeJTXbu9ukTTsvYT6
	 2hQuCN99rprN7msTZSIE9UpQNeo7Vsp+UdkFvWZelZFcgCwYltbDnsTybV/5KKe7/q
	 p8cZh/NYjOS2ZmapWiH9md00CwlyX1n/X9nkZRHcrMT1Djc7gAWZZuHgRVJUutxs3H
	 ZblNbPNlbij1AQ9GlpF6TCwjFhctmQJn4pl56JY5SmYx7I4lU7wtqd+A1DOdppO2yM
	 vddqZxhGgG/0Pql6W4RJT7obhP5PT6aK875fCjfVgu1TEeQotKt6Eqe8P/XGMe/dac
	 yWLduVnLK+k/A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: trace esz at first setup
Date: Wed, 20 May 2026 08:03:10 -0700
Message-ID: <20260520150311.80925-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON traces effective size quota from the second update, only if a
change has been made by the update.  Tracing only changed updates was an
intentional decision to avoid unnecessary same value tracing.  Always
skipping the first value is just an unintended mistake.

The mistake makes the tracepoint based investigation incomplete, because
the first effective size quota is never traced.  It is not a big issue
when the 'consist' quota tuner is used, because it keeps changing the
quota in the usual setup.

However, when the 'temporal' tuner is used, the quota value is not
changed before the goal achievement status is completely changed.  For
example, if the DAMOS scheme is started with an under-achieved goal, the
quota is set to the maximum value, and kept the same value until the
goal is achieved.  Because DAMON skips the first value, the user cannot
know what effective quota the current scheme is using.  Only after the
goal is achieved, the effective quota is changed to zero, and traced.

Unconditionally trace the initial quota value to fix this problem.

Note that the 'temporal' quota tuner was introduced by commit
af738a6a00c1 ("mm/damon/core: introduce
DAMOS_QUOTA_GOAL_TUNER_TEMPORAL"), which was added to 7.1-rc1.  But even
with the 'consist' quota tuner, the tracing is unintentionally
incomplete. Hence this commit marks the introduction of the trace event
as the broken commit.

Fixes: a86d695193bf ("mm/damon: add trace event for effective size quota")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC
- RFC: https://lore.kernel.org/20260520005940.92003-1-sj@kernel.org
- Drop RFC tag.

 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4e223857a0f99..0db6530825d1d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2883,6 +2883,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
 		damos_set_effective_quota(c, s);
+		if (trace_damos_esz_enabled())
+			damos_trace_esz(c, s, quota);
 	}
 
 	/* New charge window starts */

base-commit: 796dd9092b9c9d93dd48213582d45c43e93fa187
-- 
2.47.3
