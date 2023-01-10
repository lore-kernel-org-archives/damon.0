Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BBA92B
	for <damon@lists.linux.dev>; Tue, 10 Jan 2023 19:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFDBC433EF;
	Tue, 10 Jan 2023 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673377444;
	bh=cMloBfgRXcPaivDxBGV45/PyJEpmffBJWfiRdIAMdCU=;
	h=From:To:Cc:Subject:Date:From;
	b=fys4UPeZcW4izhx0mZgQ1PCbzZt6jepaHXFAtoLEQs89oOmk2vLAVFtddnsKwxI4t
	 +AMfSBQZk/zCA2ti229JqsdbQ3nvnXrAIuXJE8gzw9iwWEkMuI+m6EaInONFuAszm6
	 UkkEQ4P4manxdf0QPiF9htrVPPqcQ9WS4oxfrRe5SBAoqMPKkM6Qgzqs2uLhtle5T3
	 ujGNazYNSpsSiR/EAXQ25c1y25/XsmGBlEgEJ0OUmHEQpw8Pm1jcEw/BoOBGuvfpAq
	 +rkxFPkQlWCF/FiF0+M6kh4OziuHTDkfsswT8liRrUrpaJb0sdFv7On+BHtfeDcSPm
	 eDxURokTs+u1A==
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
Subject: [PATCH 0/8] mm/damon: trivial fixups
Date: Tue, 10 Jan 2023 19:03:52 +0000
Message-Id: <20230110190400.119388-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains patches for trivial fixups of DAMON's
documentation, MAINTAINERS section, and selftests.

SeongJae Park (8):
  mm/damon/core: update kernel-doc comments for DAMOS action supports of
    each DAMON operations set
  mm/damon/core: update kernel-doc comments for DAMOS filters supports
    of each DAMON operations set
  Docs/mm/damon/index: mention DAMOS on the intro
  Docs/admin-guide/mm/damon/usage: update DAMOS actions/filters supports
    of each DAMON operations set
  Docs/mm/damon: add a maintainer-profile for DAMON
  MAINTAINERS/DAMON: link maintainer profile, git trees, and website
  selftests/damon/sysfs: hide expected write failures
  selftests/damon/debugfs_rm_non_contexts: hide expected write error
    messages

 Documentation/admin-guide/mm/damon/usage.rst  | 41 ++++++++----
 Documentation/mm/damon/index.rst              | 22 ++++---
 Documentation/mm/damon/maintainer-profile.rst | 62 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 include/linux/damon.h                         | 11 ++++
 .../damon/debugfs_rm_non_contexts.sh          |  2 +-
 tools/testing/selftests/damon/sysfs.sh        |  2 +-
 7 files changed, 122 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/mm/damon/maintainer-profile.rst

-- 
2.25.1

