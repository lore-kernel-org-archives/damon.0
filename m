Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584B269AE6;
	Wed, 26 Feb 2025 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551817; cv=none; b=eNX04hJlQF+Ak1WaxevHLAwSYnnRA9kagrGSme/qXDFTZSyjiSLoovlQv+7/HSVmAY8Z8o2m9m47o/vHi09w+S/sehasYgDqeFo6BJxdDsgWzQnQRmGc7A3ltyia/RNHej+w10p9MC8Nmi0CE1Qn96phQ1ZRBl2tXd/s8C+fV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551817; c=relaxed/simple;
	bh=9LkGnu4V55DcG0gnLZ1nxdIsaaPuWfP3P63Al4SXqQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cr4StymugGlyPWPdCrR7HrESQgXyQ0xe7amRt2anur/U2/ykdEWoMx9Y0Dpfh37BvJT//gYM4Y1LgGo+55Fnf647DgY+NHFsHZ8/h/9e0QoXZV0baF+CcSWhgQ4xl5byeglZIJCJcQgJhJls7l875GnPhT5LT6k6+iVBCTByzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEaBgAC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEaBgAC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167AAC4CEEF;
	Wed, 26 Feb 2025 06:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551817;
	bh=9LkGnu4V55DcG0gnLZ1nxdIsaaPuWfP3P63Al4SXqQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEaBgAC47cbxN/RRjljj/8roAg+KCPL71T4UAk25EG2gYQZU01C8ZZm/pZhxdCMTr
	 dnWU8VqhwLdVhdEQEP3yxWTYhNkXhzjyJrljzSasWAWf6ljh/fl564jMepEjub7hpL
	 9dYuHOFrQOSMxGUm+FtWJy3FnzLHIwNMdfxmGgOEK/XsK/+SK7KRL/17jiWAhJBafP
	 iiGwutL6uv8Vd8FM+8kaYmFpuDyGAtDtHm3UOwJe98w6gR71px8mwiTAJmsbDEOsgl
	 ntMIFzIJsMEROJQvm0jvpJ0s8G/jqL4Tesq5PXZL6jGcgAvAzr0YpCry7BWySPVx9P
	 bNZaVK+RBMpCw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/13] mm/damon/core: invoke kdamond_call() after merging is done if possible
Date: Tue, 25 Feb 2025 22:36:40 -0800
Message-Id: <20250226063651.513178-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_call() callers may iterate the regions, so better to call it
when the number of regions is as small as possible.  It is when
kdamond_merge_regions() is finished.  Invoke it on the point.

This change is also for making future change for carrying online
parameters commit with damon_call() easier.  The commit work should be
able to make sequence between other aggregation interval based
operations including regioins merging and aggregation reset.  Placing
damon_call() invocation after the regions merging makes the sequence
handling simpler.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 310cdc87d5f4..0578e89dff13 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2412,7 +2412,6 @@ static int kdamond_fn(void *data)
 		if (ctx->callback.after_sampling &&
 				ctx->callback.after_sampling(ctx))
 			break;
-		kdamond_call(ctx, false);
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
@@ -2430,9 +2429,10 @@ static int kdamond_fn(void *data)
 		}
 
 		/*
-		 * do kdamond_apply_schemes() after kdamond_merge_regions() if
-		 * possible, to reduce overhead
+		 * do kdamond_call() and kdamond_apply_schemes() after
+		 * kdamond_merge_regions() if possible, to reduce overhead
 		 */
+		kdamond_call(ctx, false);
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
 		else
-- 
2.39.5
