Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A54215798;
	Sat,  5 Jul 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751737805; cv=none; b=FFfcT5a1HouYSkdCRY7biiiEpyydIzYsgJb6r1R6ehnPaP2KXT15LFp93hmr+T90hdo868n5KFLx8r5eiPL6iRKeIt3T7dVOzz7VVNdQWq2xVkX04hC6jT4KeX5mN9yo9FCFtwNfd8KjRExXxVw46YuS4SY55asZLrdTjKEVRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751737805; c=relaxed/simple;
	bh=x1UOtr++wfnnN2w2/rHB31NtHodnV1W7q4cMr5UyQ+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lw5vNccLlOciUaDEHwBlSjK+LG4GtWJFls2hdYS/8kSw+nIGZsSgcgCl0tc8GdZMwH09tRhlBqNR4m2+jqS0lxs3ahtwclofENm9NOesSkEcbvjH/x8OV+QaipDK9LURNkLz5BRpjNX41gI2XEJR/lN1l5QA9UHvTg2bZ/R0sjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaJpRuFQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaJpRuFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C59C4CEF0;
	Sat,  5 Jul 2025 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751737805;
	bh=x1UOtr++wfnnN2w2/rHB31NtHodnV1W7q4cMr5UyQ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaJpRuFQgiIS/Wy3YSZ6W52FL3zmNA7C8hvfCVKmE+Mof46roplzZl0hmHUTdIPDh
	 fPdnDsS0mcg29H06Nk8drmmD3/d51Dn8JqpM08nxkrDn0af/7+vLtjpLzliQhI1E1S
	 +0esrwdNSIB37HKMiQNPsk2t6ClgjO3JH7ROK7PKiHIwb07GMA/JSX9AP423Ws1ywd
	 4w2/Y3LmTIsRsUAAaXxlpyGAkRbUmfoOSgZGhaBJ+1Z9TcytzJenKeQjQzRGywLi3F
	 6aCSgYcdM0Z6XUg358gDvBlQlbt+zkI3MzwGJcg9ixuFz3bwYzo5tDjpeqKJNthvcx
	 c4d+sKEi9oOXA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] samples/damon/prcl: rename to have damon_sample_ prefix
Date: Sat,  5 Jul 2025 10:49:56 -0700
Message-Id: <20250705175000.56259-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250705175000.56259-1-sj@kernel.org>
References: <20250705175000.56259-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sample module, prcl has its name 'prcl'.  It could conflict with
future modules, and not very easy to identify it by name.  Use a prefix,
"damon_sample_" for the name.

Note that this could break users if they depend on the old name.  But it
is just a sample, so no such usage is expected, or known.  Even if such
usage exists, updating it for the new name should be straightforward.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 5597e6a08ab2..447ccba09e8a 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -11,6 +11,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "damon_sample_prcl."
+
 static int target_pid __read_mostly;
 module_param(target_pid, int, 0600);
 
-- 
2.39.5
