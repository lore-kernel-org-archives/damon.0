Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8D45FFA7;
	Mon, 14 Sep 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395820; cv=none; b=owkV8x8/ji5htJWofFuT/cL27NoG4EFr+eBvRN890cg1C67AjNsqiVhezwYVa1T7mrKVN8/q7Yls3LFZ/BO3TnmtqBIeETwK+lwg70HUvmxApHdjXGKStG77ikGjX93uRyFHyFY7y3+2Tond9OTaER8lm95dI32yqSGWriG+iiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395820; c=relaxed/simple;
	bh=QHhLfzJDfeGQuRfqlQawxwg6MFyoxHgPA/T9dhACMIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlXfjNtoxbG984hA4pWbCx10u7zjlLtqAy5HWeTuFs2TfAWsTcwzF3pz7aEuQjDGtDcApaoCHGXSJqJpJM1BPMwNz6/Y297vwNGzAU8yxDwQ98/z4BKOvlMRVboYFKhH5QIVwf4I5dMxRl4wHgUGAKBZsQFh+2As0sKhJ6ktLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYWk1xvQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYWk1xvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1491F0089B;
	Mon, 14 Sep 2026 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395816;
	bh=tOENOCXANQ196Y7IaHjgPhFv7InBS8bgPr0HQuFZGX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HYWk1xvQvcnIFbcqa1C2fX/oWjgZSWbJNNKHPp9pfOqUYW9Tg03tBeuu9CB0MbJN/
	 NVu5hrHYgov25H63p6g/kJgZlwWsOW7gs0xSUoR3Yg6rtcc0cEPnMtSEu82t6gC0KI
	 e8zJwDwcokla7atG2zK26UOFknEar+FtGCd9VVAZU+5P6cOzvIbPJ9+zYgk4DO9hgP
	 4DD+nrmHxsQ4jZszS6nqIRvKpxbtKvsXnMd2hr/ntC7GhQlhjSwTmCrf99DeDgTBuo
	 YDyq02dxv1QeTr6e9hhLiyxeL8H+y08wGFyCW13RBN+PD652Or5eaUbI5s9QvQPD9I
	 8AgCTjfVLzUkQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/8] mm/damon/core: disallow max < min damos filter range arguments commit
Date: Mon, 14 Sep 2026 07:23:21 -0700
Message-ID: <20260914142327.92510-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914142327.92510-1-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_filter_arg() receives range arguments for a few types of
DAMOS filters.  It allows any range including max < min range.  It is
fine for the logic, but makes no sense to support it.  Actually DAMON
sysfs interface is doing the validation on its own.  To avoid duplicated
validations in multiple DAMON API callers, it would be better to do the
validation in the core layer.  Add a validation of the given range.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 94ea63084a24d..e0414d2adcb41 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1325,15 +1325,21 @@ static int damos_commit_filter_arg(
 		dst->memcg_id = src->memcg_id;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
+		if (src->addr_range.end < src->addr_range.start)
+			return -EINVAL;
 		dst->addr_range = src->addr_range;
 		break;
 	case DAMOS_FILTER_TYPE_TARGET:
 		dst->target_idx = src->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
+		if (src->sz_range.max < src->sz_range.min)
+			return -EINVAL;
 		dst->sz_range = src->sz_range;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		if (src->range_max < src->range_min)
+			return -EINVAL;
 		dst->range_min = src->range_min;
 		dst->range_max = src->range_max;
 		break;
-- 
2.47.3
