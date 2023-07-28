Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27180EDC
	for <damon@lists.linux.dev>; Fri, 28 Jul 2023 20:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF109C433C7;
	Fri, 28 Jul 2023 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690575505;
	bh=UVBU1bmCqbHYSrEwhTG13CafVyks5FJvwzFQOQt5stM=;
	h=From:To:Cc:Subject:Date:From;
	b=KnJ8rmUNVoGFKcCNUKRwK89H2KXXAVLsepsFVQRa8iq4OoKzKnituu+rU0m/e7wJx
	 uAVd0NxyObI7bWeGNqmuwUCWqQFn0yUKUXbZR0gT9GqzYGwzjp6ETymgfGp/0bvNCX
	 nlqZUBhTP+tOhmS1RLPv11wBvEuvRUwwxbTtt74EoFFwojxtEu0HH614lcs2N1Lo67
	 eQBhLQdYv/PDCfocQBxT2XJfJ4o4fRRjONXROUjT0VkNfgFZ+UrEh57tkK4bwQFjxp
	 NNkpvhVBApP7A7T6MVluboFkz5FCrfcQBYYnIdKNcZCC/S809axL3QyaJ6pjL+oXJq
	 6pqz5f6ogfIlQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] mm/damon/sysfs: add a file for efficiently get total size of DAMOS tried regions
Date: Fri, 28 Jul 2023 20:18:12 +0000
Message-Id: <20230728201817.70602-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tried_regions directory of DAMON sysfs interface is useful for
retrieving monitoring results snapshot or DAMOS debugging.  However, for
common use case that need to monitor only the total size of the scheme
tried regions (e.g., monitoring working set size), the kernel overhead
for directory construction and user overhead for reading the content
could be high if the number of monitoring region is not small.  This
patchset implements DAMON sysfs files for efficient support of the use
case.

The first patch implements the sysfs file to reduce the user space
overhead, and the second patch implements a command for reducing the
kernel space overhead.

The third patch adds a selftest for the new file, and following two
patches update documents.

SeongJae Park (5):
  mm/damon/sysfs-schemes: implement DAMOS tried total bytes file
  mm/damon/sysfs: implement a command for updating only schemes tried
    total bytes
  selftests/damon/sysfs: test tried_regions/total_bytes file
  Docs/ABI/damon: update for tried_regions/total_bytes
  Docs/admin-guide/mm/damon/usage: update for tried_regions/total_bytes

 .../ABI/testing/sysfs-kernel-mm-damon         | 13 +++++-
 Documentation/admin-guide/mm/damon/usage.rst  | 42 ++++++++++++-------
 mm/damon/sysfs-common.h                       |  2 +-
 mm/damon/sysfs-schemes.c                      | 24 ++++++++++-
 mm/damon/sysfs.c                              | 26 +++++++++---
 tools/testing/selftests/damon/sysfs.sh        |  1 +
 6 files changed, 83 insertions(+), 25 deletions(-)

-- 
2.25.1

