Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553400;
	b=Hfg0aGS4bLulKtFHSjx65wHbR9m/3aJA1dyyeFtdgz/ECdQVRTBZcwzJ5OPTP13qOR+i
	 JAwXJX4cqyp3pRH18cQEwDEOPnb6GXFuPHrrRKz2pm3g/woJGRcGORNIgbJA55w9HrqJF
	 QZjREvU/zRz3vV6KyaQ3Z2Wb68QyMPG94nZAgxeYmDzITbwckMmuVxm1SrllKevqwR+wI
	 289qsrbZbrDC3XfZkU6sDiE/w4BxZ3m6uCrTFlIYwVJtGlxCqt5RGP3lRrYbwqTM+tbMo
	 94gUZ9u/uSj0+q7ypoCHcjw9PcW/L57Od+Lgo1JdA6BMt8OXPhjD+8qQ90Ba2XCh8ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kuii1OxTBCJKn/aKUCi3+2COKzMgGJ8Y558hfckwvWc=;
	b=x3giuNk/zebnyOh8uxtnI/dDW08P8mbwbEoAytt4DnVIm38VfByBpmCAdloDX8lIAP6m
	 O1NqbNuhgFZwRwa5Xxv6WytXrDgrtzi8hhT7Xajm/bos1z6D1K0hDKhSg/rQqGfL8vJNO
	 GYCw3cqfAreWxcY65qU4dWsFrc7rfIuVRBRayEfzPMbOs52OjQ43dlD45iQMpFRyPGzK+
	 lliSMujU9YpEtyUlVEiXGZ3o5t1VprADdiQUU5EiZf5Vg3nS2W5Vfiovrv0Xw/x9mvvR/
	 9Ab3Vo3ZZzMRyEgIQmc9F6A5x+lsjh+OCNosI8pT9KN/IpX1xaAS6sCUW4o1vC//Lpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHnHlvuL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE360A2602;
	Sun,  1 Nov 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHnHlvuL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F0F1F00A18;
	Sun,  1 Nov 2026 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553399;
	bh=kuii1OxTBCJKn/aKUCi3+2COKzMgGJ8Y558hfckwvWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bHnHlvuLtN8sAW4efMQa/2BStqLpezZTUSvbaMHV4QTiT0zRg9a8rjjsZ4nEIzjMX
	 NB0/XxHhbZM4xXO/RZgy2tQz276Nxs0atzjpGLVanS+E8J1uhgXiGKbkjZ+C//TP6X
	 5Y0mPolpqhHcAvQxISBEINUq2cAbGNgNEX08k3M2SAAC7XbU57ZHEZ9/UYN0tNf9yJ
	 5CmaCYVRbHLauBdWQBbuNuXHL7o+0mKlheCugfDltMc4jjblbf5JUrTOM5Zs0wL8oc
	 gb72hxel/oq1xU7u11QdktDXNwNiNEq6fDbzNy+pXuKnGEeKWMIp9WVH9fML3DXTh3
	 TkrYcb2Z7oHyQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 4/6] mm/damon/sysfs-schemes: drop redundant and racy zero target_value check
Date: Sun,  1 Nov 2026 09:16:27 -0800
Message-ID: <20261101171630.81477-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101171630.81477-1-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
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
index 637f1bd0c950b..38efdc258ef3f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2898,9 +2898,6 @@ static int damos_sysfs_add_quota_score(
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
