Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B32D9EF0
	for <damon@lists.linux.dev>; Sat, 21 Mar 2026 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774052811; cv=none; b=tVrQaCiMLh9Z5Yrma4KUHdLVZQ1+kizm8YdTA0/619oXpuTOJ6FKGFSuKY2Vp7RPrhO43nOsEOv8+SaejoQGlHqFG+or5/BXTBoBKUfP3/Yskzq/XiT/0eMEIbMDGLqonBLxW4OCTF8bVlSlhlypBI/KthUbc96p76SgfICbs+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774052811; c=relaxed/simple;
	bh=YIVOJ2wxRIYfBIgvNnevnKfiqT3I2zmVWdVIchsOQxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkjDuRt0+k06PoonYfDMIlX5I8JerJN/UmJUTtiMZa23vkeUeI9f/dK2A9Iy6xrcWqKKHJ0F2Umi9O3tTiOOWTqUdq/VqxURDmFwNsjHVSITnKiVBiHYocRnioCkwY5ix0Jwx0OruQ2hwkThQHFDBtCezXYGIgWUmiES+IDxj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlIW6Cuj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlIW6Cuj"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so1321816a91.1
        for <damon@lists.linux.dev>; Fri, 20 Mar 2026 17:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774052809; x=1774657609; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKlHM69nSPICw8Bck17U5ux4/b96tqy8A5ZALWfO5aI=;
        b=VlIW6CujKtK5AhuI0dBIPpDTlMJEohHLS+lLWCjNKcz267Juk+36+mVniP/0G4eJF8
         73teLwhuQiMONcjjQtwRu8VYWN336uAHRWDK+9PeT5pEobW7L/J8ARXe8OVfAvJRsV5F
         aA1gA4Eg8L8lW9kxxFl5OedlX+27lQWvqoR2dUYfl93uJLIq+2zxXu+xMAlwocm0QuL7
         K2DkaCiFHVkPyx9omV6rmcwYmcQC90axqbzjFYx1YvDaglsZxVqzNpu5Kduys51Xy9xh
         x3GFJq+sVpG/F1z+PP6t53M9VcMGDZsTvQ6wRJPlB7Lntp91XR6CsgjFvHJlRuiAo5e2
         0n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774052809; x=1774657609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKlHM69nSPICw8Bck17U5ux4/b96tqy8A5ZALWfO5aI=;
        b=d6flNQZjalJgt9afd2wmd5OrNIAzK58577MEuaZNW4yh+8XPEftR9EifOTc/0tGj5R
         cjxkHskLkaI+y1kX+kwsrBZ2eeWgH3bqNxY91lh1+shmyjI/1JyP7xn3LKl+aefbv17e
         rmmPwXpXhFYF6hm4MXwv5NmiOOR1JGaPQaGs5YVNWt1pI6AxmRvbRYQS1pOD/81byf9V
         oMHfiakJ7FoCzJZHbbd4otufOalW1VpntRAxdKly7UWK44hvpERiq94FH6PAy8H+cvJA
         3dgbd82+O6fwvjPsJiBW1kJvnDsed77fWgFB3oCIk444lbAjcDrPgkQjc2EmKycBQTXT
         2Hkg==
X-Gm-Message-State: AOJu0Yx2YUeGZxuxlTucw79VhmmEB5XAy8o/Hibl1nLErAMqqNmbfLSI
	/cTjjQ6VP5qbHLQwYi6GGEdoFLV5MNpvH9/FSqlb8Py0LHmN4OpFSXjL
X-Gm-Gg: ATEYQzyvg1Q3MRWxylMVt/oSdIazEQq5wBZg+blUt21SEjib/pjolHKkimsPtWUN+NU
	JUxLYA+nLg+uS1HRteB+BBxiCMLNVYzZRViKyLG2rP6RNanrizEk+/tB4lIao35vZOly93D513c
	FThR9hYjBYyIqngjASMkYg1pxgiJz/9pKXPGgOdK2QwxuuDkn78dViwNWhxpN+BKdNhrwbNRtKi
	D+YMOycyrFX/pQnKg5quhq2/qgkO1Nc2JvGo4MIK5wTxtmnZuqMWT58TjiOtOSTaBbu6gcFxZBC
	Sa15+Qb7gkztr8FAyzo894yCYSwziZX/IDsP6mxkujmycLg5mZ6YWcjg9KeGRWtJPKG7HPdXp3e
	TdY70eVgglnnIuAYn1tYN7jS64ZUz9RYvzrQ71JoqIhefGCAX8ChD3qllMvvoeelR0D26TDQiHn
	PoFT89KV2kXQV2dDW9Sycrqv7vN5N2c2IJaTe57Y2aWxrDa/aRU6U=
