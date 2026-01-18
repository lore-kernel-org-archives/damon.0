Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC63019DC;
	Sun, 18 Jan 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759394; cv=none; b=narP6HV0dgOUZeCDGhI0unsV+s3I3PLvI75d3x3TvUXI/dmwgnNGWvgeKRI4GCpGtdCrImo012kBWngpJ7gUjhPPXL5VwXj1w/DCu4QbS0rNUPk8or2wPz/kJ8TtL5VzdFX/zOs9XMT0aChdV0AlvmakFaN7cC1e1O+8EW/Tw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759394; c=relaxed/simple;
	bh=z3Zk/jJdUa1YP5N4FiUh/fhzLI3wr0WgwfqrSYYQ9/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErvgxF7IYofFoaq6tFupMwupEU3soB1g6/aBjlwA1fo9m4SD9yJqWLOKruoK1jH+FTXlBygxia+IacMBSSn0Hldkg+9BTG+JvebSahfWXtif/VXchBCE1PDQZWFB2u1BhmZA3HzGR3+CveBbMnMFYtve7xsEdsbUzvZ5jYbBbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aV9+A/Tj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV9+A/Tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487CDC2BC86;
	Sun, 18 Jan 2026 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768759394;
	bh=z3Zk/jJdUa1YP5N4FiUh/fhzLI3wr0WgwfqrSYYQ9/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aV9+A/Tj2q1TX85Kvgou1yTr2rX8pG4GZCqHcC43bHHnXvnhCMN55xe0yC4RLpH3R
	 AuGH1mSPhLXa2LnTX+HmuCvrLcwrXTC1ZiR8N8lnssMwtiFhf/xFQ/rxD/EA/z4mFJ
	 OGaWsvs7+uE44Ed8UiKsJqEWis3/CMFf5HIQZrC+zRxMN28/y7qX872Px51Ag9TAKD
	 3YhggbDuE9tnjGgECcOApWRtgF4Onitp4AAoEgIFunMk/rfh+nJ7CwuMeH3PMY+jlw
	 02HqkCAEglLbmCzFuElojYT57sxYAVVROePpAyxUDXWJNANEhX1QWAD3OREp2mv2OH
	 SCRuguUrfsNTg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] Docs/mm/damon/maintainer-profile: remove damon-tests/perf suggestion
Date: Sun, 18 Jan 2026 10:02:59 -0800
Message-ID: <20260118180305.70023-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260118180305.70023-1-sj@kernel.org>
References: <20260118180305.70023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMON performance tests [1] use PARSEC 3.0 as its major test
workloads.  But the official web site for PARSEC 3.0 has gone, so there
is no easy way to get the benchmark.  Mainly due to the fact, DAMON
performance tests are difficult to run, and effectively broken.  Do not
request running it for now.  Instead, suggest running any benchmarks or
real world workloads that make sense for performance changes.

[1] https://github.com/damonitor/damon-tests/tree/master/perf

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 4fa06b21ec30..41b1d73b9bd7 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -48,8 +48,7 @@ Further doing below and putting the results will be helpful.
 - Run `damon-tests/corr
   <https://github.com/damonitor/damon-tests/tree/master/corr>`_ for normal
   changes.
-- Run `damon-tests/perf
-  <https://github.com/damonitor/damon-tests/tree/master/perf>`_ for performance
+- Measure impacts on benchmarks or real world workloads for performance
   changes.
 
 Key cycle dates
-- 
2.47.3
