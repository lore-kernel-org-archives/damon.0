Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C324B8DFD;
	Wed, 29 Jul 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333787; cv=none; b=XBG4tRaNOcWlb0MM4OLBTV9C6KmsWAiT/IrZd26ir7WD3DkBpGNbjQbnLU/QPjnItpuR/BpLNGVsgj/LONakQfztC70uepi7MDfJkK1YFeX/6kh3ueokrmm1cGxjM21xZ9Ga/y9zQ/kn0H3iG5xuIC4pBMC2L6cs2fHZAa32ZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333787; c=relaxed/simple;
	bh=JZ2ls2rfwNLy89+gQkKB4MGAUvIZm/aeJ6zS1xo67pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhhUKDtpeS8faWgLwTWWw9526As6IRxeBe4rmMaX0THZr5IFi1H35N7ec7ny4cOJGfniWhM5LwygZLsjVoVxkpFvAaaQC3L+X8PzHcmth26w4BPTzPZ0wsTFNj9S52UYF+zjfIMOaj9JudJUwPfMpcz5/ZCV+KVVHIVewMCuKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8ehlRJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8ehlRJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED701F000E9;
	Wed, 29 Jul 2026 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333786;
	bh=0Gg9s4OxjyZsWduv6+bFXiwNwPGMDtkx9gG9oVB8jE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b8ehlRJkGaGCxduO/cD+MG3q9sMp7cELQn7vOUCBQLA+E+Q5kYiip86CnkBduoqgm
	 v3LRexWczG5gaCd4aWRUGgqgQAyTTOaYsd8ZDA7O/5hLyDZ4oxf7Hf/zMoPQB7b+xI
	 UXoHLjd0PWma9IKdF7RE95HzYhT3KmElp1hnLGRNhq8P0afYf5LS8KuIplbfmQsZ15
	 m2J3gyqjWgf4pdnL1MUKYcN2WA0huzxLoBC64WnINF8spXBygSvS3WE+IKHCiFJltC
	 EzIalHwHlww3aLGH6ijs/BmiVDdwaohjEbadZGjZRW1BdJ098PTFF1lucBG4eJcflb
	 OfCuHNYOHmFww==
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
Subject: [RFC PATCH v1.2 08/12] mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
Date: Wed, 29 Jul 2026 07:02:48 -0700
Message-ID: <20260729140253.87753-9-sj@kernel.org>
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

Commit 954157679ec3 ("mm/damon/core: disallow overlapping input ranges
for damon_set_regions()") disallowed passing overlapping input ranges to
damon_set_regions().  Add a kunit test case for the overlapping input.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ac15393a7935b..252d81c30d6f1 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -606,6 +606,17 @@ static void damon_test_set_regions(struct kunit *test)
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
