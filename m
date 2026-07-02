Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C533F5B3;
	Thu,  2 Jul 2026 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026374; cv=none; b=kn3qHMvezUuBbsaD6rIwaf8G6Yive/p+5GWrn4reOmajjv7F5dU32ya5dFjJCUmwLhg6TpdglmjEI7s614SKMsHX2RFdJQXySBgnry/WQQDUdmt363mcLpN4nRYioYVmTM74JBxakwx/7kz7FEpTnlnSKaS2rIor1NgB6n44irM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026374; c=relaxed/simple;
	bh=V8JO+A7dnrCg/1ncTzDlamr6P3PVW1soQkBnie7tpVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxOx7LZVXSW6aGstfUgpYrV+VgYfRIVNXJ1VQ9S/qK08Wr996RJtdeXyK6HICiFwJFjKa7T0lUHlp7MFVDHEDi84TAjFGkQyllobDuIiHlk3L73Ay9Q9ZgUnxHsum0vyf+HjJWJtleGzKyr17mMCRaRPh6exv9Qv71oPB3dkp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Porqi2o2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Porqi2o2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC29C1F00A3A;
	Thu,  2 Jul 2026 21:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783026372;
	bh=flGogPd+rUyChBMLRSMN0vLB2pILqw+V29hJNORLFwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Porqi2o2NHBfwr3i9HRm5oEQCIJdgB3mKb3ntTcUub29r2DSySmsOGJF6kVmR6fiv
	 fjFqUB3sTZFjUZDv8iDlk7zoyHyOpKFaczHoi9HL9BYgyOFy5BwINzvlri1d4cWo9A
	 DI4hGotkdKq9Mz4+aNqC2RrPK+Ach2h26tDjS3wg9oNwn7EFpGez/ISWacEw64v2EG
	 LQ/LDEvrb61A0YxNXJiEI7pkJZhA5mgag6ur7ISJNt6XokeKMYB7w8uJwKTUsz9Ybb
	 PnZPXKznN2sgSFeUUPYs0rwS/LTIsRSGpsN2jzGg9njB3+imF/CYS/fiKqeNGCVx5m
	 asTMFe2j4I6SA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 5/8] mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check
Date: Thu,  2 Jul 2026 14:05:47 -0700
Message-ID: <20260702210551.95167-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702210551.95167-1-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT validates the user input for min_region_sz.  The same
validation is done inside damon_start() and damon_commit_ctx().  Remove
the unnecessary duplicate.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 32f41491b726b..2dd0cd0d26273 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -284,11 +284,6 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
-	if (!is_power_of_2(param_ctx->min_region_sz)) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.47.3
