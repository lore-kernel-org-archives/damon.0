Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A1612F
	for <damon@lists.linux.dev>; Fri,  9 Sep 2022 20:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CBAC433C1;
	Fri,  9 Sep 2022 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662755344;
	bh=q2B2bEaPY32bxTmDNGxPgX/Wuh5TeAA8MV5nuqGrMY0=;
	h=From:To:Cc:Subject:Date:From;
	b=JOWwHZQRdqyALR69+cnV85S7ykdL4p0wVWzxrBTBq2FA7dWXUKUkEBYH0oNiXuTNk
	 N1dSyZ3C1hSybrC5qAeuhTeVcaJu2f3YdwkT0Ih+1HnplsqaP034mNihuILp2qBRbV
	 pMg+fDB4NG9qn3ppAGbeie/zRVGli3HuzNEWDgMcfnXdLMbCZ3VtB1X4emL8Kya/Y9
	 LefLdbVRjEoRvwLAwM6mcejPt8YEejNCybn/YbY2vS9uh4VVktYssprBhvbsMRGhFT
	 EaFqQbRVuUFI8AbfPcGL9uWO8RHDDf3w57tpXLveg7WVuXwaY5XvNPzt+4nrRn1jTT
	 LiwIiJkqv7ugw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] mm/damon: minor fixes and cleanups
Date: Fri,  9 Sep 2022 20:28:54 +0000
Message-Id: <20220909202901.57977-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains minor fixes and cleanups for DAMON including

- selftest for a bug we found before (Patch 1), 
- fix of region holes in vaddr corner case and a kunit test for it
  (Patches 2 and 3), and
- documents/Kconfig updates for title wordsmithing (Patch 4) and more
  aggressive DAMON debugfs interface deprecation announcement
  (Patches 5-7).

SeongJae Park (7):
  selftest/damon: add a test for duplicate context dirs creation
  mm/damon/core: avoid holes in newly set monitoring target ranges
  mm/damon/core-test: test damon_set_regions
  Docs/admin-guide/mm/damon: rename the title of the document
  mm/damon/Kconfig: Notify debugfs deprecation plan
  Docs/DAMON/start: mention the dependency as sysfs instead of debugfs
  Docs/admin-guide/mm/damon/usage: note DAMON debugfs interface
    deprecation plan

 Documentation/admin-guide/mm/damon/index.rst  |  6 ++---
 Documentation/admin-guide/mm/damon/start.rst  | 13 +++------
 Documentation/admin-guide/mm/damon/usage.rst  |  5 ++++
 mm/damon/Kconfig                              |  3 +++
 mm/damon/core-test.h                          | 23 ++++++++++++++++
 mm/damon/core.c                               | 24 +++++++++++++++++
 tools/testing/selftests/damon/Makefile        |  1 +
 .../debugfs_duplicate_context_creation.sh     | 27 +++++++++++++++++++
 8 files changed, 89 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh

-- 
2.25.1

