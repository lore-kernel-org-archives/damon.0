Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB73839BA;
	Sat, 12 Sep 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240699; cv=none; b=nA5MU7+bT2p8Nw5Z972HACgtXBa7aFckrik9Wqd1LIq2IGQMjtD211BNUEXisa/3oQ8E1crerWlqg/1SvP2xAxnPB38p39kKkULhuuPQeNkGggyh0768GEZ4rSuu7iQnBayxfZ5xBrLXH2XeiqZRthTW5cInxXSiAY5PF/GOv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240699; c=relaxed/simple;
	bh=zKNBJKJMEE7iDlzCLwTQdJt35qvvUznZGcGFB4z2xBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvaxe+JJG6fommzQtldvph4AreOmAMmQAuVAvRozz9e2XcOq0wP1IoBCVRce41dyeWDTWA1btA5P8FsQflTI5Vfpli6NYLSboa3OJztmqaNluV3cyoppYKNj7glGAtZN6PG9cTi/ovTg7HI6PIow2EW+Jnlgga5fAL4v+fJy0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkYDo3z4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkYDo3z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194621F00893;
	Sat, 12 Sep 2026 19:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789240698;
	bh=as3OPkNFsYYWKFBQO9tZASdaFQXU9TrMOPenfE/ek3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gkYDo3z4bVAwkbLlvRSugF93EZpKUfMq3gUGH37PieSO6VIDLJYlCn6C0IiGcVIt3
	 hAAyoIGNJWpMGfCVAIjItVbz1vcOKq+TdYEsXUlD7aTEIcVkCM2iLrgIE7tv4MXNF9
	 gjkWjd6c40ame6/dA9N1nJ05DPvf5PyToguj2EfbcUxweZ73jtv5d24MVkRD8flkW+
	 F/krcEHjJtPhkE7/3wlsp/Ymk7ge/iULGRdIAaS7GF6BexM39ZpCxyhbd1e1indNE8
	 XdA5j6tn6UEtSGR0TpEkXUnl3XQAE+BTpsezXsJBmosazSneAA1IMsiQihEzzNhWPj
	 qcDcUk/EGVgEQ==
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
Subject: [RFC PATCH 8/8] mm/damon/core-kunit: test invalid damos filter commits
Date: Sat, 12 Sep 2026 12:18:06 -0700
Message-ID: <20260912191807.138502-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912191807.138502-1-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases for testing the validation of damos filter arguments in
commit time.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c9941f3bfb42b..5da84caf4124d 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1195,6 +1195,13 @@ static void damos_test_commit_filter(struct kunit *test)
 			.allow = false,
 			.sz_range = {.min = 234, .max = 345},
 			}, false);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
+			.matching = false,
+			.allow = false,
+			.sz_range = {.min = 456, .max = 123},
+			}, true);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_UNMAPPED,
@@ -1208,6 +1215,13 @@ static void damos_test_commit_filter(struct kunit *test)
 			.allow = false,
 			.addr_range = {.start = 456, .end = 567},
 			}, false);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_ADDR,
+			.matching = false,
+			.allow = false,
+			.addr_range = {.start = 567, .end = 456},
+			}, true);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_TARGET,
-- 
2.47.3
