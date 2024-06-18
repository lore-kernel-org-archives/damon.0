Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC943161906;
	Tue, 18 Jun 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734703; cv=none; b=Dq4pmE36CZQFNmacyQlE21vd5X9PnhokRT6fGEXgVEv0A82SUhsg2UgrK6js1kDMG5CJVe2PLNrM+ET55P3ECP9yKIxONVWTnKJtckiZk+Ac1WKQrNwDctu9MnQvtS01WXrR21fJJWlm6kGTbUCTTPq4WlBcAJqj1b1XYqpA5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734703; c=relaxed/simple;
	bh=Y0WL72ENjXuzcYBbbK9ft+KRSGtN7fHgxSV1OXgDM6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjSCI0lhTVbh04GfSyH1TEW7VxWQzspqc5b5jaylnwau61k7N1z+Uf+OoNw6mRhm9WGl6Mht7VHRNw/VRmiqXYWso6Faz+tq47KYNHHOQGSl3p2wZuuBKoHQXFqRcAoq7TpO4VqdiJjHCaQOGYqaisj8vAa6hrbkAd2kfWYQof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwfqITNf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwfqITNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF79C4AF62;
	Tue, 18 Jun 2024 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734703;
	bh=Y0WL72ENjXuzcYBbbK9ft+KRSGtN7fHgxSV1OXgDM6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwfqITNfa3Gj1ma2qV/KzR8qnMeqp295ZGO60CRb4JZdppxB2/90KPDXFex+I8IS9
	 qE2LEd69le3pgiaIGSfyZY7/VMgIQMiVEqUnU99WRufDW3uEvBp/IrWj/wiHmY/wUm
	 ridb+Gzi6oKnW4Rj2zaqD8u95VTwStfTtH1nakd76T3lZofQqJbQ89Gs5Rf0n9mxJB
	 ZCKyZutBvmraNTr/twF/Qe0CHL7uda40NlCilWCFepZ9a4+P0/MaWYcfj9wIqDFWFB
	 Ap88kFf1HArbbAbyQhpoFj+bDyRC22LC5jT3qnFdywRo5kaVmNKCZ4+z0+3Xizuwtt
	 nxOJIHeqamhbg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] mm/damon/lru_sort: use damon_commit_ctx()
Date: Tue, 18 Jun 2024 11:18:08 -0700
Message-Id: <20240618181809.82078-12-sj@kernel.org>
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

DAMON_LRU_SORT manually manipulates the DAMON context struct for online
parameters update.  Since the struct contains not only input parameters
but also internal status and operation results, it is not that simple.
Indeed, we found and fixed a few bugs in the code.  Now DAMON core layer
provides a function for the usage, namely damon_commit_ctx().  Replace
the manual manipulation logic with the function.  The core layer
function could have its own bugs, but this change removes a source of
bugs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3775f0f2743d..f83542973946 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -199,15 +199,22 @@ static void damon_lru_sort_copy_quota_status(struct damos_quota *dst,
 
 static int damon_lru_sort_apply_parameters(void)
 {
+	struct damon_ctx *param_ctx;
+	struct damon_target *param_target;
 	struct damos *scheme, *hot_scheme, *cold_scheme;
 	struct damos *old_hot_scheme = NULL, *old_cold_scheme = NULL;
 	unsigned int hot_thres, cold_thres;
-	int err = 0;
+	int err;
 
-	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
+	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
 	if (err)
 		return err;
 
+	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
+	if (err)
+		goto out;
+
+	err = -ENOMEM;
 	damon_for_each_scheme(scheme, ctx) {
 		if (!old_hot_scheme) {
 			old_hot_scheme = scheme;
@@ -220,7 +227,7 @@ static int damon_lru_sort_apply_parameters(void)
 		hot_thres_access_freq / 1000;
 	hot_scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!hot_scheme)
-		return -ENOMEM;
+		goto out;
 	if (old_hot_scheme)
 		damon_lru_sort_copy_quota_status(&hot_scheme->quota,
 				&old_hot_scheme->quota);
@@ -229,18 +236,24 @@ static int damon_lru_sort_apply_parameters(void)
 	cold_scheme = damon_lru_sort_new_cold_scheme(cold_thres);
 	if (!cold_scheme) {
 		damon_destroy_scheme(hot_scheme);
-		return -ENOMEM;
+		goto out;
 	}
 	if (old_cold_scheme)
 		damon_lru_sort_copy_quota_status(&cold_scheme->quota,
 				&old_cold_scheme->quota);
 
-	damon_set_schemes(ctx, &hot_scheme, 1);
-	damon_add_scheme(ctx, cold_scheme);
+	damon_set_schemes(param_ctx, &hot_scheme, 1);
+	damon_add_scheme(param_ctx, cold_scheme);
 
-	return damon_set_region_biggest_system_ram_default(target,
+	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end);
+	if (err)
+		goto out;
+	err = damon_commit_ctx(ctx, param_ctx);
+out:
+	damon_destroy_ctx(param_ctx);
+	return err;
 }
 
 static int damon_lru_sort_turn(bool on)
-- 
2.39.2

