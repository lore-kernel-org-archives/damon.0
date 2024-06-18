Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46315EFDA;
	Tue, 18 Jun 2024 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734700; cv=none; b=IADHHNZz26ooD6J/6timw8R7e+BdWqGxwkDQNGekX81v57gy7a2e2w7fBA/nmpKpIhPL4E9cGrpe0BIBQTFYT/wfKL9Pf6Oik8Bu85VRC29ZFopppAkoZebrdSy3stTc1F484Vxa4mGCI4cLVvoHQAE1X5YkRY+TbVVQptMBll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734700; c=relaxed/simple;
	bh=EJciIpJkn54LApe2WvU8Qvem30aT3O4bHfII25VjoqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEaMHTYboBHoMC5VJ+Huvv/CgDpw3Uqwq+1BfztCp0BQoGVQ5MUFHP2cQMpRnDA0JT/b8EMYvvHYsDNn2uNV5GVVloUcPF2PQNgoTaBExXHVngbfDT59om9OrcjW446Dg111MFAoGgcjLsVewU3wQKZcZbtxG8ndEmpbrsKuAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjoSmauB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjoSmauB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F2AC4AF53;
	Tue, 18 Jun 2024 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734700;
	bh=EJciIpJkn54LApe2WvU8Qvem30aT3O4bHfII25VjoqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PjoSmauBnyzwWhhnbMqKVxNzt+ZsloVpP7l+vWj1e6DIaRfGZ3ecZyu3aYIrRHwYq
	 gkYh0jfvuo91oJYjeFefoLFGuNHTWx/VQfwOUDYtq+WQfSeG4aHju3NPphSufmZDyM
	 VWIyveow4XQMugCPdEuTG2g0AH3Tr4mbFNjFRDVLRLCqG4QoINhx0aID0+Fk7iua0e
	 0AkN3SLPSEwlx0oOoCZfq2l6hTpiZfVxH9zikTxB4s43cawJzfrIIf5NleDNwmsobB
	 jwsAooNpgTPmqUC3y0o4YPvlJZ4SG6JvAfZiFK0AhcaQDvsd4HaeqkFXdWHxr4yTwL
	 ze7fOUTGtpCXA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] mm/damon/sysfs: rename damon_sysfs_set_targets() to ...add_targets()
Date: Tue, 18 Jun 2024 11:18:03 -0700
Message-Id: <20240618181809.82078-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618181809.82078-1-sj@kernel.org>
References: <20240618181809.82078-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function was for updating DAMON structs that may or may not be
partially populated.  Hence it was not for only adding items, but also
removing unnecessary items and updating items in-place.  A previous
commit has changed the function to assume the structs are not partially
populated, and do only adding items.  Make the function name better
explain the behavior.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-test.h | 8 ++++----
 mm/damon/sysfs.c      | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs-test.h b/mm/damon/sysfs-test.h
index 43a15156a7c3..1c9b596057a7 100644
--- a/mm/damon/sysfs-test.h
+++ b/mm/damon/sysfs-test.h
@@ -38,7 +38,7 @@ static int __damon_sysfs_test_get_any_pid(int min, int max)
 	return -1;
 }
 
-static void damon_sysfs_test_set_targets(struct kunit *test)
+static void damon_sysfs_test_add_targets(struct kunit *test)
 {
 	struct damon_sysfs_targets *sysfs_targets;
 	struct damon_sysfs_target *sysfs_target;
@@ -56,12 +56,12 @@ static void damon_sysfs_test_set_targets(struct kunit *test)
 
 	ctx = damon_new_ctx();
 
-	damon_sysfs_set_targets(ctx, sysfs_targets);
+	damon_sysfs_add_targets(ctx, sysfs_targets);
 	KUNIT_EXPECT_EQ(test, 1u, nr_damon_targets(ctx));
 
 	sysfs_target->pid = __damon_sysfs_test_get_any_pid(
 			sysfs_target->pid + 1, 200);
-	damon_sysfs_set_targets(ctx, sysfs_targets);
+	damon_sysfs_add_targets(ctx, sysfs_targets);
 	KUNIT_EXPECT_EQ(test, 2u, nr_damon_targets(ctx));
 
 	damon_destroy_ctx(ctx);
@@ -71,7 +71,7 @@ static void damon_sysfs_test_set_targets(struct kunit *test)
 }
 
 static struct kunit_case damon_sysfs_test_cases[] = {
-	KUNIT_CASE(damon_sysfs_test_set_targets),
+	KUNIT_CASE(damon_sysfs_test_add_targets),
 	{},
 };
 
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c729222797b8..f83ea6a166c6 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1162,7 +1162,7 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 	return err;
 }
 
-static int damon_sysfs_set_targets(struct damon_ctx *ctx,
+static int damon_sysfs_add_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
 	int i, err;
@@ -1283,7 +1283,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
-	err = damon_sysfs_set_targets(ctx, sys_ctx->targets);
+	err = damon_sysfs_add_targets(ctx, sys_ctx->targets);
 	if (err)
 		return err;
 	return damon_sysfs_set_schemes(ctx, sys_ctx->schemes);
-- 
2.39.2

