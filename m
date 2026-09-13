Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C938BF89;
	Sun, 13 Sep 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319839; cv=none; b=eo5YuOSu23wef9ogLexWBe0hpLq1tbLvXdTnDkOXGkz2vEjRwpruNx6S1nAAUDna/nxsS9ezMu7IGdXxgdPVhSzqiBlfbxBY0/3gg0XigvU88mCc7zHNggnZc9wis+wuwNr/vxL5642m3ehEfuxILbbE/u0ba3yqroNN9SXHxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319839; c=relaxed/simple;
	bh=zKNBJKJMEE7iDlzCLwTQdJt35qvvUznZGcGFB4z2xBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAGyqFDuNbAj/VGzgth3t+fSs+s7cFZd6EZ6ttrM0r2zFyuVQGpWQ5dtWtn2oVs8OFXmuFSWAsIdoKHCYik4Zuk1bJ4H8TRpDwqY9JHkxPzGsIvC0AmCUT+DvQxVauVk7XBLekB08DhEr3xF7xVftthaepYvDaKgIUhYwL+qY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEU23QJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEU23QJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0E51F0089A;
	Sun, 13 Sep 2026 17:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319837;
	bh=as3OPkNFsYYWKFBQO9tZASdaFQXU9TrMOPenfE/ek3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEU23QJZRHcX0hf20lXi65rqTmqiivKMAkC8NWufRT7WW+XbOERTEzf6LOBNj+o8T
	 KdT2r6OtpYD27Ng7Q+Mtlp1jDlRl5lYYltAWyx8puWG25O5SQTLk79wNHEEw33znUr
	 uRwJGhZbp2nM9BidpT2oc98FQAtiyvIjxACfE0xEnYZuV+KiEmk77q2lMdO+mKC8n+
	 UTRrz7j85k3xK4VbbWGOH/rphd0YXZa7iWF0dEiiGGODzKFevfGLMmWzz776B+acKc
	 MTB+wmuAUkZggR2syAibirXfUBPQLBfUVferBLJ6EWSxUU8MtnRqSnxVRL7eAvqq34
	 ftqdznGyrAZAA==
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
Subject: [RFC PATCH v2 8/8] mm/damon/core-kunit: test invalid damos filter commits
Date: Sun, 13 Sep 2026 10:17:05 -0700
Message-ID: <20260913171706.103052-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171706.103052-1-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
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
