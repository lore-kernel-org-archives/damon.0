Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101D2BE7AC;
	Sun,  6 Jul 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832037; cv=none; b=OB1swLS/yiIHOeo+/tSo48Aeo8bHF7Rr5MSk9CDat7p5Vwy+Jjz4YWb36n5DnPDzmeZEfh+XW49ftY6RzjazMpBRCALxEoHY37N8CToqgqqxlG9mT82ryw9oHoJVUl1oAdTUtSSAbzsS4ELlA1FNftCiLQyZKT00CiaL5AyBR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832037; c=relaxed/simple;
	bh=dnbBIoiWMyEPhOBD2O+z/mHI1a/WsMzxyryGAQlSQsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6cGhK/sElkxCaM5T1ntLMEZuEDlM4MpCvk6sRMzEOxU4eiZ60hxfDyEBpfHFE/BAnvwEs9tC8sCLpDODGJGX2zcu0U7qJiHj+LV6ah+m9YbpCf4e3m3v5So8Hiv2SuThOdZlkUo/d+svLEY0GUVly0TovELVYH4EABknQ8A5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fck4arrF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fck4arrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D54FC4CEF3;
	Sun,  6 Jul 2025 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832036;
	bh=dnbBIoiWMyEPhOBD2O+z/mHI1a/WsMzxyryGAQlSQsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fck4arrF4zOiEsMM2KixvP9bY4CrTLZdZmsGgyAw4WFOQ3EuBfiM5q7+fYkRi9jrc
	 2iSARDSXSgWCcG+Aok1uQ8KZJrFt+y8QVZADce3/aW4+tAw+djptIGH+zqNMhGL02i
	 PtfhySHItgjb30S+G2+AKDAuGxUf6WgGoHzWfKhNRzAzWJFxizsOM+dFQFO2ChtILw
	 Ec/Elo4Vt15QtAqaqI34j8F+LTXxpQCSkTx79mgOL9l8JhoL18bsO0JMiOqxHn3bT7
	 3emhbaSmmTKkY0GOeANGAU0cnsaX2d0Zf64Icv22zpPs3H90buLXg4F/3b6QOr4Iks
	 BBbhFyVj+JDPg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/14] mm/damon/sysfs: remove damon_sysfs_destroy_targets()
Date: Sun,  6 Jul 2025 13:00:15 -0700
Message-Id: <20250706200018.42704-12-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-1-sj@kernel.org>
References: <20250706200018.42704-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function was introduced for putting pids and deallocating
unnecessary targets.  Hence it is called before damon_destroy_ctx().
Now vaddr puts pid for each target destruction (cleanup_target()).
damon_destroy_ctx() deallocates the targets anyway.  So
damon_sysfs_destroy_targets() has no reason to exist.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5eba6ac53939..b0f7c60d655a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1295,14 +1295,6 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	return damon_set_attrs(ctx, &attrs);
 }
 
-static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
-{
-	struct damon_target *t, *next;
-
-	damon_for_each_target_safe(t, next, ctx)
-		damon_destroy_target(t, ctx);
-}
-
 static int damon_sysfs_set_regions(struct damon_target *t,
 		struct damon_sysfs_regions *sysfs_regions)
 {
@@ -1337,7 +1329,6 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 		struct damon_ctx *ctx)
 {
 	struct damon_target *t = damon_new_target();
-	int err = -EINVAL;
 
 	if (!t)
 		return -ENOMEM;
@@ -1345,16 +1336,10 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 	if (damon_target_has_pid(ctx)) {
 		t->pid = find_get_pid(sys_target->pid);
 		if (!t->pid)
-			goto destroy_targets_out;
+			/* caller will destroy targets */
+			return -EINVAL;
 	}
-	err = damon_sysfs_set_regions(t, sys_target->regions);
-	if (err)
-		goto destroy_targets_out;
-	return 0;
-
-destroy_targets_out:
-	damon_sysfs_destroy_targets(ctx);
-	return err;
+	return damon_sysfs_set_regions(t, sys_target->regions);
 }
 
 static int damon_sysfs_add_targets(struct damon_ctx *ctx,
@@ -1458,13 +1443,11 @@ static int damon_sysfs_commit_input(void *data)
 	test_ctx = damon_new_ctx();
 	err = damon_commit_ctx(test_ctx, param_ctx);
 	if (err) {
-		damon_sysfs_destroy_targets(test_ctx);
 		damon_destroy_ctx(test_ctx);
 		goto out;
 	}
 	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
 out:
-	damon_sysfs_destroy_targets(param_ctx);
 	damon_destroy_ctx(param_ctx);
 	return err;
 }
-- 
2.39.5
