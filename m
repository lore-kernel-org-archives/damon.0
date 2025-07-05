Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E520012B;
	Sat,  5 Jul 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751737808; cv=none; b=aYCLpkRSb/FpKle9MXNRwRoagxShk/q1ZLbOG9QsHW/4WrA9yO4H8RfIUHK+cNl18JqPnMtFikct7Xb27bIZTvSDC8eQxVpQnrvY8i/zOP3fYc1GsNoBvU2LSde2T85stsRUentNd7U5DEjEq8MVWn7LG9TvoXBWTWHK5pRYxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751737808; c=relaxed/simple;
	bh=caVLtvekI2dzKAOKguvjHyIU7EwG2c4nf8nQzeNWT3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqxdIKzO1XXRFwd3+fKEjb64yFrejyH6hp0VV0k5sz56o/wfDOn9vdM4kW2YOYAJo8noX3ea3HgepjgLot2Dw/hQO75hS8TjY37qAdaV0LWBgyHJ76+KaReZ0YOykwXWceKN1xlYKwlCfYbwMJa+OMfPftvJrkXL2pI7hB0Jmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8nDk0gF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8nDk0gF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64686C4CEE7;
	Sat,  5 Jul 2025 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751737808;
	bh=caVLtvekI2dzKAOKguvjHyIU7EwG2c4nf8nQzeNWT3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8nDk0gFwQeLCYbtF1Ywc2Mz43fM1+I0QceZxnPvEobJuN90FWckiRruTCUJhwQ0L
	 nAG0r7kprHtPRSZUV+7l8rsFbc4H5MhhN2Oc20WYhG8u3ozv6qLcw/TVQLMGl0lmsN
	 Tm+yNTWMKdrVpYYG/RuCSWKVMbwOfYMbDzae5/wE/mzGbKMvbuWdigABUN2OR7gqJS
	 NKSbboGyZXC8RRISuj0rFhwJxGAyPDpNhc7zN3P3jSV/uuS/Bfso7IE5Ebm4Djkgd6
	 svBkcm0ZxUvFwvmi8gYZhQw5LOpdkq59Qr47iuu62BzI/LlsV0KXlzJK6HvbxDAQ5l
	 A1hoil7Qvj5Zg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/6] mm/damon/sysfs: don't hold kdamond_lock in before_terminate()
Date: Sat,  5 Jul 2025 10:49:59 -0700
Message-Id: <20250705175000.56259-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250705175000.56259-1-sj@kernel.org>
References: <20250705175000.56259-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_before_terminate() is a DAMON callback that is executed from
the kdamond's context.  Hence it is safe to access DAMON context
internal data.  But the function is unnecessarily holding kdamond_lock
of the context.  It is just unnecessary.  Remove the locking code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 79d65dcc9dd0..c0193de6fb9a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1387,12 +1387,10 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	if (!damon_target_has_pid(ctx))
 		return;
 
-	mutex_lock(&ctx->kdamond_lock);
 	damon_for_each_target_safe(t, next, ctx) {
 		put_pid(t->pid);
 		damon_destroy_target(t);
 	}
-	mutex_unlock(&ctx->kdamond_lock);
 }
 
 /*
-- 
2.39.5
