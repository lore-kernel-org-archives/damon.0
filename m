Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E584B8DC3;
	Wed, 29 Jul 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333787; cv=none; b=OBx9LfI83eLRZEgZJBvV1on6/d8VgOO29Kd2g/PHAxEHTzn71R/hCKJqMbQZD7uPqKKe3b2AME+2iWfcIKo1nf36FIzKFuUEa9DH6ODi93yU6enl7zciWsHRskjO908DQxpKMqJSszQEzs5ZWY/T/vtIDKCVjVrFfN2DKxda9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333787; c=relaxed/simple;
	bh=PrDKIsNzBcOI2wImwGKxiCXSpt5whZrLxV5oplnveaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnEqZB8cm78GCvEAXXf3onS3e1eKjb6pR+19ExBJxfvxavU9FfV62Zw5FChD7jG7dpKy5xmQl7SaRa/CtGf8iS+5ClKVpk+X+RU85PuIfRJu3cb5WMaxwDm3GHQ9ZP5h1YtTHP3j+vtSLU/pjM5s1EM/Oq/j1vMuqI9LFH7DrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3SJ02dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3SJ02dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8214D1F00A3A;
	Wed, 29 Jul 2026 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333785;
	bh=SOFGYop7G5CT0IvbShe/iVSTs0keWEcjAd/ooP0VIE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3SJ02droipthfU1VEMG1xJ84auTvUbx2K3kVN1erJ3EjWV42hpmN6ojM0ZLjJ708
	 Y40xwMtAkHekYBB9J/MBmW8Jfw3nAuSmatvTs5eVTraWv5PkN/vaFyXu3+RhRanz81
	 Gmfv8gMIZbSSEA1AoLENDMJqj+Hf5fFxHn0AcDuHVjOw02QRXJ5UCT4dMnFI9cKSzr
	 vB9vVYMxfVTwi7K/rEyo2UuGwac4ps6SNXGsoZlvKEdEJC2Qyohapy1Ut6jfET+saN
	 untQQD9KtqlRZBw9Ah4bDmKhdNZ21LcM4ZiADWA4twN30jGzMkWvnpvLguQEJhKRRJ
	 XUZ9Ub1m9OdEg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 07/12] mm/damon/tests/core-kunit: test <=0 size damon_set_regions() inputs
Date: Wed, 29 Jul 2026 07:02:47 -0700
Message-ID: <20260729140253.87753-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729140253.87753-1-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1292c0ecb1ca ("mm/damon/core: validate ranges in
damon_set_regions()") disallowed passing zero or negative size input
ranges to damon_set_regions().  Add kunit test cases for those inputs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index befc1196d6d60..ac15393a7935b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -592,6 +592,20 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 25, .end = 40},
 			{.start = 44, .end = 50},
 			}, 3, 0);
+	/* Zero size regions should return -EINVAL. */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){}, 0,
+			(struct damon_addr_range[]){
+			{.start = 42, .end = 42},
+			}, 1, 1,
+			(struct damon_addr_range[]){}, 0, -EINVAL);
+	/* Negative size regions should return -EINVAL. */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){}, 0,
+			(struct damon_addr_range[]){
+			{.start = 42, .end = 21},
+			}, 1, 1,
+			(struct damon_addr_range[]){}, 0, -EINVAL);
 }
 
 static void damon_test_update_monitoring_result(struct kunit *test)
-- 
2.47.3
