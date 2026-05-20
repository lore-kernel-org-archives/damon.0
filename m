Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D42DAFCB;
	Wed, 20 May 2026 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240084; cv=none; b=oTUmatwpqvSzSwSOHsET7KItijmn0VtpMbsEJE+KU47A32neb8yKn2znikaT6v7m+rXmW9iGYGNwRucQSRHY7HT7QukvcPJG7dkl3tPU7jALWf7HnFOu3H2rkN9sIMZ5xWD+D8xEuYHpeczuzoBvoDc4N+iVyN12w9tn+Ai+JmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240084; c=relaxed/simple;
	bh=VxKAY8G6HfryxouteZadvvsvvpIuMf8k09GQVvNdGjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSuTw+KbrADKXLuIdETzEGEtfDtZLlNmXo6y15TwP03E7KT3sv5Yyakpicp/2HZUlTbY/z1Z9xP3Kc/TqaPElDYnQ/MwM8X1X4kZ7bB3xIli4nC5qHpveP2QjZsrS69WYB06FlgfzkbV2+n9N+diK15uH8PFx1D2RWpRTucg2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvg0o9xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvg0o9xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D931F00899;
	Wed, 20 May 2026 01:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240083;
	bh=pgoNqW5Lq/igHId1rBXMsCtJD4xKs309svvL4MmZKcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qvg0o9xcRwy9rQSrFDKwUfsPvVEHvHTNAdTgw10Ga6b8J4VdNU54ucd2H7Ezszy8U
	 +iyIiWdJG158/ueAgWdt6NVUuAuy/4u7g9R8t3VDtUi70RSSSaFveS07Df1v1mINQL
	 BMXOiLzhSWb+tug/5COqbpWoi7n2EsdUo09hljbxV8FDo6tjGrDzVSLVX9x0fF9FiB
	 /Yv27l2dIHRK404dWFF18A2X8WYrmyesdMmcpZcUWc460Sk+Q7vbX9PcqjjUDCzDKC
	 reY9/X89D0IPSKwv5UEudrB7HARS/1K5CIGI4x9COqJSe73mh8ZEfowqIxm7dWMMdP
	 qMpzSfif+moyQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: niecheng <niecheng1@uniontech.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RESEND 1/3] mm/damon/core: clarify next_intervals_tune_sis update path
Date: Tue, 19 May 2026 18:20:59 -0700
Message-ID: <20260520012104.93602-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520012104.93602-1-sj@kernel.org>
References: <20260520012104.93602-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: niecheng <niecheng1@uniontech.com>

damon_set_attrs() updates next_aggregation_sis and
next_ops_update_sis for online attrs updates, but it does not update
next_intervals_tune_sis there.

This can look like a missing update when reading damon_set_attrs()
alone, while next_intervals_tune_sis is actually updated in
kdamond_fn().

Add a short comment to make this explicit.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: niecheng <niecheng1@uniontech.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/D3B0C1F5BB6ADCE4+20260514163751.3399513-1-niecheng1@uniontech.com
- Collect Reviewed-by: tag.
- Rebase to latest mm-new.
Changes from v1
- v1: https://lore.kernel.org/7946CE4E0773AEF7+20260514074846.3258908-1-niecheng1@uniontech.com
- Keep the behavior and clarify it instead.

 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4e223857a0f99..68b3b4bbc8fc9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -909,6 +909,9 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 		attrs->aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
 		attrs->ops_update_interval / sample_interval;
+	/*
+	 * next_intervals_tune_sis will be updated inside kdamond_fn().
+	 */
 
 	damon_update_monitoring_results(ctx, attrs, aggregating);
 	ctx->attrs = *attrs;
-- 
2.47.3
