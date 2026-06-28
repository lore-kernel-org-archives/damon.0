Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4883BCD07;
	Sun, 28 Jun 2026 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684091; cv=none; b=izvcGCZjCerZ8RmFpz1ijwGofJQrh3plDdof0QRBZwBtwnGfEND5pTPoOWYnr3TgPlPdWN7SENrxDBz1oy/D0RyTsd8zh6jDsEBjVQm8d3AeOHGl547ZXjNt3i9Qf85ae3d7pI6Ibyp2bztoodURPJKuINE2Zfmctwij7NFT2g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684091; c=relaxed/simple;
	bh=MxzkkC7E5ScZIUD+4/gtRKYzp07IiwB5UPHJVRb/pC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KU8Rrzx94EOKubOXIIt2Jz5GHr3tgmP7PHzJrTeOWwxgVYx0lw9wSFPwFRmmYXUHX67sEK69YNzdNjTQOXL93jE/Kd9pnHxyJRZRKmBq0mkwjiOx6PxdDI+8xb5iFXMihYAnTVxgCZ2633sc+RkoC48wlSCaRvDWwBhPEiA0+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYkzKfma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYkzKfma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1B71F00A3E;
	Sun, 28 Jun 2026 22:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684089;
	bh=2uBHDdQtU7p9MN0ZSWr3YOPnVjS1vyYPgmIElFEJHkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYkzKfma/az9hJtX3o8fslYCyrTjH4g5+2Nnb3gDweQsi3S4IKNMKIOqPMptjl90v
	 Tn9VAD502HeVg1HCPsQ9DBKcch9Z/j5Y9NcNQ6jWgdqUWcFgnNeuegFxnCk6ptexnZ
	 XfIVh8EN9XgVwXwOLx+/c/CCAuHsZe2seA+NMHxc+UJDwfabGinvW5TsJRoculbuQ+
	 rcjQRE6wzGgN+TQLeoqTKPTXLoaSVeAAS1aUOCYMzVPYFzyQjPi3K6SyTvE3hDGHuU
	 XiXr4FG6aUC0idRqvIa1soNF9mLO5uV0wV66+H3TvM1hHcqfkWwiutY7GiiDZ6z/8g
	 iXUfF3tAummQg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/11] mm/damon/sysfs: kobject_del() probe filter dirs
Date: Sun, 28 Jun 2026 15:01:18 -0700
Message-ID: <20260628220121.97360-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628220121.97360-1-sj@kernel.org>
References: <20260628220121.97360-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for data attribute probe filter directories by adding
kobject_del() calls.

Fixes: 82e66aef7714 ("mm/damon/sysfs: implement filter dir")
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 9f92ebdb28574..0ccdc71275d52 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -960,8 +960,10 @@ static void damon_sysfs_filters_rm_dirs(struct damon_sysfs_filters *filters)
 	struct damon_sysfs_filter **filters_arr = filters->filters_arr;
 	int i;
 
-	for (i = 0; i < filters->nr; i++)
+	for (i = 0; i < filters->nr; i++) {
+		kobject_del(&filters_arr[i]->kobj);
 		kobject_put(&filters_arr[i]->kobj);
+	}
 	filters->nr = 0;
 	kfree(filters_arr);
 	filters->filters_arr = NULL;
-- 
2.47.3
