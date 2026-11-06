Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930768;
	b=TzH6TLu8bASUBTWYmoan92D1Bq7SFRgMZILdEUi7cHKgmts9UklNmkSrEyi7URjnOROa
	 nHk+MOinRpazAdNnn6Llco0SeRRdJ5WHBWib2pAqEWRNWn2jlc3PCewpyyIzLq4vRFbZ9
	 pDf65Y/HgRz/pLzpmi5/go2GtCHRj4o2Qa0OIxKGwlBHw1Tb7Kgka7uZ9HjkDMpDM3FXs
	 Beca78djXc6SKYdz7ziN5mJzTXrK59SqaHc52piYx0ls6p1Q3OF+tWO0IBcODppLprgnt
	 yUBSTfkjCpxyxgO/clETDM7C9BixRggC+ZgHgNBQ/4XCaWkooNxg9oX4BqyBvVDCamA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+jfAcZvSxO4g28unhuivWT88AZU4hI/BOX/Z4s4PPy0=;
	b=AqAHv/q3nPUJCSZFLNfInNYszeuiIKkdGF/xv0A9rlwBTWbVRlOyebMc1yjghNP3L9AC
	 O8TXkvI7huazeGGymnjTC+EW/4OR2q+oiUjsqNclG60yQr/6tFJScJgcMi+O5NUOyKmpG
	 7iuIFc0GquUoorJDCHHoZUp3sth+mv96WNopY+NolRHkhXgUx94ntPr4/Mv7twXt4JDZu
	 dL1rTZmWDsrRefkD8ohGQUd9Shh5raTzma/WNXtKf6mQoQPZNyAP1YYtiHtKrje4i0uVx
	 iM+h/n5ING4VvgpifuESO62Mfh0eevwyM+Om2hIy6QJoq0sAwXfMAg3hll1KDSWfT6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YViRP3+J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B73C606A31B;
	Fri,  6 Nov 2026 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YViRP3+J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0191F0089F;
	Fri,  6 Nov 2026 02:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930766;
	bh=+jfAcZvSxO4g28unhuivWT88AZU4hI/BOX/Z4s4PPy0=;
	h=From:To:Cc:Subject:Date;
	b=YViRP3+JBx0U/NyWH9/JaYvOBxsvdJHuPWnx/znRaVcUJG5Br2bSxRVILsrtyploB
	 I2N9qQ0q4+5BpquvAzUvhS+dNU075TUW9mQUdJIHNP5Z5nZ/5KSXANCVGml5axjAc5
	 yYPDc1H+vczREA3nKWnImiQ+7dm2OWIPy9AXfWF+thanS9C7wmYd5cRC36us/N6M5W
	 nBCyyE+sBwC7AmGQargd7SZ1zZwjKSw+vH+9jJRlpz0mCOpM2UfGshveKWq4oU/L9g
	 1RSG6L1f21Cc8+ENpo04tG0Fl6ccLVTtKAin6eTfAMMWSuaK8h4de/vFIouv/BZfZr
	 xNGAxY3mpYULg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon: introduce age_ms damos core filter type
Date: Thu,  5 Nov 2026 18:05:54 -0800
Message-ID: <20261106020559.98352-1-sj@kernel.org>
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

DAMOS access pattern supports selecting regions to apply a given
operation to, based on their age (access frequency stability).  The age
is specified in the aggregation intervals unit.  The aggregation
interval can be changed by users or intervals auto-tuning features.  If
the intention is to specify the age in a deterministic way (e.g., 2
minutes), it should be updated for each aggregation interval update.
Doing so is cumbersome and challenging, particularly in the interval
auto-tuning case.

One straightforward solution is extending the DAMOS access pattern for
specific deterministic time based age specification.  However, DAMOS
core filter is a better option.  It is playing a similar role in a more
flexible way.  It can be used for both accepting and rejecting regions
based on if they matched or unmatched to a given criteria.  Multiple
filters can also be combined for more flexible and detailed rules.

Extend DAMOS core filter to support milliseconds unit based age
criteria.

Implement a new DAMOS core filter type, DAMOS_FILTER_TYPE_AGE_MS, in
core layer and expose to DAMON API, via patch 1.  Add the support of the
feature on DAMON sysfs ABI with patch 2.  Update the design and usage
documents to explain the new features with patches 3 and 4,
respectively.

Reviewer notes (no need to be in git history).

Test
====

Confirmed the age_ms filter is working using masim [1] and DAMON
user-space tool [2]'s DAMOS filter-based snapshot feature, like below.

Start masim.

    $ ./masim.py run --config_file ./configs/stairs-500mb.cfg \
            --quiet --repeat 10 &

Start DAMON for access monitoring.

    $ sudo ./damo start --probe \
            --probe_prep set_pgidle --probe_filter allow pgidle_unset

Monitoring results without an age_ms filter shows regions of any age.

    $ sudo ./damo report attrs --style idle-time-percentiles
    # total recency percentiles
    <percentile> <idle time>
      0     0 ns  |                    |
      1     0 ns  |                    |
     25   100 ms  |                    |
     50  3.300 s  |****************    |
     75      4 s  |******************* |
     99  4.100 s  |********************|
    100  4.100 s  |********************|
    memory bw estimate: 66.628 GiB per second
    total size: 7.797 GiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

With an age_ms DAMOS filter applied for snapshotting, shows regions of
given age range.

For [0, 2s range]

    $ sudo ./damo report attrs --style idle-time-percentiles \
            --snapshot_damos_filter allow age_ms 0 2s
    # total recency percentiles
    <percentile> <idle time>
      0     0 ns  |                    |
      1     0 ns  |                    |
     25     0 ns  |                    |
     50     0 ns  |                    |
     75   100 ms  |*                   |
     99   200 ms  |**                  |
    100  1.600 s  |********************|
    memory bw estimate: 100.311 GiB per second  df-passed: 0 B per second
    total size: 7.797 GiB  df-passed 0 B
    scheme stats
    tried 0 times (0 B)
    applied 0 times (0 B)
    0 B passed filters
    quota exceeded 0 times
    0 B
    tried 0 snapshots (max 0)
    record DAMON intervals: sample 5 ms, aggr 100 ms

[1] https://github.com/sjp38/masim
[2] https://github.com/damonitor/damo

Changes from RFC v2
- RFC v2: https://lore.kernel.org/20261105044425.87142-1-sj@kernel.org
- Rebase to the latet mm-new.
- Collect R-b: from Aveline.
- Add test results to the cover letter.
Changes from RFC
- RFC: https://lore.kernel.org/20261104153645.82945-1-sj@kernel.org
- Use div_u64() to avoid 32 bit overflow of age_ms in core.
- Rebase to the latest mm-new.

SJ Park (4):
  mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
  mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS
  Docs/mm/damon/design: update for age_ms damos core filter type
  Docs/admin-guide/mm/damon/usage: update for age_ms damos core filter

 Documentation/admin-guide/mm/damon/usage.rst |  3 +++
 Documentation/mm/damon/design.rst            |  3 +++
 include/linux/damon.h                        | 16 ++++++++++------
 mm/damon/core.c                              | 10 +++++++++-
 mm/damon/sysfs-schemes.c                     |  5 +++++
 5 files changed, 30 insertions(+), 7 deletions(-)


base-commit: f10c161fdac5b0b3fac99877805e64e682c56281
-- 
2.47.3
