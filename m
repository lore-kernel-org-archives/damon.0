Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6620C260565;
	Tue, 16 Sep 2025 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993719; cv=none; b=Zh4JHLwLla9WngQ4GPc+yqlffKEpO0KtWiasPzOLPt5TxO9g0XnSJCigm+W6XEoaKOMB1oPp7MyA23BULVNBVOiNUYGigoKezZCG055CwHvvHswpW4EcOaXZ/orKpfJPibgI7ykqkZHncsOVrr/CLPnEUJKDbSuqgo4t0RL7dZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993719; c=relaxed/simple;
	bh=yq6FzsyzX8HDFFWIsvaokYnQzl9M5W1Jr+HzsSN6nWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4tJAOYHP1i1B/60vg/xjbYLeUrqs96EJQKelV67/mPHwtQU1H0lmT1MQ9MOLU1uQ0AtYMTlO1WfYEQOvy3EY0WTX0BYIBlQyJwkeLXFCltICBnWG1fXwgIaVnK850PEer6thQt1N7P7Pczb8Zj8WNWZUPqbsRif5yO0nfqD9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgVIllP7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgVIllP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D41C4CEF9;
	Tue, 16 Sep 2025 03:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993719;
	bh=yq6FzsyzX8HDFFWIsvaokYnQzl9M5W1Jr+HzsSN6nWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgVIllP7jG1t5xaNp6Ej7+6h6D0S3fE4uC/XLFrEWCBoHupYxjo9jV8rDMtz0S3LQ
	 nSZfP4F1iftVGRQFLXoEfzfEu6hrCwigUaTVghy+Uh2475SNcT6Vc+ZaBN19ZR1F7q
	 EH9fdMvVUtRXl8y01N9V8dL0SoALaK3UjU3OBTnN4dA7SiZvo/f6g4ZUOpWgRx8HZO
	 j4gSlqY+X6drLgbfTvW7KyNnpbH/6dU1S6yy16KXPRd92YW5bNuTuSRb95+gx1XoQh
	 xIcz6dCNGllxAKbbucMBlLLCZTKCiaAsrI0OouakMAihQ0vW/nF68rW7qsF81YRvP4
	 kWSCCN3mKRzzw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/7] mm/damon/stat: use damon_initialized()
Date: Mon, 15 Sep 2025 20:35:06 -0700
Message-Id: <20250916033511.116366-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916033511.116366-1-sj@kernel.org>
References: <20250916033511.116366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT is assuming DAMON is ready to use in module_init time, and
uses its own hack to see if it is the time.  Use damon_initialized(),
which is a way for seeing if DAMON is ready to be used that is more
reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 87bcd8866d4b..c4fbd8cfa5eb 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -214,8 +214,6 @@ static void damon_stat_stop(void)
 	damon_destroy_ctx(damon_stat_context);
 }
 
-static bool damon_stat_init_called;
-
 static int damon_stat_enabled_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -229,7 +227,7 @@ static int damon_stat_enabled_store(
 	if (is_enabled == enabled)
 		return 0;
 
-	if (!damon_stat_init_called)
+	if (!damon_initialized())
 		/*
 		 * probably called from command line parsing (parse_args()).
 		 * Cannot call damon_new_ctx().  Let damon_stat_init() handle.
@@ -250,12 +248,16 @@ static int __init damon_stat_init(void)
 {
 	int err = 0;
 
-	damon_stat_init_called = true;
+	if (!damon_initialized()) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	/* probably set via command line */
 	if (enabled)
 		err = damon_stat_start();
 
+out:
 	if (err && enabled)
 		enabled = false;
 	return err;
-- 
2.39.5
