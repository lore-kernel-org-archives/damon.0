Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8063C584A;
	Mon, 14 Sep 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395612; cv=none; b=Ah9SdRwtaCMAqDkvl1+FenhabiQ2c/G5Jmbd4DiVOcHY6QzzkHMdrS48an7rbC8Kyx78YMr126WnbLg5Stv2+EFQPuEZ6AvSPYB61FdU+KTa+qMisNwS1GjnHzZ6ABUqOlGSk+/W5yShWEj4b4b0Yr1VgEMFIYcdiXkko/BAUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395612; c=relaxed/simple;
	bh=2q4xJ0P619evK9DKIBKz/BCbjFgZ1UrTrSqvgshqZNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4RmmM8G3CgarH5Ha67/z2Xh3EqeOl7doh78EwznkVpca2opbFvrboHFZjm2xhWrnZfKUDugUSbAx7Kb/CkJZ9SJK4+fw2AxfoZsATvOSAcPSRk4bNkB0P/4OSVgGxx7wpr+7E2rLbHyCGIAqZNRkcIDYc+QPtqi9qA9XrgOtT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn2zEmzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn2zEmzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D6A1F00893;
	Mon, 14 Sep 2026 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395602;
	bh=Oi23zu2/PrV0Foc+v/urHYp6bcscQLI0NRalUKOBVW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jn2zEmzg+8eiuhpnhyv9+INeK0b0PsfogpmddAwICz0n1DBUnFcadfFFpVffnaSJS
	 vsKsEiNKXkO/Kl4FgEFeZJFiBlEyx1S6WFKEfjJvy8gnXibdwTLeQU2W9bkshneTkc
	 XnnGaHWVx9bygDzCyMl+LfVoaw3/8ladZfooOKsSo7poW0P9Pqth+9uzTOMQCgwkf6
	 Ad6Qmj+4U6jMwKKl1xiZZCvg9G1nHsUbTZRmjczJg1FQxVNn/gaBOSWUYyl2QA6pjj
	 XO0tChvfTnDPewBNPesDi411NMzSx1kV7ahtGTSRvvqq6uLtRzw90zbOj22GOOeV+0
	 7Hz7jeFMr+Y0A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH 4/6] mm/damon/tests/core-kunit: improve nr_samples_per_aggr test isolation
Date: Mon, 14 Sep 2026 07:19:49 -0700
Message-ID: <20260914141952.91465-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914141952.91465-1-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Test the zero sample interval case with a non-zero aggregation
interval, and keep the zero/zero case to cover the zero-result
fallback.

Also make the overflow case use an explicit sample interval so that
it does not depend on the zero sample interval fallback.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20260909070711.2448346-1-kunwu.chan@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.
Changes from v1
- v1: https://lore.kernel.org/damon/20260908063635.2208922-1-kunwu.chan@gmail.com/
- Use 0/0 for the zero-result case, consistent with damon_set_attrs().
- Update commit msg and add Reviewed-by tag.

 mm/damon/tests/core-kunit.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c01e6a75cadc1..a47a5cdf285c8 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -627,12 +627,20 @@ static void damon_test_set_regions(struct kunit *test)
 
 static void damon_test_nr_samples_per_aggr(struct kunit *test)
 {
-	struct damon_attrs attrs = {
+	struct damon_attrs attrs;
+
+	/* Zero sample interval is treated as one. */
+	attrs = (struct damon_attrs){
 		.sample_interval = 0,
-		.aggr_interval = 0,
+		.aggr_interval = 5000,
 	};
+	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 5000);
 
-	/* Zero aggregation interval doesn't cause division by zero */
+	/* Zero sample and aggregation intervals cover the zero-result fallback. */
+	attrs = (struct damon_attrs){
+		.sample_interval = 0,
+		.aggr_interval = 0,
+	};
 	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 1);
 
 	/*
@@ -640,7 +648,10 @@ static void damon_test_nr_samples_per_aggr(struct kunit *test)
 	 * overflow
 	 */
 	if (ULONG_MAX > UINT_MAX) {
-		attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
+		attrs = (struct damon_attrs){
+			.sample_interval = 1,
+			.aggr_interval = (unsigned long)UINT_MAX + 1,
+		};
 		KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs),
 				UINT_MAX);
 	}
-- 
2.47.3
