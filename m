Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8115ECD1;
	Tue, 18 Jun 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734698; cv=none; b=Zv9M8lTRjfT5vBfr2eXEMuYgAhfvb/1rOUMGBdKb2YgA9FrVa0mqBWmcME3j2x2A2G70PihF6tdi69eWGrqRJRPRT1/gHelY9OS9GMzoJ/F2406RVhejMITPU6XBrFSxVMFzgqpbOEUcZabwLXmABiV2xwHLDYcfMNI+9mBLClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734698; c=relaxed/simple;
	bh=iHi9F2LJwfRH7bQXO7MbPtxBZ9hQhqVO/mLP8mATsq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W1mMwAe/U2SVON/hEnLFracSqi7KU+rjwgsHrYHXIWoeconm0ftTuoOtPuQnXOcKVeONL1uKtPLHadEBIxGT9RnRZU7zJlFb+Ghm2yUXx2KMhdjU6BOuGuH20ps9dfJl4U5hFHCKJw7q5GgiCQ5/vDfu8HxWniyofgsV46uekDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYOkhPAI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYOkhPAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A89C4AF49;
	Tue, 18 Jun 2024 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734698;
	bh=iHi9F2LJwfRH7bQXO7MbPtxBZ9hQhqVO/mLP8mATsq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYOkhPAIdBUFDJZuuOt/U3pLKRvSSX6WXYHpo+fIAycQr3OgTttGwtX284KPO+qPd
	 hPVHPYRAtFozTVYqtkOhu2yi1QuxXf0q1fDgbkyNr9zb6YBKJdtc8u3LenvjZxZjhS
	 ikrcX0GVUDeS6WeqszBOgeAe7eDR1c7gJhPc3iHVs8eDGvnMC0s8naVmIA6dH5+QGb
	 ijPhu813BtP4jEPR18XhavPEc9pJ4IgbSuIqyrQRE/2Q5cv/Na8SAX8D4J9Hqo8ams
	 YfHlm52WY2W/hyEXKQLccxzAtQlY4VNpvFvletIxoA/vcD4xKg3jgcWp8zqTeYdfTV
	 BMtuWx94rR9Fg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] mm/damon/sysfs: use damon_commit_ctx()
Date: Tue, 18 Jun 2024 11:18:00 -0700
Message-Id: <20240618181809.82078-4-sj@kernel.org>
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

DAMON_SYSFS manually manipulates DAMON context structs for online
parameters update.  Since the struct contains not only input parameters
but also internal status and operation results, it is not that simple.
Indeed, we found and fixed a few bugs in the code.  Now DAMON core layer
provides a function for the usage, namely damon_commit_ctx().  Replace
the manual manipulation logic with the function.  The core layer
function could have its own bugs, but this change removes a source of
bugs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6fee383bc0c5..0f9fe18beb40 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1345,6 +1345,9 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	return damon_sysfs_set_schemes(ctx, sys_ctx->schemes);
 }
 
+static struct damon_ctx *damon_sysfs_build_ctx(
+		struct damon_sysfs_context *sys_ctx);
+
 /*
  * damon_sysfs_commit_input() - Commit user inputs to a running kdamond.
  * @kdamond:	The kobject wrapper for the associated kdamond.
@@ -1353,14 +1356,22 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
  */
 static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 {
+	struct damon_ctx *param_ctx;
+	int err;
+
 	if (!damon_sysfs_kdamond_running(kdamond))
 		return -EINVAL;
 	/* TODO: Support multiple contexts per kdamond */
 	if (kdamond->contexts->nr != 1)
 		return -EINVAL;
 
-	return damon_sysfs_apply_inputs(kdamond->damon_ctx,
-			kdamond->contexts->contexts_arr[0]);
+	param_ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
+	if (IS_ERR(param_ctx))
+		return PTR_ERR(param_ctx);
+	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
+	damon_sysfs_destroy_targets(param_ctx);
+	damon_destroy_ctx(param_ctx);
+	return err;
 }
 
 static int damon_sysfs_commit_schemes_quota_goals(
-- 
2.39.2

