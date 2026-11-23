Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446578;
	b=Ga/p3g0RxVWfb6tW0BYURO5TbBZTskOHyKT48zvAUJUGScbgdKN+XnviwhojJeBi8K01
	 UqyGpJ5yf8UnOwWojMXzhUK6zV44hRS5lz3Xjxk5FxOMEPJiBtHsVzau2OsvtupdFAgUX
	 knxRGwzcgs7ai3mgwPVyr9EHn5h8KZFlrnIMWEJ1ak+onRwLHz3KP64z0587jUSMKOHv3
	 BHvlYQshsiS9ItooML1p+UoUzFWAB3Aptgt5VqxKUXR7Z6vDZAFQzHoROmvtbDX3lgztU
	 IJyKZu7Ql01IRlrYIPJlonYdwVERrDvKZCUUvqDEOot8Sr9qqsTSmwdltsGBxeQpo2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446578;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JJ8c/8W1EmEuE66i5nJ5h2SZQ9wJSL5O/EOD51UVqLE=;
	b=21GiQxw/QYTDWToXNrBWl8HRWHXgsSqUcfrEE0Xw3uclJoZqN5ompUrUoS5H+5KlXn+z
	 hYhYvdr8kVIG0zu4/FWirx6GlAC08CjYRSAq48P+mz+V6KFclNipAPjuhBw3WZayvdc+A
	 nbBzBLeY3ejHHtvdpReWiKwDPQXyqa3iqvxuolkYp81o33Wh3sZH4hlQfy0V+1fuzmYRL
	 zy+8sM7rlBgY7DJR9wLfb67QQoFs/GM1pWm2srZibGlJeIEwlHctXa2qTKXncymqwveIN
	 +YluUiFKjrOXL9zdljTuYfLCaGncycP263HqPdyHqwteXYKsNsK0iLynZUqV+CDVVtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7nkVgaa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32254606A31A;
	Mon, 23 Nov 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7nkVgaa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED331F000C4;
	Mon, 23 Nov 2026 15:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446577;
	bh=JJ8c/8W1EmEuE66i5nJ5h2SZQ9wJSL5O/EOD51UVqLE=;
	h=From:To:Cc:Subject:Date;
	b=j7nkVgaactOMke8k3yZMiQUfqdT7YZtD1yDQNOU7+OoldrqyMeYZrmc+ezJbemsA/
	 R67BJu8UQ1hQ3CjM8qeLRfIBsP1Q7yCh2jTE8xsB+4hgaEljBgj5HCkX02nzlLaJ/R
	 SOcM46OCVzo9gw1YUUXLo9RfEBbA66+YgCqcHwn5GhFOQpi+o/W5jtKwn1Pil1vZjB
	 jMW6feld473fB+ZG8dSzpJ1UWyiSTy5mbFj3xEzTjjm2wyNIF7LZFBOTzs0ofiCu5D
	 1xd5vFwrgoE3ltrJtZY03t/LWv/zwyHJ0gwLoQwvglWBaWR1a9Lciz6xKAx+5te0qv
	 xFxwy7Sak/xgw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] mm/damon/tests: add KUnit coverage for age_ms filters
Date: Mon, 23 Nov 2026 07:09:24 -0800
Message-ID: <20261123150929.81797-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Angelov <jasonangelov@ucla.edu>

The DAMON core tests do not cover DAMOS_FILTER_TYPE_AGE_MS. Add tests for
committing valid and invalid age ranges, identifying the filter as
core-handled, and matching ages at and outside the range boundaries.

Region age is counted in aggregation intervals, but age_ms filter bounds
are in milliseconds. The interval-change test checks filter matching
after both increasing and decreasing the aggregation interval.

Changes from v2
- v2: https://lore.kernel.org/20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu
- Collect R-b: from Aveline and SJ.
Changes in v2:
- Fix commit-message formatting, line wrapping, and comments.
- Set age and interval inputs directly in patch 3.
- Add SJ's Reviewed-by tags to patches 1 and 2.
- Link to v1: https://lore.kernel.org/r/20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu

Jason Angelov (3):
  mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in
    damos_test_commit_filter()
  mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS in
    damos_filter_for_ops()
  mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS interval
    changes

 mm/damon/tests/core-kunit.h | 93 +++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)


base-commit: 5247761933577a245d262c55994032b86cbec2d1
-- 
2.47.3