X-Received: by 2002:a17:90b:4cc9:b0:35a:329:73c6 with SMTP id 98e67ed59e1d1-35bd2b97774mr3776534a91.3.1774052809268;
        Fri, 20 Mar 2026 17:26:49 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd358b299sm1463708a91.5.2026.03.20.17.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:26:48 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC PATCH] mm/damon/lru_sort: add synchronous validation for commit_inputs
Date: Sat, 21 Mar 2026 08:26:42 +0800
Message-ID: <20260321002642.22712-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

I would like to ask some question about the fourth task in discussion [1].

Please let me state first that the following changes will also apply to
the DAMON_RECLAIM module.

Problem
=======
Writing invalid parameters to sysfs followed by 'commit_inputs=Y' fails
silently (no error returned to shell), because the validation happens
aynchronously in the kdamond.

Solution
========
To fix this, I proposed adding synchronous validation in
damon_lru_sort_commit_inputs_store() before setting the 'commit_inputs'
flag. This allow users to receive immediate feedback (e.g., -EINVAL) if
the parameters are invalid.

Changes
=======
1. Added damon_lru_sort_commit_inputs_store() to handle parameter
   validation before setting 'commit_inputs'.
2. Added damon_valid_attrs() to centralize validation logic.
3. Extracted validation checks from damon_lru_sort_apply_parameters()
   (currently copied from core.c).

Questions
=========
- Design:
  Is this synchronous validation approach acceptable? Or do you prefer
  keeping it purely asynchronous?

- Code Structure:
  I noticed damon_valid_intervals_goal() and similar validation logic
  exist in core.c but are static. To avoid duplication, should I:
  a) Export a generic validation function in damon.h or internal.h?
  b) Keep the copy in lru_sort.c?

- Concurrency:
  Are there any race conditions I should be aware of when reading
  'damon_lru_sort_mon_attrs' in the store function? Should I use
  READ_ONCE() or add explicit locking?

Thanks for your time reviewing this! :>

Best regards,
Rui Yan

[1] https://lore.kernel.org/20260319151528.86490-1-sj@kernel.org

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/lru_sort.c | 64 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..0e5f9d29e294 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Desired active to [in]active memory ratio in bp (1/10,000).
@@ -361,6 +360,69 @@ static int damon_lru_sort_handle_commit_inputs(void)
 	return err;
 }
 
+/* Source: mm/damon/core.c */
+static bool damon_valid_intervals_goal(struct damon_attrs *attrs)
+{
+	struct damon_intervals_goal *goal = &attrs->intervals_goal;
+
+	/* tuning is disabled */
+	if (!goal->aggrs)
+		return true;
+	if (goal->min_sample_us > goal->max_sample_us)
+		return false;
+	if (attrs->sample_interval < goal->min_sample_us ||
+			goal->max_sample_us < attrs->sample_interval)
+		return false;
+	return true;
+}
+
+static int damon_valid_attrs(struct damon_attrs *attrs)
+{
+	if (!damon_valid_intervals_goal(attrs))
+		return -EINVAL;
+	if (attrs->min_nr_regions < 3)
+		return -EINVAL;
+	if (attrs->min_nr_regions > attrs->max_nr_regions)
+		return -EINVAL;
+	if (attrs->sample_interval > attrs->aggr_interval)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int damon_lru_sort_commit_inputs_store(const char *val,
+		const struct kernel_param *kp)
+{
+	struct damon_attrs attrs;
+	bool yes;
+	int err;
+
+	err = kstrtobool(val, &yes);
+	if (err)
+		return err;
+
+	if (commit_inputs == yes)
+		return 0;
+
+	if (!yes)
+		return 0;
+
+	attrs = damon_lru_sort_mon_attrs;
+	err = damon_valid_attrs(&attrs);
+	if (err)
+		return err;
+
+	commit_inputs = yes;
+	return err;
+}
+
+static const struct kernel_param_ops commit_inputs_param_ops = {
+	.set = damon_lru_sort_commit_inputs_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
+
 static int damon_lru_sort_damon_call_fn(void *arg)
 {
 	struct damon_ctx *c = arg;
-- 
2.53.0

