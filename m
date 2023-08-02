Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92276D51F
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400B5C433C8;
	Wed,  2 Aug 2023 21:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691012596;
	bh=QBEuiRTbe28FwTJFyn0gDDELntZEEA9zFJZItYOJvcw=;
	h=From:To:Cc:Subject:Date:From;
	b=FKYuhgFDuS/e5nbYCnIMw34QvAdrdGGRcfjrAK/XBtebMhBW+RzUXodidWe9sRR4h
	 zEGiRMPUAvCDINdU91+Xh5lbQ5JV5Nn4L6dFQc460WmEuf5yJjTKvoJz4lXNWVj1Vq
	 Fr6XytvI/Yjrtp11SCUK7KLB89U8l0Vo2ZTbGjKokFLlS/5HQVVc1v7EkROSLjD0kv
	 RNlcZEJRPbHAR6qOe08UpWBBEex44zs8y/tx4yxtuSTHHZGIFoKVDHy+cIiJA6wNv3
	 B0QbSi4mbg9jgbX0nV0v4WW2BCA6aHWBiZiEEnlLzkdLZ82+RAG9SQrb7l42AsU71c
	 fyWpzYI7uwBnA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH 00/13] Extedn DAMOS filters for address ranges and DAMON monitoring targets
Date: Wed,  2 Aug 2023 21:42:59 +0000
Message-Id: <20230802214312.110532-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from RFC[1]
- Rebase on latest mm-unstable
- Add base-commit

----

There are use cases that need to apply DAMOS schemes to specific address
ranges or DAMON monitoring targets.  NUMA nodes in the physical address
space, special memory objects in the virtual address space, and
monitoring target specific efficient monitoring results snapshot
retrieval could be examples of such use cases.  This patchset extends
DAMOS filters feature for such cases, by implementing two more filter
types, namely address ranges and DAMON monitoring types.

Patches sequence
----------------

The first seven patches are for the address ranges based DAMOS filter.
The first patch implements the filter feature and expose it via DAMON
kernel API.  The second patch further expose the feature to users via
DAMON sysfs interface.  The third and fourth patches implement unit
tests and selftests for the feature.  Three patches (fifth to seventh)
updating the documents follow.

The following six patches are for the DAMON monitoring target based
DAMOS filter.  The eighth patch implements the feature in the core layer
and expose it via DAMON's kernel API.  The ninth patch further expose it
to users via DAMON sysfs interface.  Tenth patch add a selftest, and two
patches (eleventh and twelfth) update documents.

[1] https://lore.kernel.org/damon/20230728203444.70703-1-sj@kernel.org/

SeongJae Park (13):
  mm/damon/core: introduce address range type damos filter
  mm/damon/sysfs-schemes: support address range type DAMOS filter
  mm/damon/core-test: add a unit test for __damos_filter_out()
  selftests/damon/sysfs: test address range damos filter
  Docs/mm/damon/design: update for address range filters
  Docs/ABI/damon: update for address range DAMOS filter
  Docs/admin-guide/mm/damon/usage: update for address range type DAMOS
    filter
  mm/damon/core: implement target type damos filter
  mm/damon/sysfs-schemes: support target damos filter
  selftests/damon/sysfs: test damon_target filter
  Docs/mm/damon/design: update for DAMON monitoring target type DAMOS
    filter
  Docs/ABI/damon: update for DAMON monitoring target type DAMOS filter
  Docs/admin-guide/mm/damon/usage: update for DAMON monitoring target
    type DAMOS filter

 .../ABI/testing/sysfs-kernel-mm-damon         | 27 +++++-
 Documentation/admin-guide/mm/damon/usage.rst  | 34 +++++---
 Documentation/mm/damon/design.rst             | 24 ++++--
 include/linux/damon.h                         | 28 +++++--
 mm/damon/core-test.h                          | 61 ++++++++++++++
 mm/damon/core.c                               | 62 ++++++++++++++
 mm/damon/sysfs-schemes.c                      | 83 +++++++++++++++++++
 tools/testing/selftests/damon/sysfs.sh        |  5 ++
 8 files changed, 299 insertions(+), 25 deletions(-)


base-commit: 32f9db36a0031f99629b5910d795b3f13f284472
-- 
2.25.1

