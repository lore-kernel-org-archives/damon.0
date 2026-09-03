Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3B2D949C;
	Thu,  3 Sep 2026 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397651; cv=none; b=YwNTqxXTn8evFRSsEuih1qyRoVTEWyT3am39B8luO+PwCruBvaEZ7AHDuZjggVePWOObsVu19Q4tUO6etpBrATvYcpFpGi5pQke5aGq5fj/n5DhM0FyC0+ThXZo9duBddUtC5T0Nzax4wQIh7zPSwmArCKQOxDRrhxVhTdC2ReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397651; c=relaxed/simple;
	bh=axZTWAdNkaqbfw81b8HYeJVw703O5s5cDzE+KJ6R1x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUnkjh1MaWo4SMjkRaZ255YCJlpNbRcI6yC6bHYe0hG4pcxZKqEyfm673PmbpCq/QxaB7WMcMB2BTJ6sLxGwGvS6CcZtqVjs0un8QlURwks2AlmvmJ7vM3rWeSvHN0bdjMTqxDi89QYsquGGaXMFOB96f4YeP6Z9Q6wIn9RgXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFpq7ydF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFpq7ydF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24981F00A3D;
	Thu,  3 Sep 2026 01:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397649;
	bh=3ydKZfv20XDA9Yk9OoF1itUqqkZNlBOcLwEjFDoPApk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFpq7ydFn1Minqtp55XyMjj3pSEJhDIwAj7dFNpnIob9o750wJrG+nUBvaCfKCnfU
	 5PEXUWzW0VPiL+oNaRTPewGgzudX0SCkoWkyA2SO9E/Fhr5UM9qucdg0QhxlJ+0Q5K
	 YHRSI4JdVUBeeu1rkiQ2c8+dCKR1YST6BwlZEg/1rpyAm0p8dJNnWH2nHorKbvfyEJ
	 5d8VBJmmH1njt2/hlqUWUGQVAKQ8YKWNZYL4Iqe1STd6rNL/O5jWv2cg6mZUnrRvK8
	 qr78Pk0qmA/vDx91IqIwpDEyytAZdI1O0KuOYo0e4FcBh9Z3q0NRxTSC6/uDB2D9Uk
	 WhaOzAM2qvH6A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] Revert "mm/damon/lru_sort: error out for >10000 active_mem_bp"
Date: Wed,  2 Sep 2026 18:07:20 -0700
Message-ID: <20260903010722.94244-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903010722.94244-1-sj@kernel.org>
References: <20260903010722.94244-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 06befa61c427e74319781e6f35a364cfc32dbae8.

The commit was made to avoid zero damos quota goal target value, because
it can trigger division-by-zero.  Now the core layer handles the corner
case.  It returns an error for any attempt setting the aero
target_value.  The corner case handling in DAMON_LRU_SORT is hence no
more needed.  Remove it.

Note that this slightly changes the user behavior.  It still disallows
active_mem_bp of 10,002.  But now it allows other >10,000 active_mem_bp
values. Setting >10,000 active_mem_bp makes not much sense.  But it
doesn't cause critical problems such as memory leak or crash, either.
Arguably that doesn't deserve additional code complexity.  Just allow
it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index f25ee7326e87c..ad8e86dd3a93e 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -233,8 +233,6 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
 
 	if (!active_mem_bp)
 		return 0;
-	if (10000 < active_mem_bp)
-		return -EINVAL;
 	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
 	if (!goal)
 		return -ENOMEM;
-- 
2.47.3
