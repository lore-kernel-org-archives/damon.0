Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D947F76A;
	Mon, 14 Sep 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395820; cv=none; b=Ikh0bP/wo7Q1HmQ1QYUCXIrMknss27V9ojFG/uRbhthjDbqkgn/PY/9ZWP4dW7p30vXRXsHllrinKTbSGuzMwpkfQXuWWk9EqJTrFRaDBwJ1H9SkEe5fF5zEyNqAl9s/SjIr/OR6QgtPURQ5/UcbE/fI+AD50VeNgpyTSU9Z/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395820; c=relaxed/simple;
	bh=zKNBJKJMEE7iDlzCLwTQdJt35qvvUznZGcGFB4z2xBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2n0nHTac1AThrf2LtKdYF+52OxJkO2n1Ui3wU2pBsj3xDASpVc8U9jNZ922jHLSieFoSdSpsOd3rlcTcFudX8WS+WONaHGGY1eoy7ZelrIQzKyhErIRSVHkB7n7GSlTxE7quN0520zA90eWvvY1++3f/Z1sHeVSArWoYAGFyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfbPjnCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfbPjnCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D851F00898;
	Mon, 14 Sep 2026 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395818;
	bh=as3OPkNFsYYWKFBQO9tZASdaFQXU9TrMOPenfE/ek3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QfbPjnCU+7FZv9NkV7ueIUM52aqYwMTjeAfgvF58Ws5kEex/XIBHYQog+p4kXhpZo
	 Jr8AVptoounx//8OBjL4AvZZ8QKunrk1w2OQ3E/hpRr2Yu1aGHKCXyQD9+OiARcccp
	 Fre97vt4S3P4ZH1aAnTqXJw+EFHK64DKtbwa8uC4szNMv36ls5U0u/e9Y01flpGLXQ
	 Vwm0tQHVRlGbybAGU85NbUGCVmuBfJ3dmdytN1UYurJZQ2Zl1hhfctEvcTmFWdVuFU
	 E7/IYXrHiX7a3qNFWpwNa6ysYEJilXwJMMOEYZkzh77c8LVOPXx3mk3mWOr6BeUbfm
	 WbSDnmwPpcx8g==
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
Subject: [PATCH 8/8] mm/damon/core-kunit: test invalid damos filter commits
Date: Mon, 14 Sep 2026 07:23:25 -0700
Message-ID: <20260914142327.92510-9-sj@kernel.org>
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
