Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1276101FC
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19D4C433C8;
	Wed,  2 Aug 2023 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691011947;
	bh=/ftIGNZIuawFka3qmkPFpRU27GdmRegiQSCJekF9zMg=;
	h=From:To:Cc:Subject:Date:From;
	b=SMs6Q6ZLjcKQ70/cbYrqn+cDVQOadSajdkI3plnyvICz2+rhNp9AToICIqXEdaQqK
	 78gtgnaAfsbCdredfTwNdYSWzOrOLcVIxF2mZkwysEyL9WwatL6omtiFREvOjpz1Wm
	 MT+M+JbOT2ScvuHnKGualv/DlISwYU1ziCMxwGHoY91NAvrHMUITc2GnKzIePTGc7b
	 p9Rrh6GXcDrHtJu4EEDtxRPz38MtvltU9qlsBsQSglAIFVgBYOhp1WM+d4XJk64DTs
	 qepBo+1WuZ2C5aXpPXL00t0CeR6r/C6meqWHbggyS81NMgMHq2G7g+AeyB0Vv7TIPq
	 wgXAXWG6hPWkw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/5] mm/damon/sysfs-schemes: implement DAMOS tried total bytes file
Date: Wed,  2 Aug 2023 21:32:16 +0000
Message-Id: <20230802213222.109841-1-sj@kernel.org>
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

[1] https://lore.kernel.org/damon/20230728201817.70602-1-sj@kernel.org/

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


base-commit: a57d8094e1946e9dbdba0dddf0e10f9f4dceae0d
-- 
2.25.1

