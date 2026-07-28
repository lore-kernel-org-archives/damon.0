Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC23B3BEC;
	Tue, 28 Jul 2026 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216499; cv=none; b=rCjW7PJ7JsyA8vwOvSiCcfGbRiXlxKIbQOpPSWEhzSkO3iEEC9KOBNr+J1qVSVr+i6+O7gwL+akIbKboyokYHrLzhS15h7nMYQCbAsQCu0/1T9RTS1PYFkC/KT92CRqkNzUSWwFfmNCcWOvRpDCj5h0sEGnwJglo9EXAcJTyQ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216499; c=relaxed/simple;
	bh=PrDKIsNzBcOI2wImwGKxiCXSpt5whZrLxV5oplnveaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Giw69gB1C6WxA5pgd4sKUDF0Y5tHFL2GTIw3t6Cuxiw4K7hjdvBLUtBRm5qkor62QKGqngPSvefndYA+L31irWrqqpSQPZSWrPptMT2g1+vnDBGrRRqFptohfnOALVvuoS+09JKwwCg1CtBU3FoVqeqEz7bt0HYa1aiPa30VnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRUjvaI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRUjvaI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCA61F00ADB;
	Tue, 28 Jul 2026 05:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216497;
	bh=SOFGYop7G5CT0IvbShe/iVSTs0keWEcjAd/ooP0VIE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FRUjvaI8UZK0DqChqTkQHSOQHLIsAkK1WBKhqUbCViUNDznXWW13+m+Wv0t2Zfar4
	 2tgCS+aASXEOfu2mTKuWp8nRGw+pCEYCatqsLeiAHftk13ktR79nyz9u/96cj0fpGa
	 hncLVZZ41bENBYxUDK+/UjZ2i7c0dWJRg8M5tlzgzMMelPqiKwFXXN8NhqFk94JuBL
	 tWp9yS895Ckly9pVOinHuvasKapBoQHoxsWKexSoRmrWVChD0WMKjgfOX2BtCY3v6H
	 D3UYt0v71VcY3LzAGANEF3XCcyOrRO15euSEUW6HOwDiGlfeW20qqgQPprS/ObT1Y/
	 Y/TKShU0ENTWA==
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
Subject: [RFC PATCH 05/10] mm/damon/tests/core-kunit: test <=0 size damon_set_regions() inputs
Date: Mon, 27 Jul 2026 22:28:04 -0700
Message-ID: <20260728052811.192712-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
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
