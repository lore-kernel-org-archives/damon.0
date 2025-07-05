Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5141FAC59;
	Sat,  5 Jul 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751736008; cv=none; b=CXRMiYTuogJ5CEuAA5N8eQ90zECfUBeaUm9zCKGDhBIWt0jE1eaFpyiUsUAoioneevitWbKjaZrJBPqFZc5tJZYkqBoDrhC6sjvXOXtOtCwmqUdieQZjJr5TD8YLuC9PeKWuu5PJ9Khr9kwllgBNmWcfcc7xPXQ68DCjlJc7Q0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751736008; c=relaxed/simple;
	bh=vdzeXdPJva9xf8AUf7nVZK6UQucmjlC1P0NOeZ0k3kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uaxcedd3pBpQUoIV4JpUFpoJmW2OI2dDVCZkCk/q452+RE6KwdIsAYnyF8G6hGe2j5rQGfNyUPPpv2Vd46X1zUtt/IonoEjyEFStxkz1l1MhIiofB8/de38fZBMX8+eVJelDw0bLHbYKpMKlTe5ExKgchl0RHZI3/sb4Vz588is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxK0nDp1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxK0nDp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24701C4CEE7;
	Sat,  5 Jul 2025 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751736006;
	bh=vdzeXdPJva9xf8AUf7nVZK6UQucmjlC1P0NOeZ0k3kE=;
	h=From:To:Cc:Subject:Date:From;
	b=jxK0nDp1PdIuXdV0I7hH1MZZYEjLkc3DCK+I5lS1jXZs1fmGNb1v3T6BV5sx+AsOj
	 X9sQcE2yYmLLSmtb0rcgd/MDJnCNj4NoKzv3FxvvHnzGSeNkiiSDYOhy8uQJggk3go
	 Q+1naayupOUZKcC2KbtCcWzkQ8l5NjUiR7NadOHUINV49qzXNl4aC7ZGgryV0R6v8H
	 d0mwCXN7m5iCbn4VWNVko+DOpJTPsX3sWOO7KzgQHVbVdDNpOVPTFJIk54zopMNP7m
	 WoBDyUnXrSwq/us0JQCVvVa9QOeU6Q5vGyMcwM72Ggo0+9f66qMSRluPf8lWuJhR2W
	 uvmnkg4DjtjHQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mm-new] mm/damon/core: initialize sidx in damos_trace_esz()
Date: Sat,  5 Jul 2025 10:20:03 -0700
Message-Id: <20250705172003.52324-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ae4dc5a31d0f ("mm/damon: add trace event for effective size
quota") introduced damos_trac_esz(), which uses sidx variable without
initialization.  Initialize before using it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507051517.bs3jd8RW-lkp@intel.com/
Fixes: ae4dc5a31d0f ("mm/damon: add trace event for effective size quota") # mm-new
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6019b8ec4bba..dc0ee2dd55d3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2014,7 +2014,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
 		struct damos_quota *quota)
 {
-	unsigned int cidx = 0, sidx;
+	unsigned int cidx = 0, sidx = 0;
 	struct damos *siter;
 
 	damon_for_each_scheme(siter, c) {

base-commit: e8ad191fca305538cdebb3dac3f9be19cd610d38
-- 
2.39.5
