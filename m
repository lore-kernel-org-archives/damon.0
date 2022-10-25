Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A547748E
	for <damon@lists.linux.dev>; Tue, 25 Oct 2022 17:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ECCC433C1;
	Tue, 25 Oct 2022 17:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666719415;
	bh=HOB4aTLZQqyg6IBEsmWZTH1iutjsiAnfu+qigl+jZVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lazaNRn8EkkviKiw34mfcZGNhFWKifzw2xYqZxaJYj1c0h6Eljo+ghLlQlkk2LYm6
	 zpnt0+ppKGm3PMZG7/J76c2/qRfdJjk26XRkm4Hvxonpk5q/3h+NY+VA0mNXjAaShJ
	 +l+pIXxnUwFeTN5VSS2syen9t2NkfhJ9WcHWWlP3CSnrRY+xG0mOHLIrxV4E2bRDsM
	 SJoL7w/7aPxw1nIH6C/JVs+QtMiJiA+peoUiwjsjcRPk+hP7qtAzh0WZO81O4fXoAl
	 SJUr6tcSb7cGeKfyCpB25v+Dj6s6X9CsFj1yrVy234GoBdlGRqIN86pHiedxJIbYpY
	 gG4F7sxBS4eJg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon/reclaim,lru_sort: enable/disable synchronously
Date: Tue, 25 Oct 2022 17:36:46 +0000
Message-Id: <20221025173650.90624-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing a value to DAMON_RECLAIM and DAMON_LRU_SORT's 'enabled'
parameters turns on or off DAMON in an ansychronous way.  This means the
parameter cannot be used to read the current status of them.
'kdamond_pid' parameter should be used instead for the purpose.  The
documentation is easy to be read as it works in a synchronous way, so it
is a little bit confusing.  It also makes the user space tooling dirty.

There's no real reason to have the asynchronous behavior, though.
Simply make the parameter works synchronously, rather than updating the
document.

The first and second patches changes the behavior of the 'enabled'
parameter for DAMON_RECLAIM and adds a selftest for the changed
behavior, respectively.  Following two patches make the same changes for
DAMON_LRU_SORT.

SeongJae Park (4):
  mm/damon/reclaim: enable and disable synchronously
  selftests/damon: add tests for DAMON_RECLAIM's enabled parameter
  mm/damon/lru_sort: enable and disable synchronously
  selftests/damon: add tests for DAMON_LRU_SORT's enabled parameter

 mm/damon/lru_sort.c                       | 51 ++++++++++------------
 mm/damon/reclaim.c                        | 53 ++++++++++-------------
 tools/testing/selftests/damon/Makefile    |  1 +
 tools/testing/selftests/damon/lru_sort.sh | 41 ++++++++++++++++++
 tools/testing/selftests/damon/reclaim.sh  | 42 ++++++++++++++++++
 5 files changed, 129 insertions(+), 59 deletions(-)
 create mode 100755 tools/testing/selftests/damon/lru_sort.sh
 create mode 100755 tools/testing/selftests/damon/reclaim.sh

-- 
2.25.1

