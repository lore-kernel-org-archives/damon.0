Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6D377ED9;
	Thu, 17 Sep 2026 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617948; cv=none; b=GXYWR05Hd8rCmiDfnznA4sSvSmPkFDQlwbqyRT5nB1bKPxVHr4SQA3XlS/T0y5btubtYQuhrwxo823/C+DYk/VeYOAmUVPHA+VxyvqhVilVYjC8+kSj8kGp78WseQ5VkigM31laOpi5vQACLAbouDFFCChH2UnqbPpqhN+JMr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617948; c=relaxed/simple;
	bh=IEt5isfidqyU0pz+Ed5oabTsHpojfScQRA9L+2gb7C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1nUDX5dpXdXWRQE8Rt5BrzXhh6WM1vr8GDxlDjRrnBpMqe4Jr38iT6BjCnjPhPKdJR0aEeWXg9CKaZC44whncOOstgqLwpnuJo+ROJKYuUO96RBYPF0cBsNr1wwgVuWh24FL0l2TBwGpIn605biTI6Mc84jYt/ZW2zfw34ofCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNZUqJgP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNZUqJgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3831F0089B;
	Thu, 17 Sep 2026 04:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617946;
	bh=xuBve8B9TeEtlHU83DYclAih0SjxWd5x7DEHnP/pWkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iNZUqJgPOYgDNx/fChezmCGs2a+uNvx1Ni6wOwUmuP5HWXUOzOo3pFR/zhl3me4A2
	 w8ifdGvr9eE7gjyPh9Hl3tCJ03IUQ8YG72a9xSDvcfYUzbdq2Nxe3/Ekn9JjWrPii7
	 HHC3XJXFzy+EZ30TA5EyQx31wPManYFvk8t/O0sjhVamfESL+/VOAAs+yeuFur5ROe
	 4G7M5v1Qq07QAUJXBnH1BlR054B1AqPC0xf6Jy6i7hlvH7zPE8LRcBIBjGWr/IG/aC
	 MenqKNxe7TuRrfJnln6h0Jx3u05NIZsfnnnLQ1/f4C9V8FNCwNLhqMdo5Xje6kEq1x
	 d7TzwqrwDsueQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 04/10] mm/damon/core: set damon_ctx->walk_control_obsolete in damon_new_ctx()
Date: Wed, 16 Sep 2026 21:05:30 -0700
Message-ID: <20260917040537.107341-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_walk() should be called for a damon_ctx context that has
successfully started at least once.  That's because
damon_ctx->walk_control_obsolete is initialized when kdamond starts.  If
the rule is violated, an indefinite wait can happen.  There is no
existing violation of the rule.

damon_call() had a similar rule, and it turned out keeping the rule is
not easy for damon_call()'s case.  Hence, commit 8023b5f47e09
("mm/damon/core: set ctx->call_controls_obsolete in damon_new_ctx()")
added the initialization in damon_new_ctx() and removed the rule.

Keeping the rule for damos_walk() is relatively easier.  But having
slightly different rules for similar functions could be confusing.
Sashiko, for example, repeatedly asked questions about this.  Do the
initialization of walk_control_obsolete in damon_new_ctx() for
consistency.

[1] https://lore.kernel.org/20260915011614.102342-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7bbbd44379301..9120a1b707b24 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -939,6 +939,7 @@ struct damon_ctx *damon_new_ctx(void)
 	INIT_LIST_HEAD(&ctx->schemes);
 
 	ctx->call_controls_obsolete = true;
+	ctx->walk_control_obsolete = true;
 	prandom_seed_state(&ctx->rnd_state, get_random_u64());
 
 	return ctx;
@@ -2308,10 +2309,6 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
  * passed at least one &damos->apply_interval_us, kdamond marks the request as
  * completed so that damos_walk() can wakeup and return.
  *
- * Note that this function should be called only after damon_start() with the
- * @ctx has succeeded.  Otherwise, this function could fall into an indefinite
- * wait.
- *
  * Return: 0 on success, negative error code otherwise.
  */
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
-- 
2.47.3
