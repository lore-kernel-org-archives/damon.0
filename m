Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A129B766;
	Sun,  5 Jul 2026 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267316; cv=none; b=gSSZwybbR5hmK0/KlN/+KWBCw+sVmSgYTdlwiw4Ct57ICRMiY2CE6d1YorSMhekOVsUih2GKhlWtKe1nAqDkmQupOZW/5a7erLi6vTPTEGsG5xM+BcaTt6FA97DlVzvHKsnV7n40e0oTGj6c+b36pYN3uZKuMfbvWit2+KHMYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267316; c=relaxed/simple;
	bh=hsps4kp0iyx9VZBNJp3v8TVLhzkGxP8sojUovOZB7wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ99PJZlJveam2ixOzrl42CAWGDeRKP+vWUCR8tReI5HUNGF4Pia3Jqcl2IZucuqjNmezEc0SAgWACCJzNmfga4rGnenupGqI5penEUzmDSQl45P2CzOX0M11T1hajUO9TtMAP5SGcdj7d85oppZJHUs8/vZB4SdfPfVKjTIOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbbfNJdB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbbfNJdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17A11F00A3A;
	Sun,  5 Jul 2026 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267315;
	bh=3RIw27JTOSTlyfe8cMjSamOtT4EJIBcA1pGfiTgLcPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UbbfNJdB8QIuJ/3bBGJ0IeV1eniGxVgfpuuHEutH/bF1qVLpFVgwRADWGbOiqhvd7
	 1OB4UcSonjLJkmfzbGKdMsgu1d7yYjXDx7mDMkt95e6HY/0i4+2KwXAM/WuOPVHUEz
	 oiJJMoKYRt+FMz04uYPXox1egQGQ4uuJJuUWfCSDJoFnA3jbr6qxAyYFDOZEoloOpM
	 yjRHswNIM6iSr7WmPtoYCF7VMP0QvsV9ePlgaayEJMiRsw4pn07+6u2l5g6hUgDCAQ
	 WvC8lWeK1RQ8vyKzO2B36xFec8f7BeykQne1qV/Jb84Fx7/G39NhdtW4r7iarM5zyX
	 gIyX3xEttj95Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 09/11] mm/damon/core: wait ctx stop in damon_call() before reruning an error
Date: Sun,  5 Jul 2026 09:01:36 -0700
Message-ID: <20260705160142.97308-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160142.97308-1-sj@kernel.org>
References: <20260705160142.97308-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_call() failure means the DAMON context started its termination.
The termination is asynchronously done in kdamond thread.  The caller's
error handling should handle the race, too.  It is complicated and easy
to make mistakes.

Update damon_call() to ensure the context is stopped in the case, by
waiting until the completion is confirmed.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 08510bf9b38da..390e00b3685ef 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2010,6 +2010,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
  * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
  * wait.
  *
+ * When this function is failed, the @ctx is guaranteed to be stopped.
+ *
  * Return: 0 on success, negative error code otherwise.
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
@@ -2022,7 +2024,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	mutex_lock(&ctx->call_controls_lock);
 	if (ctx->call_controls_obsolete) {
 		mutex_unlock(&ctx->call_controls_lock);
-		return -ECANCELED;
+		goto canceled;
 	}
 	list_add_tail(&control->list, &ctx->call_controls);
 	mutex_unlock(&ctx->call_controls_lock);
@@ -2030,8 +2032,14 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 		return 0;
 	wait_for_completion(&control->completion);
 	if (control->canceled)
-		return -ECANCELED;
+		goto canceled;
 	return 0;
+
+canceled:
+	while (damon_is_running(ctx))
+		schedule_timeout_idle(msecs_to_jiffies(100));
+	return -ECANCELED;
+
 }
 
 /**
-- 
2.47.3
