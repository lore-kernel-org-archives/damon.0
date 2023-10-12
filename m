Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AA34CF2;
	Thu, 12 Oct 2023 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqFUhq0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4A7C433C7;
	Thu, 12 Oct 2023 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697138578;
	bh=dhkNkcd5s5dF4hY99APwOOIKtTfhuQ585ymiYD2asqE=;
	h=From:To:Cc:Subject:Date:From;
	b=aqFUhq0pY1YB2OjHpjc0rQz4kU1EVFhRX7IY2f1LSyOh0qJXFpzH4+Qlm5zltWdT3
	 I+gDoQUNF3S5+s75NqsZW5GugdC4+m35pte3sdBnx6tq2ga1Hac8J7pMbNHra+Efcg
	 V7YNhtDQEX/n+/LnIulfUF57Em6W5I+ZW2RuV+QrdgfdlXwY1GTNkXMZGjBBlIRjlg
	 h3F1IiXedOJgtVat2g57BmwtcEkPUKGFAVatVIwvM9+7/blH7Q6s+UuGI5EluTOM5Y
	 bJNJPKhG8EPkl9eTtRgB9lQeabHG5umqCVM1jNwZJZkBIe861zNWWcpb6Hh5UyjfAO
	 mEu5jxwitRKFg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm/damon/sysfs-schemes: Do DAMOS tried regions update for only one apply interval
Date: Thu, 12 Oct 2023 19:22:52 +0000
Message-Id: <20231012192256.33556-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from RFC
(https://lore.kernel.org/damon/20231010012600.83140-1-sj@kernel.org/)
- Rebase on latest mm-unstable

DAMOS tried regions update feature of DAMON sysfs interface is doing the
update for one aggregation interval after the request is made.  Since
the per-scheme apply interval is supported, that behavior makes no much
sense.  That is, the tried regions directory will have regions from
multiple DAMON monitoring results snapshots, or no region for apply
intervals that much shorter than, or longer than the aggregation
interval, respectively.  Update the behavior to update the regions for
each scheme for only its apply interval, and update the document.

Since DAMOS apply interval is the aggregation by default, this change
makes no visible behavioral difference to old users who don't explicitly
set the apply intervals.

Patches Sequence
----------------

The first two patches makes schemes of apply intervals that much shorter
or longer than the aggregation interval to keep the maximum and minimum
times for continuing the update.  After the two patches, the update
aligns with the each scheme's apply interval.

Finally, the third patch updates the document to reflect the behavior.

SeongJae Park (3):
  mm/damon/sysfs-schemes: do not update tried regions more than one
    DAMON snapshot
  mm/damon/sysfs: avoid empty scheme tried regions for large apply
    interval
  Docs/admin-guide/mm/damon/usage: update for tried regions update time
    interval

 Documentation/admin-guide/mm/damon/usage.rst |  6 +-
 mm/damon/sysfs-common.h                      |  2 +
 mm/damon/sysfs-schemes.c                     | 93 ++++++++++++++++++++
 mm/damon/sysfs.c                             | 34 ++++++-
 4 files changed, 128 insertions(+), 7 deletions(-)


base-commit: 937421b2a4e95c57fddf10477b949fa5693711da
-- 
2.34.1

