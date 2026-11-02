Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632085;
	b=k1Y2KnhBMK1mjDzn6bBk1s1OEbc138PsCncgVrvlB2pd6Z0xOAP9xamlIikSISVBZwnN
	 8W0HF7tWlEYvENiO9fwV+WkCbEtHbQaAFr3JlPELfV7prCHjyz/F6x97xYkTASzpFPVL4
	 xx8SwfJ0LjBh1708iyuS7a/zFzwDmTowH0+7RAAasjC1TVkiqhILFUDE++Aq/Sv5Hzw8j
	 njr50w+Fo3+neZvbLLg/4EGFDQs9LBKhkhUfiwci6fc2U4pKUEd36ir0xFy4jD+K/2WWA
	 ANwuXJaPkKsMtZvCQz4c+3OwHkKQIXYa92pgirCdEHvjLeH6C63XWyzovHUC87oOaiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632085;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JxyoskBqgIU4C3S6z00PA0qtXiqTefs4N3Gqd+UIqZ4=;
	b=rvY4ff2kBCW5/OFfKQr9za/SfXw5G9p8JhQksVistWs7/b6ILvn9TIq/u+gspy5sw1HS
	 BdviFfzHnz+lyndVF9domnLjgdun4Dc/HA69Zb4cioD0Lqa01QfkCWTU45fydtZGjed6A
	 c0wsyVX8J718FmK9h26P3wJJFcKoUqmGrRhHRau9hSrqZUCbyQGH1GOpeUZxt3nxn5DfV
	 C7L6xo2N7tQ8F98/glG7gUmgOHnN4SgKcnJRyH8gwFy1UnMuJ3TCwAwu4kt9hXny5ho9A
	 t7RduF0bmrfrYNG+3Z5FBy0OnYOohrxo9XXo73Zfzniv8PDrZrYxipUIk7WZI+iG63A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAUsdV0u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7512A60A0FD8;
	Mon,  2 Nov 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAUsdV0u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C891F00A18;
	Mon,  2 Nov 2026 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632085;
	bh=JxyoskBqgIU4C3S6z00PA0qtXiqTefs4N3Gqd+UIqZ4=;
	h=From:To:Cc:Subject:Date;
	b=TAUsdV0u8seyh7pjWBeSAGDE1Vm8Nqk+X9ngcNdoD9CfEsvVHZ7JUezduD/Bx88pS
	 k20QjJvr6/KpsmeuGJpGAFNBolv7BpKFlRtMFBCwid5JC94EcEsWln3rx8aaMaivps
	 LT3L8Of7wYnzm6aPQned5HfDRWfykNffIhGCLzRc+hWortfdU5JhWSbmiMrGhqTD9b
	 Zfen4voSxdmhJ5lzbK9VinNXFDWxvHVgg3EEZB2OY6zcYy13BsuTptGax/xGgwh0hY
	 OPyk79aQGQDhVSv1ofaliAGj8bof3DDN687KgAwFoxm8Jyji2KAXRIAhyx6z9/spxE
	 kvpT04/k9s/ZQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Fernand Sieber <sieberf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Leonard Foerster <foersleo@amazon.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shubhang Kaushik <sh@gentwo.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/9] mm/damon: various fixes and cleanup of code, test, and docs
Date: Mon,  2 Nov 2026 07:07:47 -0800
Message-ID: <20261102150757.93058-1-sj@kernel.org>
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

Fix and cleanup various parts of DAMON including its code, test, and
documentation.

Optimize the efficiency and monitoring accuracy of DAMON code with the
first five patches.  Remove unnecessary initializations in
damon_new_ctx() with patch 1 from Adrian Huang (Lenovo).  Align MMU
notifier ranges when clearing PTE/PMD young bits with patches 2 and 3
from Shubhang Kaushik (Ampere) and Aveline Noir.  Avoid DAMON_STAT idle
time percentile overflow on 32-bit architectures, and optimize out
unnecessary folio LRU isolation from DAMOS_MIGRATE action, with
patches 4 and 5 from Aveline Noir, respectively.

Fix and cleanup tests and documents with remaining four patches.  Let
sysfs.py test does not hang when it is executed under interactive
terminal with patch 6 from Jaeyeong Lee.  Fix typos, grammatical errors
and styles in DAMON_RECLAIM comments and DAMON_LRU_SORT user documents
with patches 7 and 8 from Manuel.  Finally, document how to disable
watermarks of DAMON_RECLAIM with patch 9 from Jinjie Ruan.

Reviewer notes.  This is a collection of DAMON patches that are posted
by individual contributors and resposted as an mm.git merge request.
Each patch has its own changelog.

Adrian Huang (Lenovo) (1):
  mm/damon/core: remove unnecessary zero-initialization in
    damon_new_ctx()

Aveline Noir (3):
  mm/damon/ops-common: align MMU notifier range when clearing PMD young
    bit
  mm/damon/stat: avoid 32-bit overflow in idle percentiles
  mm/damon/{p,v}addr: skip folios already on the migration target node

Jaeyeon Lee (1):
  selftests/damon/sysfs.py: stop obsolete_target shells hanging the test

Jinjie Ruan (1):
  Docs/admin-guide/mm/damon/reclaim: document how to disable watermarks

Manuel Ebner (2):
  mm/damon/reclaim: fix typo and grammar
  Docs/admin-guide/mm/damon/lru_sort: fix grammar and stlye

Shubhang Kaushik (Ampere) (1):
  mm/damon/ops-common: align MMU notifier range when clearing PTE young
    bit

 .../admin-guide/mm/damon/lru_sort.rst         | 61 +++++++++----------
 .../admin-guide/mm/damon/reclaim.rst          |  4 ++
 mm/damon/core.c                               |  5 --
 mm/damon/ops-common.c                         |  7 ++-
 mm/damon/paddr.c                              |  2 +
 mm/damon/reclaim.c                            | 14 ++---
 mm/damon/stat.c                               |  5 +-
 mm/damon/vaddr.c                              | 18 +++---
 tools/testing/selftests/damon/sysfs.py        | 12 ++--
 9 files changed, 67 insertions(+), 61 deletions(-)


base-commit: 18e5bc25101d458c94de6ccb0f7df5d8ec000fb7
-- 
2.47.3
