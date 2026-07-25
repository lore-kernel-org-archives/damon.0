Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844D37DEAA;
	Sat, 25 Jul 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013360; cv=none; b=DPG+WWjbV69YlDMQ2J/eKUwFdBuuKkp/j4ksjpAIquPXxydxJuLcvBzP4FqTA3z7Sk1t3SiG9stuflnEXKopV2zndmLihp3ija+mNP1r6Rt36+7jJ37Z+V+lX6c8Khto3Dl459L8UI4HnHRLwc9B9uLgYRoBrB5pJ2d4LVekcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013360; c=relaxed/simple;
	bh=G8UyQpSSr7hx3KQele5DhO9AhR7lBDUtfyry3fRhzos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9VylMEK1hOp69UK5W6tbpZtA6bNk1SyGdhnS1iqy9gnkBPLsNe8O4WJPTs/8GR9bk3pSucQPB1fOEkZ1nV1U3mMCJqxvjmhfb4EeDrW1pq7bRkY2EA1UXzcGLCe2HrL1YYZ2EUPYABYWzDjATGXU6wZIP6HUhU78D7NX56V9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz/g3ZxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz/g3ZxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D301F00AC4;
	Sat, 25 Jul 2026 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013359;
	bh=5v3u710N58c3BJ9vFyK6txOeRAXwyATfa8JLFV4jnT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qz/g3ZxXZrDOSZEFWvkzLaEOGPtwpojxJbqoJ73uGD914LJGYs8uegJ8d8rWgy0bC
	 Sk0x2IerEWScVOg0Sr1xIRSCa9wCMc2O6jAA/Aibf5nQvF95ofcFwVDbeyhuhdRkeR
	 cQrdPU5f2bnNBpk+Oe1j6Buh2a1Rw6n9U/olXni0X7dSmcZZeGf8Ah7sNiJrrUCjkH
	 +BSVqFRIMNrCn31eHKJBnujLp2IkjaH0mwTGLaasHSnT9bkmUcSuxbn38+h7Jy4nr/
	 OJtBH3NKgjOoLfySBthJ6SemEUm+H+tUjrzzky7jhwIHFuvsbgkTx648B/nK0e+vHx
	 k2YfzOvKEt1IA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 13/17] mm/damon/sysfs: pass preps to DAMON core
Date: Sat, 25 Jul 2026 14:02:17 -0700
Message-ID: <20260725210225.129944-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface provides the files for setting DAMON probe preps.
But the underlying code is not really passing the user-set values to
DAMON core.  Pass those.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f275a6f73eee1..d7a2b62322841 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2174,6 +2174,23 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	return damon_set_attrs(ctx, &attrs);
 }
 
+static int damon_sysfs_set_preps(struct damon_probe *probe,
+		struct damon_sysfs_preps *sys_preps)
+{
+	int i;
+
+	for (i = 0; i < sys_preps->nr; i++) {
+		struct damon_sysfs_prep *sys_prep = sys_preps->preps_arr[i];
+		struct damon_prep *prep;
+
+		prep = damon_new_prep(sys_prep->action);
+		if (!prep)
+			return -ENOMEM;
+		damon_add_prep(probe, prep);
+	}
+	return 0;
+}
+
 static int damon_sysfs_set_filters(struct damon_probe *probe,
 		struct damon_sysfs_filters *sys_filters)
 {
@@ -2209,7 +2226,15 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
 		struct damon_sysfs_probe *sys_probe)
 {
 	struct damon_sysfs_filters *sys_filters;
+	struct damon_sysfs_preps *sys_preps;
+	int err;
 
+	sys_preps = sys_probe->preps;
+	if (sys_preps) {
+		err = damon_sysfs_set_preps(probe, sys_preps);
+		if (err)
+			return err;
+	}
 	sys_filters = sys_probe->filters;
 	if (!sys_filters)
 		return 0;
-- 
2.47.3
