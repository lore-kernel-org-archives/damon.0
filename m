Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7937996B;
	Mon,  6 Jul 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346801; cv=none; b=WgEaker/E7waaZCTarApPbQmO6hUESuu/9tj1i4WsZqDx89INhENnsGVR11UZkXxjBfrFFPzN1l6CFC28gC8VJbHr9duQtcSg4YlxcRWAEbH5iMVlkFxD34pIwdnn5Lo8fTnllrmL7xkAiKzW4WRgwc64+SJCoQQW0z+L7EpL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346801; c=relaxed/simple;
	bh=zw18eCF9o/kXw8UfeN/aNgCviJlDOibZN7c7tPL19WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMljJnzWpjshwnGcgRjxNGtuweRrn126y5793ZaScXmpn94CvphpIYskBCjHmG+t7ZZii7LwwErIK29Oo5PZZUAgUoixaYjQfULiGlbAuilK2/ONmrrmSbxzSQEztCHCU43LCiH/U1iPOfcY3RuoPpr58AMygeQ61el/Xxyml9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmS20j5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmS20j5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95831F00A3E;
	Mon,  6 Jul 2026 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346800;
	bh=XifFyfJolobUF4kXii9SDmtvZzvIFxqywQe1D4fl4uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HmS20j5yX7GzchH37nIJE6zHhT5G8cTgsMm2dkny6473IAR0QuA1rOCaUq1KW/Amt
	 Buur8jyYC5oTn/tk8kAa8pvdxqOFxPj6lKGiLMlxYIFaJvJs1wSghplfo2+ZBDk0dN
	 SFjmjtguJv+FgK1ZA1KM0ZYLaW84gkG222bVASSWxHX4bZx8kl9yj5pP0pL+11RwY4
	 dL33ogYemO9Zx63+AXcnUoYBFKx9SpNjjNHXYUgeM6hGb2dO51ns5/p1YcpwoAlhGB
	 RWaMZvo25oqrMzVqeedp8JKs0Q9gPxlzNrzaBTPmJzsgrxFDgz3c9sEUdYq1D1dGmG
	 Ctzl4fBCyMtwQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/11] mm/damon/lru_sort: ignore damon_stop() return value
Date: Mon,  6 Jul 2026 07:06:21 -0700
Message-ID: <20260706140628.87414-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706140628.87414-1-sj@kernel.org>
References: <20260706140628.87414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stop() return value is guaranteed to be 0.  Ignore it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 2dd0cd0d26273..e8c389ad3226f 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -409,8 +409,10 @@ static int damon_lru_sort_turn(bool on)
 {
 	int err;
 
-	if (!on)
-		return damon_stop(&ctx, 1);
+	if (!on) {
+		damon_stop(&ctx, 1);
+		return 0;
+	}
 
 	err = damon_lru_sort_apply_parameters();
 	if (err)
-- 
2.47.3
