Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C357CAC;
	Mon, 26 Aug 2024 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724646209; cv=none; b=VltCM/H56vs9FeR9Gsaa9F+T6pJ4qgyId9GLTXwZzSq2jG7GDitieUsd7Pcny4SUTmEkJnhTfRrmtFZnLtCpzAhbokN4j27gD7P0LF2SoEgrXDic7iP8QgpeaTtmpfmEvChHF9+YHF97MFR61BJHvZ7yKQ9ueJz7WxmIYVb5A/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724646209; c=relaxed/simple;
	bh=UHW9Q+oQECc2cZmhHjnUjTteD4lWCzsp9j3YCv5KfTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CM45xKC95kr1t/TBtdPqS+C6nNabRgGAfT/+iJOXmHeFiEePq4LUYayRZ1VcV6E6dZKc+80xCRkT1FC6yQCWsyepBIBu5XQNfPf5fqblc1FiZ1sZRB7PW6MNy6ykiSu/xp/YoPJ/rPxDBNxq2Ae5SbLwaO+gEYylZ5DDeqFHWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It+qUYQY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It+qUYQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9C4C4AF52;
	Mon, 26 Aug 2024 04:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724646209;
	bh=UHW9Q+oQECc2cZmhHjnUjTteD4lWCzsp9j3YCv5KfTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=It+qUYQYI6bSGiBuQ7eQvfcSLKDhnTSOby0Gfr09tqVkz5soNjjwMncsbWCyBgWYw
	 KIUCcHid4uZAuLNfiYE48GT2Fz/TLtJIMk93WIZXcYbq9Ux7L0OHPS1aSGaLLKbxsI
	 Hzg/rT/iHuxN7d3EeKiu9G+9yYL9sKFzZEukxKdRaCyWZL/gWJGIuYE0dF3POnwzBt
	 wOiALKG3z4HYIHJsb9EntuUgldbe3++qPlehVsVaA3c3Q6WXkU9klzTVSmARS6yQpM
	 3W+s+ZQbKJiJ57juiuAckFvMaZmKgV/0VwFXdQJ6BgbRbXfVLmV504mjgUkpzLnUig
	 gWRVkzQ6WcBgA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm/damon/core: replace per-quota regions priority histogram buffer usage with per-context one
Date: Sun, 25 Aug 2024 21:23:21 -0700
Message-Id: <20240826042323.87025-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826042323.87025-1-sj@kernel.org>
References: <20240826042323.87025-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the usage of per-quota region priorities histogram buffer with
the per-context one.  After this change, the per-quota histogram is not
used by anyone, and hence it is ready to be removed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index be3d05357667..a1c32becfc73 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1623,13 +1623,16 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		return;
 
 	/* Fill up the score histogram */
-	memset(quota->histogram, 0, sizeof(quota->histogram));
+	memset(c->regions_score_histogram, 0,
+			sizeof(*c->regions_score_histogram) *
+			(DAMOS_MAX_SCORE + 1));
 	damon_for_each_target(t, c) {
 		damon_for_each_region(r, t) {
 			if (!__damos_valid_target(r, s))
 				continue;
 			score = c->ops.get_scheme_score(c, t, r, s);
-			quota->histogram[score] += damon_sz_region(r);
+			c->regions_score_histogram[score] +=
+				damon_sz_region(r);
 			if (score > max_score)
 				max_score = score;
 		}
@@ -1637,7 +1640,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 
 	/* Set the min score limit */
 	for (cumulated_sz = 0, score = max_score; ; score--) {
-		cumulated_sz += quota->histogram[score];
+		cumulated_sz += c->regions_score_histogram[score];
 		if (cumulated_sz >= quota->esz || !score)
 			break;
 	}
-- 
2.39.2

