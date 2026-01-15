Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9813B8BB9;
	Thu, 15 Jan 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490454; cv=none; b=RO7VgDdHXWtmzJ/8PFgFSDtyvc6OJSk96eNg5bgoIuie36uhj8qgksl3220jR0hotppADXnhecak9N3eQ10P3KJfc5+xqVQWCMw1BbAfJ3aBsldauUAxQ3DYLPM17adjNtuBwXW2HKhSpwUVi8qjuTdNy+znzu9WDYPYDKIw6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490454; c=relaxed/simple;
	bh=DxQCMUOdwfVtYBKudfkzYSOHXwwjcEpLd/GD9gGY3VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hohVHAIGpUS17M2J+xqdo/9dRVjZQ8xtkfVRkehn9sWNQRyopeIN5lOh3VehiCCx2CqxhQzZAaPPjkaUA/NoqzQ9REwQnlrtC04qV37ExTzDq2nw1ctUzLwT/tDyJTwsUnZFaHwJnXqiMToOnnr5HudvlWWZ9ePbGENQAue5i28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl7/Br9r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl7/Br9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B109C19422;
	Thu, 15 Jan 2026 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768490453;
	bh=DxQCMUOdwfVtYBKudfkzYSOHXwwjcEpLd/GD9gGY3VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tl7/Br9r01iHEBaBIVHmGqZfuDwsnmz2afTYicmtxxNa6k0nRAINIxKRTLmbWaM5y
	 9EqRpg1QaEuJ3LknjWRWIDGuBnb9s25158SuDmf0xp9UMsYXVnkdVTnilrFX04FrcE
	 sUQYP0cjKX/eKWotlEEoUN+waZuyjJAVdVW/h6OWPtrA3VCGtisK57ioKaSj46kDvF
	 Y8hxeR4ciM6fHhCQhU3TpBPiiSY0cbPoo7fP5OauL48vG2q/hv8ydG4gemfK526eSA
	 BhgV7kKdlnonPzxIVsYFu2kNWfnIjZcq4SHPDLzP5YLJs9daMS5eVmbpez6QkYgj7p
	 xZankSgOwoVmQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] mm/damon/sysfs: use damon_kdamond_pid()
Date: Thu, 15 Jan 2026 07:20:42 -0800
Message-ID: <20260115152047.68415-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115152047.68415-1-sj@kernel.org>
References: <20260115152047.68415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface directly uses damon_ctx->kdamond field with manual
synchronization using damon_ctx->kdamond_lock, to get the pid of the
kdamond.  Use a new dedicated function for the purpose, namely
damon_kdamond_pid(), since that doesn't require manual and error-prone
synchronization.

Avoid use of kdamond_lock outside of the core.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 95fd9375a7d8..4de25708b05a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1819,10 +1819,9 @@ static ssize_t pid_show(struct kobject *kobj,
 	if (!ctx)
 		goto out;
 
-	mutex_lock(&ctx->kdamond_lock);
-	if (ctx->kdamond)
-		pid = ctx->kdamond->pid;
-	mutex_unlock(&ctx->kdamond_lock);
+	pid = damon_kdamond_pid(ctx);
+	if (pid < 0)
+		pid = -1;
 out:
 	mutex_unlock(&damon_sysfs_lock);
 	return sysfs_emit(buf, "%d\n", pid);
-- 
2.47.3
