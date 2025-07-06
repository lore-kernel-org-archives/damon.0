Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4B226D18;
	Sun,  6 Jul 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751830335; cv=none; b=hB1OgN3zhoqrdJZXRcihaU+9x7sE1ZcXb9iZg+nl9s9ggGCz13igzzqEVRroM/BI0+eiJdOhuxZ3nyrqDck2Vn9yTHd2V5V0Jopu1R8Atp/J87Yo/Z0HJrKIFEFonH2oe2eKZbz9bG3LHW8qKiCGjleLjrecJ0GGhDQNDnb/BQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751830335; c=relaxed/simple;
	bh=iRbDRRBdy920t5w60L/6dOK5zIzjusH9p6xCWRALcoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODlwQ7+UXHlXbFcdb7X6EiWwDdHGuyTS49lKqPiPhZUBrfz6JFiHWVYiZjIwWU47yyX1uYu0FETJ+t9DrN0uF4aUn3JQT93stSLpf+xvYklmtf81dI69ZSzvzbCntDr2bCxKBUegTCk1bMsZySwd6QyrArGrESr7ULX4xPJsbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp4Dm5E/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp4Dm5E/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C82C4CEEE;
	Sun,  6 Jul 2025 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751830335;
	bh=iRbDRRBdy920t5w60L/6dOK5zIzjusH9p6xCWRALcoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pp4Dm5E/nbhA75Wq1v/zugIkgMxTI08nllee9NR2IzqA406U4JCM86QvyqD/RgDiH
	 NTAlxK+UoF9DyvUo+6TJzktytbzYmZZIOVHcTrIXXpDh0zX2uoFXj0X2mQf7IaTclK
	 8P5qqdBkMJh1qgYphtDK3s8KMLCq39hrAcxHXmthkKumR/2mjCYDD7Fxj/cTi1oXiR
	 jc2Skv/goone3434aiDwZdi19hsdhn8lIn4IcRDmQpYvLdiA+1oGaSUTbNJLzCfZxH
	 q6CzS3d0691f9VzTKI62okfv4qDNNADJZTh8Va+h5I2AihqRmuKVZG0ldf4cNsT8NF
	 fU2g9zh3zIaGA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/6] mm/damon/reclaim: reset enabled when DAMON start failed
Date: Sun,  6 Jul 2025 12:32:05 -0700
Message-Id: <20250706193207.39810-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706193207.39810-1-sj@kernel.org>
References: <20250706193207.39810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the startup fails, 'enabled' parameter is not reset.  As a result,
users show the parameter 'Y' while it is not really working.  Fix it by
resetting 'enabled' to 'false' when the work is failed.

Fixes: 04e98764befa ("mm/damon/reclaim: enable and disable synchronously")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index a675150965e0..c91098d8aa51 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -329,7 +329,7 @@ static int __init damon_reclaim_init(void)
 	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 
 	if (err)
-		return err;
+		goto out;
 
 	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
@@ -338,6 +338,9 @@ static int __init damon_reclaim_init(void)
 	if (enabled)
 		err = damon_reclaim_turn(true);
 
+out:
+	if (err && enabled)
+		enabled = false;
 	return err;
 }
 
-- 
2.39.5
