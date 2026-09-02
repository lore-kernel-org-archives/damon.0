Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B938F255;
	Wed,  2 Sep 2026 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328079; cv=none; b=d+adaMjTYWllzwbdOoEVJFt1FmrRS8JPEHGOQIiuJMoquQ2zWjuDPZpuH7eAuoHhgk1VjXLwJdVUNLlCdl7n2szrXUWK5eAaA2zXQve8CRZF9Qhr9pFxYvI4JVNVMFJ017U7yjfltTSBEcngQT3niA8ErqjyJN003N3yWCfJ0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328079; c=relaxed/simple;
	bh=2pZTkI/oCmWinwH6DeXmTbs9qIAw+27YX/dzECNnx2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFvxwxn96GnWcAiTdg/ru3s8OW02Uimpcn/Z6BTYz2qQTgfrKYlQkOYLi+/SekptcTTAbmwngzvAetWDOXqrGIj2UChl78tUxGpPiziVZ27mZDspl09hL2at825sjHrnWULYllxgi1BnmTr8e3yLjnBFHqJ4PBdKzrsSzyyxBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy6DkBnk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy6DkBnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AAD1F00A3D;
	Wed,  2 Sep 2026 05:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328077;
	bh=LCVrTJpLa2unGCETWoawjk8AD+WeKZfpebJRiu9J1ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vy6DkBnkymZetvewrk8FS6KINWHWOlX1jyYBRcTg0m96UVSraiO/U0opQaAvso2ol
	 P0cfp76K+VND/mokB6TfEyVBgGVp/nDpbqhde/ht1M9WqVoS+X/s6ZwYn6OqzldoPq
	 Vm9vERApPAp5rqb+XY2Uh6TaUOchkGBsqufU4WYy+YUR8OGWiG+84iw6BttJrvTRJj
	 YJSMYxjmEmy4oY3EwX7nFDkN9q7hkpaJBvhmyfilAhiMXVZWQJ9xZnnExnkNJKE9+r
	 euSF1WZ15iwLkqCxjDpjwL12jtoknq6ISX74LXuzuJGhT0fURRvsPDL2zfNtuy+chG
	 h+GGPRoBjgMlQ==
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
Subject: [PATCH 09/12] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
Date: Tue,  1 Sep 2026 22:47:42 -0700
Message-ID: <20260902054747.99370-10-sj@kernel.org>
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

damon_max_nr_accesses(), which is a previous version of
damon_nr_samples_per_aggr() before the renaming, was wrongly returning
zero or random overflowed values for extreme intervals setup.  Commit
35d4a3cf70a8 ("mm/damon/ops-common: handle extreme intervals in
damon_hot_score()") updated the function to return correct or more valid
values.  Add a kunit test to ensure it is working as expected.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a4164ac489a61..d0bed01a5b7fe 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -625,6 +625,27 @@ static void damon_test_set_regions(struct kunit *test)
 			(struct damon_addr_range[]){}, 0, -EINVAL);
 }
 
+static void damon_test_nr_samples_per_aggr(struct kunit *test)
+{
+	struct damon_attrs attrs = {
+		.sample_interval = 0,
+		.aggr_interval = 0,
+	};
+
+	/* Zero aggregation interval doesn't cause division by zero */
+	KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs), 1);
+
+	/*
+	 * Too large aggregation interval on 64 bit system doesn't cause
+	 * overflow
+	 */
+	if (ULONG_MAX > UINT_MAX) {
+		attrs.aggr_interval = (unsigned long)UINT_MAX + 1;
+		KUNIT_EXPECT_EQ(test, damon_nr_samples_per_aggr(&attrs),
+				UINT_MAX);
+	}
+}
+
 static void damon_test_update_monitoring_result(struct kunit *test)
 {
 	struct damon_attrs old_attrs = {
@@ -1736,6 +1757,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
+	KUNIT_CASE(damon_test_nr_samples_per_aggr),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_mvsum),
-- 
2.47.3
