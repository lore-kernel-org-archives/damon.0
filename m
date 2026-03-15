Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD137CD24;
	Sun, 15 Mar 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608425; cv=none; b=m6DzMw/ALodoSf46W6au3jGOfdZB8rizVtQPc/GATJtesXrAhnZ4JeosaCQhNWQ0ZfKs85WPaTjpe3mAkieYj9zS4CCwQTftm908k8e1Eizk9/8wDyyjH3zup0RJWiSsBSbQ3Du8GdaEhB2uPcHfYiLb2iljxLPqHDWCdJ0icwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608425; c=relaxed/simple;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2+allYcw+mR8NsdeNSSZqlBEqihjQw0zWdGIcl9jKt43khU5hCAxz7iOyOSjUE42ciGi73Ek9Hays+6lnQu5GjDFHXjQPDrsMt+ZXXQlx5rLbX9ICwHds6yeWHYiQQi2cRIj0KD86rccGZH3UpqwZaMOLB8bdd4qxklqmMeKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUlz3+NL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUlz3+NL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257DFC2BCB1;
	Sun, 15 Mar 2026 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773608425;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUlz3+NLoFBBpOsHIh6MDDQy19Hxiwz8wOt7dLdhWqaQCiikMxlD9OhxHjxS+Gs1w
	 PEOa+P7iPWs0SpcbyiqYnyHGrLBvQwZXo4bOo93kb4KyVHLu6icQKdw1d5ewR1qj+o
	 MQLdHjCw0+g1R+dvoARJ6mAdJ6oxuRiFf1a08wcrZnLU/yb62DRWBkyjyYSb4fYOiq
	 1o+kItvFI8bZfB8jryOYEgHkzJ1pdrPSqO65Vm+ogCIIT+Jggke9YAiTFFLrOgUU+6
	 IRhkYDneji1tfa/bWsZ2p2J/CAmbw5s+50+t3zZkg8SVMCfRs0Lx4A1l22Gu0iCBy/
	 IEDcsYgcTa9Yg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/10] selftests/damon/drgn_dump_damon_status: dump pause
Date: Sun, 15 Mar 2026 14:00:07 -0700
Message-ID: <20260315210012.94846-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-1-sj@kernel.org>
References: <20260315210012.94846-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status is not dumping the damon_ctx->pause parameter
value, so it cannot be tested.  Dump it for future tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index af99b07a4f565..5b90eb8e7ef88 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -200,6 +200,7 @@ def damon_ctx_to_dict(ctx):
         ['attrs', attrs_to_dict],
         ['adaptive_targets', targets_to_list],
         ['schemes', schemes_to_list],
+        ['pause', bool],
         ])
 
 def main():
-- 
2.47.3
