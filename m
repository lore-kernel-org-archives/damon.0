Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC11352C2B;
	Wed, 13 May 2026 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778645490; cv=none; b=ksjbRuCv7s45rLawjtohAx0M4uxuHC5WlTCDMze3iC91N3M6vC33oIt45SdgGpPXe+Hs5DaAiUhe+8YlhEU1p+iCKPLd+h3XQoi6iB0JLGaONh2dobRcC0U6Jhy660mOfsOM91qw65UG8Dx22l84pdHD1QWZo63ZsZgECBj8LPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778645490; c=relaxed/simple;
	bh=+ef/xQz4oQpOJ/gilL+mVumdWc08CVw8swzietXAplQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKXf/VMl1EdCA/QRP+VeMmJdkcuhhDgO617WvkLMpQhlYcO5Pz4JTGnZo3KG3zHgi66TC7aUzCYlUFsGQLGwiMJ0j9Hb/r276+xVVqpI9NAUYeIkK4CUFdaJqljDgcLTsVFfL6iY3GY4TsTFpIpyNd956cdrRvI3n4fPa0WDAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS5Dvf1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS5Dvf1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5FAC2BCC7;
	Wed, 13 May 2026 04:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778645490;
	bh=+ef/xQz4oQpOJ/gilL+mVumdWc08CVw8swzietXAplQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uS5Dvf1mECprZ25sSI5k/TyxdZb/oaFhtCYopFvf13kV3dTgQHFZya6KdF4Eyk7dP
	 uKb/CvbxtTpH4Y2nyEyVQF9RXGn1mRNuwq2sFlbHgGqjqaUIFHLhlPyOvPrbkSCp2f
	 b4RvIWvFuqg3egjIa2O0kTQoWNgQaeHrcEDJP5ePPjRSBa5UMHjluXsaGfFWXwpYCH
	 lEmRwufWyH0wDXUJVbbNnL0WZR1xWyMwXtWU9JYlDYFcJo6ieuAkbDDDMa48RJeiCQ
	 Kod0EjlOEDs61dPdS/xBrxdaJ6GL2ajTNJ2l3l+gYjlsbWVLaSfzne77wRJPmw+oda
	 peCfLKpPN951Q==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y 1/2] mm/damon/core: implement damon_kdamond_pid()
Date: Tue, 12 May 2026 21:11:13 -0700
Message-ID: <20260513041117.154407-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026051242-gusto-earful-5086@gregkh>
References: <2026051242-gusto-earful-5086@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch series "mm/damon: hide kdamond and kdamond_lock from API callers".

'kdamond' and 'kdamond_lock' fields initially exposed to DAMON API callers
for flexible synchronization and use cases.  As DAMON API became somewhat
complicated compared to the early days, Keeping those exposed could only
encourage the API callers to invent more creative but complicated and
difficult-to-debug use cases.

Fortunately DAMON API callers didn't invent that many creative use cases.
There exist only two use cases of 'kdamond' and 'kdamond_lock'.  Finding
whether the kdamond is actively running, and getting the pid of the
kdamond.  For the first use case, a dedicated API function, namely
'damon_is_running()' is provided, and all DAMON API callers are using the
function for the use case.  Hence only the second use case is where the
fields are directly being used by DAMON API callers.

To prevent future invention of complicated and erroneous use cases of the
fields, hide the fields from the API callers.  For that, provide new
dedicated DAMON API functions for the remaining use case, namely
damon_kdamond_pid(), migrate DAMON API callers to use the new function,
and mark the fields as private fields.

This patch (of 5):

'kdamond' and 'kdamond_lock' are directly being used by DAMON API callers
for getting the pid of the corresponding kdamond.  To discourage invention
of creative but complicated and erroneous new usages of the fields that
require careful synchronization, implement a new API function that can
simply be used without the manual synchronizations.

Link: https://lkml.kernel.org/r/20260115152047.68415-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20260115152047.68415-2-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 4262c53236977de3ceaa3bf2aefdf772c9b874dd)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
The second patch depends on this commit, so porting this together.

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 343132a146cf0..4b787a0f21b40 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -677,6 +677,7 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+int damon_kdamond_pid(struct damon_ctx *ctx);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 48747236c21ca..488f66a0d309c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -762,6 +762,23 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	return err;
 }
 
+/**
+ * damon_kdamond_pid() - Return pid of a given DAMON context's worker thread.
+ * @ctx:	The DAMON context of the question.
+ *
+ * Return: pid if @ctx is running, negative error code otherwise.
+ */
+int damon_kdamond_pid(struct damon_ctx *ctx)
+{
+	int pid = -EINVAL;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond)
+		pid = ctx->kdamond->pid;
+	mutex_unlock(&ctx->kdamond_lock);
+	return pid;
+}
+
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
-- 
2.47.3

