Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156533E34E;
	Thu, 13 Aug 2026 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593014; cv=none; b=SbnNKj9WgX8ssjBURTpCZP7Y3TuX4DxcQtvd9v9xvbFp9MnDcF1HQa40hHoK8hVKo5ekyr4tEY8cVquDajYLLj/ESUZCdCUJeooXKMcMOeBhQ77VVmUggXGBN4HuRIssmq+h2+0Kw7aMAx4/hbouz03RDrYtMDdaQrjrdi1WflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593014; c=relaxed/simple;
	bh=+w3rxutfnYBNIul7l279XZJ8W0YahLijvuvU2FVYbRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kb1i4efsSIgB4lHa4F5I35xR18wCEC2kOsLSr4iJFjpggowTWT2XDF8kqYSdqhziM/ZgfCUHX5PlLjxjzXlsMVDb3cvOJDkvPHu+jnGlIraZUekjxhlAEh7KKJ9ynxu3XlbxEBgHQ2ge8jamg9M9+2l48ztzkBs9wjzLnsq2RK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6KR54/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6KR54/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7E21F00A3F;
	Thu, 13 Aug 2026 03:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593009;
	bh=a+KFNc38yAs5cF8y2PPkR2gfi2v/4V0wSG+v466VkTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6KR54/rLJ6ePQb83TqoNr8jusNymXRiNaj14b1zv8TRr3k3J+ryDyr8d+rkhKygi
	 U5fDBygBfVu0bhTdsz8bB7ZbWwyHPexkewIv2J+VKov83KofK4K59jFtdBY7PLpGzO
	 um5jy0k/35nTdRW0wblktzbuZZ6qAoNe4cjdyMyrvtAiGNNsxDMCZg9rk8mDiu5Nyg
	 orXJhay8agEVn6stcxkWGnoR+cnU1isxlDgl3uo+7xddVNIfJUqlVH+cDMo65LXzas
	 ZLzRUvAr16bExumbamKbgV7i9en9Wb0VrlFc71DF9occwI+Dkz9q6Ki9S6wzaMa4A1
	 o1aVT6ZpO8Kqw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] mm/damon/lru_sort: remove unnecessary damon_call() param validation
Date: Wed, 12 Aug 2026 20:49:59 -0700
Message-ID: <20260813035001.97364-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813035001.97364-1-sj@kernel.org>
References: <20260813035001.97364-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT avoids passing NULL or unstarted damon_ctx to
damon_call() with its own validation.  The validation is no longer
needed, because the DAMON core layer now handles the corner cases
itself.  Remove the unnecessary check.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index bd847829a9907..f25ee7326e87c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -346,8 +346,6 @@ static int damon_lru_sort_commit_inputs_fn(void *arg)
 	return damon_lru_sort_apply_parameters();
 }
 
-static bool damon_lru_sort_damon_has_started;
-
 static int damon_lru_sort_commit_inputs_store(const char *val,
 					      const struct kernel_param *kp)
 {
@@ -368,10 +366,6 @@ static int damon_lru_sort_commit_inputs_store(const char *val,
 	if (!commit_inputs_request)
 		return 0;
 
-	/* Skip damon_call() if ctx has not successfully started. */
-	if (!damon_lru_sort_damon_has_started)
-		return -EINVAL;
-
 	err = damon_call(ctx, &control);
 
 	return err ? err : control.return_code;
@@ -422,8 +416,6 @@ static int damon_lru_sort_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	if (!damon_lru_sort_damon_has_started)
-		damon_lru_sort_damon_has_started = true;
 	return damon_call(ctx, &call_control);
 }
 
-- 
2.47.3
