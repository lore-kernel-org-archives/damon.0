Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037D38229A;
	Wed, 29 Jul 2026 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296283; cv=none; b=G0ZNUjxesNILpV8jR0kY02rHLJAJ3bUJSeg2Y43g8KCC5WAJslxGYuvKk5jLHBMA4AyIOa01MM/IaoL9YCp4wQUEvtTtlZNAWVgm6BDgakOnwG/r5fCMsPIMxixRYhS/2QiSCOnxwN+PKlARBA3MBlLwbu2eQrTgKAGYDsjawAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296283; c=relaxed/simple;
	bh=PrDKIsNzBcOI2wImwGKxiCXSpt5whZrLxV5oplnveaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRy6+/+/ZVN50MlcfQZN/ZQA/hPGbS2ldjgoMUWqCByebQG5jYcoZGvL0uvBzkNwltxa0D6UGhW1Bdj4cpkd0g9PjM2BK7I3Kgql6UK2cNPGt1DEIvnqaqT7d9Z+PacWggiewQgzShEemHq7GwghmQRUAtXnRajUlMEJA0CPFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5pDGgIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5pDGgIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B530E1F000E9;
	Wed, 29 Jul 2026 03:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296282;
	bh=SOFGYop7G5CT0IvbShe/iVSTs0keWEcjAd/ooP0VIE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C5pDGgIN1BNBNCCrOVAQdq3u/aP8trwRWE/SzIzIZ5pKpA40eYss4h0obNSblP7rL
	 ceXTtPz5LIMJwEZzsvFB7t0oVinV3pyHVEYcF7EelyWCwzqt9fIzAtZYp+LkCtPTg6
	 ePMoKBLO3qAHwznxKmBDAlOq5+E4alGg+ZU+aGGWDQfstk6cD6AKi3hyc78UbxTj/t
	 Vs95TksPCk67EK23TzkhQeHbCoi0FyRF3cJt2GASVAG2Nkljpfh9DeNrFDpzVEV3Qx
	 wGSRm+ixDkj4PLYtEr3+Fc7/7EBzOhmGU64W1fymptEsfLOoINXX6nwTFME7eyCEg9
	 o71crohI4CzfA==
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
Subject: [RFC PATCH v1.1 05/10] mm/damon/tests/core-kunit: test <=0 size damon_set_regions() inputs
Date: Tue, 28 Jul 2026 20:37:45 -0700
Message-ID: <20260729033751.131213-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729033751.131213-1-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
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
