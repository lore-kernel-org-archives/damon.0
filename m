Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B138DC40;
	Wed,  2 Sep 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328076; cv=none; b=DczHOmoJINCm0AroKgQExON844uPmFO0BUVghr3WskGShMT9d5tdpF7Hy4fg5R2weXckZZNxGrr/9twRyddKl54JBVnfVNRewvmPxvT5tZoQmgtBcluNwVrfnF2SVdq2sL2BLL8As60h9hvtiZk41KinHckE0e9La79vxwqKxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328076; c=relaxed/simple;
	bh=E1xko7J+f0WtN0JX+Y4hXZPSs8hzOzgCXjVT2yeQb64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzpVzwcOjoX8oD+hf3bOqYKoKl40RauEUg0Ceg8ZLm6fJaNbzBND537AFEWCBD74rZddCdWKcjubcnDMzO3/fZtOLdjqnhfcnJrP20QhjOZoUtUWHE7WTDkD2OuPjd9sh+RylnDbevynnUe8BffdpcWaHPhil5Vgy9J1JzUS5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEm8c7hM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEm8c7hM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF29C1F00A3A;
	Wed,  2 Sep 2026 05:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328074;
	bh=Yo9QjrgTWYiC6GWBBDQBEXVvC3vOUMrhoR21RBzshVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oEm8c7hMoRPz9m9rjweoXDQRDxabJ+dkCpT+zUrhyK1lIccNeAKHx7wjLe/W6stDq
	 VOqEAbtXSKBwR0VKJqrbw+7wMnUlqNhixI9b3tTnhhEqGH/uDvhy/i8P0vBK0OUxty
	 Hy66xld6YZShV+HPP0SWUsX5GYnHUdRCEcVf8zTiaDKJSk2q3tMDXjGUTEKWVMxH7A
	 miszvuJ/FaQbOsnd860+/o2ej7TMeuMDv436icsfXQ6PglfqnGw0h9gZMi2fLYyoRA
	 DORXNCz849FE1La8Drz8IvJh0aA5ZLLnvEORvITEcl+LgLXF/FhJyM5Eikys+pL1Fb
	 0mIuOv38Q8P2Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/12] mm/damon/core: use damon_nr_samples_per_aggr() for max merge threshold
Date: Tue,  1 Sep 2026 22:47:34 -0700
Message-ID: <20260902054747.99370-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_merge_regions() open-codes max region merge threshold
calculation.  What it does is fundamentally the same as
damon_nr_samples_per_aggr() but missing a few corner cases.  The
unhandled corner cases should be rare and make only a negligible level
of monitoring results degradation.  But having the inconsistency could
increase future maintenance burden.  Use the dedicated function.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f748acd6bbd5b..846da6df5b552 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3509,8 +3509,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 	unsigned int max_thres;
 	bool count_age = true;
 
-	max_thres = c->attrs.aggr_interval /
-		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
+	max_thres = damon_nr_samples_per_aggr(&c->attrs);
 	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
-- 
2.47.3
