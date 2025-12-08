Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469531A7FE;
	Mon,  8 Dec 2025 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175393; cv=none; b=t8NrTsxp3ir3TRRjH2rNii0CgsGWqAIIsTLonqZjThsbx7i2gzP6xCS+wYrmP4Cc5XZALHb3MUzGKtZTZ2XlMRTgZ2Hxx9bY/jhdI86qKP3xrQyH/v7naZ5vfLjJz0/lB+tsqxp3shhU29igjqsTz0hckA0jIL4TD5QEUfwzae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175393; c=relaxed/simple;
	bh=j4VCJvAbCWiJF3GzXaegxyBFq9+F4EGOLszAHpMh12M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6lJpwAwutXkN+jVECpfO0asb5bRicmNltJj7bhFsJtkPpA9pw/qE9h2mfD07r+d3YaKVDbxPrOn6Y/nMvzm4Uc9i0USAeV8wga0hPSXueDcoDjZGdOtIdFh9+o+dYlxlHLxBJmYVnR2AbKQqnJA0xBCvTgZb03aNcoFgDGPl38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm/vBl8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm/vBl8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F2AC113D0;
	Mon,  8 Dec 2025 06:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175393;
	bh=j4VCJvAbCWiJF3GzXaegxyBFq9+F4EGOLszAHpMh12M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gm/vBl8ryD/sYQZKtcgb4nfb04AD2Tc1c7lyP0l4Nu/jnTmgwOeYH2cYgRSGJSjib
	 M9h6V9GsqI1I/5HLfrYo7B5zjiZF4Xq9PQwwwbcYSChC3J1YdJLhPM3U8di0CQKlxR
	 T0MJ7ooHrdBDEpMRDrL9Apg4NQq8hHiGXkdCoFXb8XYb+wCQKipI5TWxFys7CU4FG/
	 3Hf6pJAzXORV9w84y3Gew1Tmsggpxce/DuHwn7iLtacKNq3ubWy2Kg8o8jMqsd5VlG
	 PH88VLVnB304si86+tDirjCVtIvi8KEZ76LRsQi7gH466ZQcDTGxzRxBlHO0vwlv3V
	 bCNZxUC5gKuvw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 03/37] mm/damon/core: commit damon_sample_control
Date: Sun,  7 Dec 2025 22:29:07 -0800
Message-ID: <20251208062943.68824-4-sj@kernel.org>
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

The parameters for sampling primitives usage control is not committed
with damon_commit_ctx().  Hence it doesn't work with online parameters
update.  Implement the functionality.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7abd8c550c60..89305d42e116 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -559,6 +559,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
+	ctx->sample_control.primitives_enabled.page_table = true;
+
 	ctx->addr_unit = 1;
 	ctx->min_sz_region = DAMON_MIN_REGION;
 
@@ -1242,6 +1244,23 @@ static int damon_commit_targets(
 	return 0;
 }
 
+static bool damon_primitives_enabled_invalid(
+		struct damon_primitives_enabled *config)
+{
+	return config->page_table == config->page_fault;
+}
+
+static int damon_commit_sample_control(
+		struct damon_sample_control *dst,
+		struct damon_sample_control *src)
+{
+	if (damon_primitives_enabled_invalid(&src->primitives_enabled))
+		return -EINVAL;
+
+	dst->primitives_enabled = src->primitives_enabled;
+	return 0;
+}
+
 /**
  * damon_commit_ctx() - Commit parameters of a DAMON context to another.
  * @dst:	The commit destination DAMON context.
@@ -1278,6 +1297,8 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 			return err;
 	}
 	dst->ops = src->ops;
+	err = damon_commit_sample_control(&dst->sample_control,
+			&src->sample_control);
 	if (err)
 		return err;
 	dst->addr_unit = src->addr_unit;
-- 
2.47.3
