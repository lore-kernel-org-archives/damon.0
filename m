Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0A31B101;
	Mon,  8 Dec 2025 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175404; cv=none; b=XpuX5nsnsUXZ45dNO8V1KsRkLbZtxmrg8ncDnsJX/O7p4LMfRtdZbAVcMnbjXY1gzBvLS0VQofbr+DG/8InGnR98Ohl2Uo/RNbwA+u2AyoBghUqnqojp3dNxFEkyNo7gGGtsfXxSlvuaV//ovLtTB3Or0Zbh2+sifW3kvVujT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175404; c=relaxed/simple;
	bh=HqSr2dVJCwPH4hyJgJqnf3m06RGc89x094A8SJ4rv+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqMMoJEFuJfAE5HXKLN3KpqmgCRyNykIJJZiIPVhktjWr4CgQnJThEWBLH+et5jjWxIGBwVLr+BZ3/AFUbAMqfHW3aQQasvXY3lxzWd/ip8RuQerS0H7TZ9r7l5Zqb48pk5GwEiJ9KChdIpybnQZsM8vCZ1mc/o9P9UkbC5fPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIXLTVp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIXLTVp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F03BC113D0;
	Mon,  8 Dec 2025 06:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175403;
	bh=HqSr2dVJCwPH4hyJgJqnf3m06RGc89x094A8SJ4rv+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIXLTVp7/6bmfAS4G3mn84o+NgRZe3aM4W/0ATsBaPJzAgWfWNp65xQP4uEu1kdg0
	 eUpGG6eFBBMNmeW6wAd++++tZOEbSTTNVxLqwrcCzUz2kidF6/9WUWaaielwjVdNp+
	 Gro5lJ8x5IxhUltkdEspo/9xmJMmARN5eKNuJg5S7gzqrXqqyRgfyPrWQOcmDn3z9S
	 EO5af6uaHfyA2E1iz6nDyGmklI35B/a+ZnsuEFhxUgcb2IJHmEEz7O/YtuNKHy75fI
	 3lCfVjr1NBlLNIXLR6AgKS+mlyr8jVC77Z96iJCPNPTSRALlrP2uIiv4ITYocQ5lVF
	 p/+ec5asC+fsA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 10/37] mm/damon/sysfs: connect primitives directory with core
Date: Sun,  7 Dec 2025 22:29:14 -0800
Message-ID: <20251208062943.68824-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The monitoring_attrs/sample/primitives/ directory is not connected with
the core layer.  Make the connection.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 14478fd79953..16d58cde03e8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1640,6 +1640,17 @@ static inline bool damon_sysfs_kdamond_running(
 		damon_is_running(kdamond->damon_ctx);
 }
 
+static int damon_sysfs_set_sample_control(
+		struct damon_sample_control *control,
+		struct damon_sysfs_sample *sysfs_sample)
+{
+	control->primitives_enabled.page_table =
+		sysfs_sample->primitives->page_table;
+	control->primitives_enabled.page_fault =
+		sysfs_sample->primitives->page_fault;
+	return 0;
+}
+
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		struct damon_sysfs_context *sys_ctx)
 {
@@ -1654,6 +1665,10 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		ctx->min_sz_region = max(
 				DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
+	if (err)
+		return err;
+	err = damon_sysfs_set_sample_control(&ctx->sample_control,
+			sys_ctx->attrs->sample);
 	if (err)
 		return err;
 	err = damon_sysfs_add_targets(ctx, sys_ctx->targets);
-- 
2.47.3
