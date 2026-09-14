Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18E47D462;
	Mon, 14 Sep 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395608; cv=none; b=jXhYSdKb66Y2ZOUsR4drSOGqRgHvICU4fSvbwmM0iUtw7/l9t+bIag33k8ypGgJRG022sMRtN8SNch/NNM0J2oLaZ7qzDvoUm03KG39ucynOjKJ5qb4czlX5xv+uNw7iikb/SXyA4OmZkfUcrgs72WI7K6XO6r6NL29G3kmZJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395608; c=relaxed/simple;
	bh=7R50BPVYpr4c2NJfRdDUq8laf344UbkGortnVLm0Lls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTIs3B8Icg0sNiNGfEQ97mMQK4Ya+E5DAiMFVKbrI6711PF4I1dUH1LjiRP0mCbbfikBleBr/FJTEeqRGxoMCmeTB3BILK5+UDh7IhsfF46wans7XUsRjxpZY42udIxc4OfdVf113rcELcTRxQtGk+icgNUz6sPykBOBWVqZ5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOxl9EV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOxl9EV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF401F000FF;
	Mon, 14 Sep 2026 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395600;
	bh=Xe9pCAP7+znsH3YX32HlW65HgZEqytv0rSrycprzx2U=;
	h=From:To:Cc:Subject:Date;
	b=aOxl9EV4HfSn4CW4ndI8Yc7wmc+68nQ/AG7gNNVkiYH+WZ/fZX/7xfou5DflqaULS
	 lcLmDByziVNq0IgTmy0cqm9KA5KSuXP+p1WglgvPGKksP5/7kx4kEAmyPW5UyheGNI
	 C/XgdTjlg0zYIIFnR69ygbDwuI4DUke3vlA46dbWm8RBXjz3ZC3FtyiISJhTXHcXtd
	 LG8nJFRUTA5UBX+nMAViIamKQ/ShECpxvjzgvLm2u6UgOgFpYhzIxIXLWda3ZXu0gT
	 5L1YRjxd7+KUUPCyMoTJjDYgQ+8U/M3+uvoCct07REl1W6f37ygGoq4imEEiHkAhOg
	 yRh0Y/qG6F0ug==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] mm/damon: misc improvements in tests and documents
Date: Mon, 14 Sep 2026 07:19:45 -0700
Message-ID: <20260914141952.91465-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add various improvements to DAMON tests and documents.

Patch 1 and 2 from Zenghui Yu (Huawei) let DAMON selftest to clean up
its state and output after running the tests.  Patch 3 from Eva
Kurchatova makes a few selftest be able to run with Python's safe path
mode.  Patch 4 from Kunwu Chan improves coverage of DAMON kunit tests.
Finally, patches 5 and 6 from Liew Rui Yan clarify and fix typos on
documents for DAMOS quota behaviors.

Below are notes that can be removed in the final commit message.

This is a batched repost of DAMON patches that were individually posted.
Please refer to each patch for changelog.

Eva Kurchatova (1):
  selftests/damon: add script dir to sys.path for PYTHONSAFEPATH
    compatibility

Kunwu Chan (1):
  mm/damon/tests/core-kunit: improve nr_samples_per_aggr test isolation

Liew Rui Yan (2):
  Docs/mm/damon/design: clarify when qt_exceeds increases
  Docs/mm/damon/design: fix typos in temporal auto-tuning algorithm
    section

Zenghui Yu (Huawei) (2):
  selftests/damon: stop kdamond on error exits of no-op commit test
  selftests/damon: ignore test-generated damon_dump_output

 Documentation/mm/damon/design.rst             |  8 +++--
 mm/damon/tests/core-kunit.h                   | 19 +++++++---
 tools/testing/selftests/damon/.gitignore      |  1 +
 .../selftests/damon/damon_nr_regions.py       |  3 ++
 .../selftests/damon/damos_apply_interval.py   |  3 ++
 tools/testing/selftests/damon/damos_quota.py  |  3 ++
 .../selftests/damon/damos_quota_goal.py       |  3 ++
 .../selftests/damon/damos_tried_regions.py    |  3 ++
 .../damon/sysfs_no_op_commit_break.py         | 35 ++++++++++---------
 ...sysfs_update_schemes_tried_regions_hang.py |  3 ++
 ...te_schemes_tried_regions_wss_estimation.py |  3 ++
 11 files changed, 60 insertions(+), 24 deletions(-)


base-commit: d1153a22117b5c6171bdf24d32b7f6c314887d23
-- 
2.47.3
