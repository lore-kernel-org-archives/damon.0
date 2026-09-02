Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887738DC53;
	Wed,  2 Sep 2026 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328079; cv=none; b=NQqc9Qa2f9eC5Xf6Oy1AhOMyb0KBRsN3lI7XLDSSt7ouFlaYWRlFaNW5JsfUnHeTwD9Ebt7oByCldCQg5576WiSt9RhUEYJG5HdkyzVTt+n1uTmyy8fDd7suOstqZ3d0LF4I3NA1onFHvnqrznhxwc0f4e6Q+wG+ZlD9jBfF/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328079; c=relaxed/simple;
	bh=bhY4KhIyu4gwy+axujpyt57DuX8kkNxrt1KBoU8TmQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWkml9wue9SeCRLsC9EBq25q20t1+yS4YdNYJ5YaJ3h9EG4oUPw3y9IR5b/8IuVzysuurk1/fubC8hcRRleVMwY3sivk1JLeKYe9DhSVf9dt6WNmGSRfdObFPrI8CNPQOCasWQnNhIB3HzGGzcBpWc2s2Xncss34gcfYe7rYZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgyR80sS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgyR80sS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362531F000E9;
	Wed,  2 Sep 2026 05:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328077;
	bh=KnjoWKXYy9mV4JP4a4wfsis0KbFL9ZmPOgZcY5kWfCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgyR80sSVGZeqAZxZ92XTLPu7/ygW+YWlw9SJ+T3xdyG+MrPAYVWAuYYwIacpddeN
	 ICh6gf/gejLtS8LofSIiOs75v5RelfALnKuSTdO+mg6SJaV32cPRkcd13FUyqBAxf/
	 Pv+s+G0edkJ9J5bb/2vAGl7ahKfGV0EtXZJYfZ4G9Pi66X+L5ufr7fg9IH4bLJmeaC
	 sLkfJlOzM2CyPwilF+7Gzmp1lMdmfcu8sMtW3BX8gr/EQhZBx/8AZJ0Of6E2kq+Osq
	 1m/H436xwi8JcRP2gFLyszGHhqFdrIfWXlT/+J2DxX5dO9+dfm/MAlrQLDS1D3wMOo
	 kaIsW99KfflpQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/12] mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
Date: Tue,  1 Sep 2026 22:47:41 -0700
Message-ID: <20260902054747.99370-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 954157679ec3 ("mm/damon/core: disallow overlapping input ranges
for damon_set_regions()") disallowed passing overlapping input ranges to
damon_set_regions().  Add a kunit test case for the overlapping input.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 3cbbbcbfbef8f..a4164ac489a61 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -612,6 +612,17 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 42, .end = 21},
 			}, 1, 1,
 			(struct damon_addr_range[]){}, 0, -EINVAL);
+	/*
+	 * Regions resulting in same region after alignment should return
+	 * -EINVAL.
+	 */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){}, 0,
+			(struct damon_addr_range[]){
+			{.start = 10, .end = 20},
+			{.start = 20, .end = 30},
+			}, 2, 4096,
+			(struct damon_addr_range[]){}, 0, -EINVAL);
 }
 
 static void damon_test_update_monitoring_result(struct kunit *test)
-- 
2.47.3
