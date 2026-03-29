Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D887C30DECE;
	Sun, 29 Mar 2026 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774797789; cv=none; b=SdraL7KJoRVBe4OUkvq54/vQBv27v0GhMTidKXWgBBJKyYXxFKJeeZQ3n75I0S9UGJ0rUCBZwET19yoxgP+uQ4Im2CgVhNu2Ttcb6UdbBqLgwXhaRsUD4/LSOYQIznRpBFwe/q2oEj8+C576TR8fGigicq3LEtubsotSG1nzdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774797789; c=relaxed/simple;
	bh=4w/+zge2tJUjelQDfdDj5Cll9bwZ8Hgq0JoBvAzgu+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwO0soL23BGC50M80ChSkX24Dj9RONElLoz7zvFuLeo1Ox9pcElDBRasipCQQiJUkdUUC6VDV5+suOpqFQ/aSoreprC0YgbFVHJYYpgmWNutfFC/hTxe5SGoDhpmZ7dDLfDKuOwxV3HCKamRbqD4ULEp4FFGUiqUpEsBQdlsQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMqu0lRi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMqu0lRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03116C116C6;
	Sun, 29 Mar 2026 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774797789;
	bh=4w/+zge2tJUjelQDfdDj5Cll9bwZ8Hgq0JoBvAzgu+M=;
	h=From:To:Cc:Subject:Date:From;
	b=EMqu0lRiZwv9CrgagB5aVGKcDKVfUZrw7cF8pAu3oep/7MsfAMrfkPjwlewN2kOe2
	 qkIiXEjAj6i6Szh4aURhcj/gzASY6N83En2PMJAi9n04tiykVaFM2e76AJ9Ut0e4fP
	 sxk1z20dnWg1g2Oaa32GwKsW2saCFmHE2HDvvYHIh0zKHDmvzx8qA09uJVN7sjUEVU
	 Te6ExZSjyahnvRv3/vIjF/7xAxuLI2Dk4xvispqG7OQ1M2jhvkcVZ4/3mSsT9dncrQ
	 6wX8DV9fOCZ0p6kXwB72Ezr42BDNd6MK3UWEg6yrNMj2UIgGnmQSLKX4gZbpRet+ug
	 o0acVl3XqZy7w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: use time_in_range_open() for damos quota window start
Date: Sun, 29 Mar 2026 08:23:05 -0700
Message-ID: <20260329152306.45796-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_adjust_quota() uses time_after_eq() to show if it is time to start
a new quota charge window, comparing the current jiffies and the
scheduled next charge window start time.  If it is, the next charge
window start time is updated and the new charge window starts.

The time check and next window start time update is skipped while the
scheme is deactivated by the watermarks.  Let's suppose the deactivation
is kept more than LONG_MAX jiffies (assuming CONFIG_HZ of 250, more than
99 days in 32 bit systems and more than one billion years in 64 bit
systems), resulting in having the jiffies larger than the next charge
window start time + LONG_MAX.  Then, the time_after_eq() call can return
false until another LONG_MAX jiffies are passed.

This means the scheme can continue working after being reactivated by
the watermarks.  But, soon, the quota will be exceeded and the scheme
will again effectively stop working until the next charge window starts.
Because the current charge window is extended to up to LONG_MAX jiffies,
however, it will look like it stopped unexpectedly and indefinitely,
from the user's perspective.

Fix this by using !time_in_range_open() instead.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260324040722.57944-1-sj@kernel.org

Fixes: ee801b7dd782 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC
(https://lore.kernel.org/20260328163930.47096-1-sj@kernel.org)
- Use time_in_range_open().
- Rebase to latest mm-new.

 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 19642c175568..3bc7a2bbfe7d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2449,7 +2449,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	}
 
 	/* New charge window starts */
-	if (time_after_eq(jiffies, quota->charged_from +
+	if (!time_in_range_open(jiffies, quota->charged_from,
+				quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
 		if (damos_quota_is_set(quota) &&
 				quota->charged_sz >= quota->esz)

base-commit: f7657f10211e1fca73ea2bc00d4b5ee938dbaa71
-- 
2.47.3
