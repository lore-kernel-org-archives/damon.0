Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7C3E928F;
	Mon, 29 Jun 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744946; cv=none; b=JxNkALIuQJrinT0Sq4bc9sCguJkHPc/ZmRSZONFYVPHhw8WJ0LR1IiYvT+opxCqJ+WDzEE+xc1ZAKMK8QC8Udv6ZeHEvbyxiu5ra4Ykszye1RWocCEfktseD/yg1Au0PmRR1pf2D2ctf7sSE1zkuE0VVd4wRzYssVIXNAYJMUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744946; c=relaxed/simple;
	bh=A6HP3BaJcXbRdimzNXlNJHxlZHLteaBx9TFb1gLvmE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn3LaSNKv1hTUwateRoQfK6LEbOAKQdAVj4ANxeirH1REb9GA2kV2ls5BNWb5h6YYVpDK8CekjKUQWqUrt1GDkzBKJZhc8zVE9swD0vLNMTGkFbsENDEEUswVHFuVk6yTXHjxNhty+a3RDKnxoaCsmlC2LQg7xDj0yot8TGhUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMHGHv8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMHGHv8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D4A1F00A3E;
	Mon, 29 Jun 2026 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744944;
	bh=ZVhN2I9i6QpLRkVKkW1yI5yzs7NG5PgDPEhiMNWAM8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMHGHv8A1MYROF6vPuTDwZviR+le8pe4sCB4aR6QW3CKon05YWmPUiV78+bUpqs82
	 y+CzIcn7dROAVEmlPM/i9LOM8+tsOxlZBw5GvmZ3Ppr0WZPdnmXj6Se0woYaBx/iEB
	 D879T5sWVZrYXm1zjZdzi65tillLHPSq5D9McygwAwJv18yi689aZcSByhZhc/8iAF
	 sJSgJ+GLlytguYm38pnp/qcio4yLqY8Lc4a6gNgCo8J5MX1OeRfKhvFCxw6Md19gEG
	 2UmyIuQA7rHYd3BH0xhlN+I59pmMih1IhRAW6Xq5z4UyCeVA2GBmvMSOZxKapZ5UuV
	 CmJOZdoJb2d1Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Philippe Laferriere <plafer@proton.me>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] mm/damon/stat: use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Mon, 29 Jun 2026 07:55:33 -0700
Message-ID: <20260629145538.134832-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629145538.134832-1-sj@kernel.org>
References: <20260629145538.134832-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philippe Laferriere <plafer@proton.me>

The conversion of a duration expressed in seconds reads as
msecs_to_jiffies(5 * MSEC_PER_SEC), which obscures the intent and
needlessly goes through milliseconds. Use the dedicated
secs_to_jiffies() helper, which expresses the 5-second refresh
interval directly. No functional change.

Found using Coccinelle (scripts/coccinelle/misc/secs_to_jiffies.cocci).

Signed-off-by: Philippe Laferriere <plafer@proton.me>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260615214113.122923-1-plafer@proton.me
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 mm/damon/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 0e14f5bb8f75d..b05b68f73e10d 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -138,7 +138,7 @@ static int damon_stat_damon_call_fn(void *data)
 
 	/* avoid unnecessarily frequent stat update */
 	if (time_before_eq(jiffies, damon_stat_last_refresh_jiffies +
-				msecs_to_jiffies(5 * MSEC_PER_SEC)))
+				secs_to_jiffies(5)))
 		return 0;
 	damon_stat_last_refresh_jiffies = jiffies;
 
-- 
2.47.3
