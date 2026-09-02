Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0D38DC69;
	Wed,  2 Sep 2026 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328078; cv=none; b=LV7vAqiTzMKWPOSTMQbcsrk4wQH5AvxBOBCPW/dpn3xwOozL/nveE9LCbNlZfA4lgEAxb4vMQyR7lFo2qbeQYnML6E1V427pLGPMpeio7cxxempeLU5pEHHSlem96p6+rf73ykIFwVRc9yZzf5Udccu/RUPDu6HeYsmkQgPanLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328078; c=relaxed/simple;
	bh=u+oZCoOKdySThIkJPUr4RxCiZbFXrkCX08oE+VOZRT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3X9CyMleJy/pQvNrrkk1B7aPJaXxuA/zX8+0coxSVuzBPOOgTawuT87tQjqujdNz8OXXRYxAJdgsFQe9lX4fhvbD1t2+iO411k7qtJ0T+hp5Bs2opAJvzEkZuWtCvU0ktht8Tt+trkwcClM8MqYEGrheaIGGYSpJi4MF5RrSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/bSpy1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/bSpy1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6491F00A3A;
	Wed,  2 Sep 2026 05:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328077;
	bh=KmA3XIkDsEGWw9Q0yqvFSyXfLgWn5kQtFO0BvVaBzPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/bSpy1oP6r9W1m5m4QtCcakQBc2X9gSn8wCas9R2qnb8rZfo0TiEGsjmLT0SsUz1
	 Y5JhKg7MqDK+IPWptQ+GXfm7P2YCBQxEutJhb89J0+QettPXBWEAe8ICmMz/2D6ROw
	 mCIQ/WW8hq3EPMKg7LrOqwLvcs86GZQu72nmLWV7sXxCr3I6g2t7caVI94oheqG5hi
	 kcx3PpznSKVhwaBpYSpy/Ky35l7a1/yny/YvbvjDcxd1S+j1OqEe8gcmrEfBPPWROw
	 dgViNOVYb1iI4882eDw2Q6RF53sfLGTEMOdhApqlbbWYFhfdTd5u0eX16kTTDAivu4
	 OPTlUF0FemY4Q==
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
Subject: [PATCH 07/12] mm/damon/tests/core-kunit: test <=0 size damon_set_regions() inputs
Date: Tue,  1 Sep 2026 22:47:40 -0700
Message-ID: <20260902054747.99370-8-sj@kernel.org>
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

Commit 1292c0ecb1ca ("mm/damon/core: validate ranges in
damon_set_regions()") disallowed passing zero or negative size input
ranges to damon_set_regions().  Add kunit test cases for those inputs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 2bcf3bafe2e29..3cbbbcbfbef8f 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -598,6 +598,20 @@ static void damon_test_set_regions(struct kunit *test)
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
