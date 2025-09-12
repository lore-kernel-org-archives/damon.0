Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A41F8724;
	Fri, 12 Sep 2025 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644792; cv=none; b=uYit3cpVCGpEqRWaMa6V9nQhoFL0GlqxxT1mXWItwyApjHIM5hWTjkk9A3QJAatJLX0wE6rF4guAKMxXHQjJMQuHrsZ0GRBLrahNrZN2zkcdS2jzMOntEzLSud7J3erjlBS1iv3+VeZdJJ5pst2gMr3njMY3xtKEoADiQdockyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644792; c=relaxed/simple;
	bh=X2mkDImsPjBINJD3elmssAm/a5Bzpioz6UMPDraKGoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yj9bFYAxDJCjIHi6CZn85iEZ4Gc1T2kv86VmmqAvARNhVbA9stv3h+YqMW/Q4iVNl4Z8t8g2bWJ1/i+3Cwv0e1dDyBBXEP6sb8VqlpyMCygcEfA9YQFyjFX6FLsSIOByGJ6ZoukOGLNUsxThfByGekRZNkB/2FrOfulEpX5MnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSFaup3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSFaup3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA746C4CEF0;
	Fri, 12 Sep 2025 02:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644791;
	bh=X2mkDImsPjBINJD3elmssAm/a5Bzpioz6UMPDraKGoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSFaup3yhbErLVVcQ3JyDhD3QgThJ2y/eTwsFKLs0Ew79FKwirbcC9NP6wWR0A1hv
	 td6a3pMnN00+mIowonlZID9hCkErNLHCUObHEwyl0AEtufejVPAUFsjpmhXYackAQh
	 Ets31DFr9uiO+/XuTvwzVLG+oceoOfgjEF8UDdsnVHaZOVA0rt3bD2UtW4zLmS3EZU
	 IxB1XsFYXHOFTaXEVwyH09yiN2Hp0Czb2WJpSSqYgQH8Du99cSTlkr91uN8nrAwsSz
	 IaPUyA3pamU3Z11yLLN1B9XLq4fGHxuJLCEyEWc+usaiPyNERwenytHnXtZ+Ay5Lv5
	 lUneBtoIis7Jg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/7] mm/damon/core: implement damon_initialized() function
Date: Thu, 11 Sep 2025 19:39:40 -0700
Message-Id: <20250912023946.62337-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912023946.62337-1-sj@kernel.org>
References: <20250912023946.62337-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If DAMON is tried to be used when it is not yet successfully
initialized, the caller could be crashed.  DAMON core layer is not
providing a reliable way to see if it is successfully initialized and
therefore ready to be used, though.  As a result, DAMON API callers are
implementing their own hacks to see it.  The hacks simply assume DAMON
should be ready on module init time.  It is not reliable as DAMON
initialization can indeed fail if KMEM_CACHE() fails, and difficult to
maintain as those are duplicates.  Implement a core layer API function
for better reliability and maintainability to replace the hacks with
followup commits.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 484b0558f426..0f012b1e39fa 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -941,6 +941,7 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 }
 
 
+bool damon_initialized(void);
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 bool damon_is_running(struct damon_ctx *ctx);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f32034973cc1..38ff417f4eb9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2880,6 +2880,16 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		r->nr_accesses++;
 }
 
+/**
+ * damon_initialized() - Return if DAMON is ready to be used.
+ *
+ * Return: true if DAMON is ready to be used, false otherwise.
+ */
+bool damon_initialized(void)
+{
+	return damon_region_cache != NULL;
+}
+
 static int __init damon_init(void)
 {
 	damon_region_cache = KMEM_CACHE(damon_region, 0);
-- 
2.39.5
