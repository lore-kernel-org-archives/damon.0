Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534230;
	b=vbp566v2FqV7wD/KWSTJhRZrl3ofP7br96AV3eSgSY+APTZ7VncFbMb2m4lCDaOCl8vT
	 mdgyRWMatVT3G5ibRBnKdJe68QcwR8s1O281cZBB5lLgxOAYoXEWK00p7Cb6pIan+LU29
	 Mv5Uop5LZtEwbgrvim2MY7DFz3VAvDbiQnlwLliQOn+VGIU2Tl97XhfiiBQtxhGba8lZV
	 fcE0Nt3Ayd/uwFMsmpk1xE6q4WT4KkGsf124Jkl2nxu9IE+g8Dh+abFPJq/HgWeYacym5
	 jvCqOnDkIbsUtxZLnIS0CX9ySXnS8Hw+BstwwGRUmEaL/nWQIK4fqnV04CENKNMnaiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DIDV2NuLNU9URutPUbTqr/fH+wYU5tnhotuywFh00ro=;
	b=2Pmn8kFHf8rpOYSTX+iugRcu/2RK/SGtpIwc6UQRxOBJOZfNZ8AxXpNfKY4BjBvlXTJr
	 stkKJnNamoHMOUk+YrGRL6x6TbAYESVy6m/Ot7ZuBiIyLJt2sNJRbKent9vbcYLkXAARi
	 WDniHdbcDcOdGbW3DiR/BnAZKl3SGEt9QHe2EQrkYEJkYdD4YTNrcEnukRID6qa2ox31U
	 Iq0YxJYhe5VuW4PyM6FUEhrjJCbVYMxOoW6TyiUKl33R28Wdirn5JlcfDOdhwOuQY2zw9
	 EKHM/Y4p+NoBF5PWauHs2AmO8NNGQ5D231FDffsCIROWXZ0XV6YVVWN1Ky9KX+uv1bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6oNJZB6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544D606A32C;
	Tue, 24 Nov 2026 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6oNJZB6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381151F000E0;
	Tue, 24 Nov 2026 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534229;
	bh=DIDV2NuLNU9URutPUbTqr/fH+wYU5tnhotuywFh00ro=;
	h=From:To:Cc:Subject:Date;
	b=Q6oNJZB6U7VElNu+N3//UjOfVMkguuC8Hslg7dqk0nXMHbSCUsY37asAo2n5/gMBc
	 xMW5QXfvxGtAB2gpJh/ahyFb+HNU0YIZRV/mOpHPCN4Zf+SUwBYSW3d50VuzYzWXqT
	 EkImSxO9p7KC/nLMgcbC+1FdZbBg93JkLGRLaU0mhtCYWhrYBxMjD9Ey/iu0kE0Ose
	 jc6ssCjLlI7OqdWA735y544BhZb8sxFQKZPG00zJZYsAJG3LROulLT+0ev3gV+t5do
	 KBIJgD3OeoXn/m3YeoqulnjVv8Unj55QRA7D9/27yT9YH91V1z+jGS7jxNEhHeCkLq
	 g7IQZEB5CxO2Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon: improve efficiency (paddr, core), fix a selftest, add a kunit
Date: Tue, 24 Nov 2026 07:30:16 -0800
Message-ID: <20261124153021.90142-1-sj@kernel.org>
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

Improve efficiency of DAMOS_PAGEOUT in paddr and apply_probes() in core
by skipping unnecessary operations, via patches 1 and 2 from Aveline
Noir.  Fix a selftest for a false positive failure, via patch 3 from
Aveline Noir.  Add a kunit test for damon_call(), via patch 4 from
Sailesh Nandanavanam.

This is a batched reposting of separately posted and reviewed patches
for being merged into the mm.git.  Refer to changelog on each patch for
changes that were made before this reposting.

Aveline Noir (3):
  mm/damon/paddr: skip non-LRU folios as a whole in pageout
  mm/damon/core: skip apply_probes() when no probes are installed
  selftests/damon/damos_quota: skip the last sample when counting
    exceeds

Sailesh Nandanavanam (1):
  mm/damon/tests/core-kunit: add test for damon_call()

 mm/damon/core.c                              |  2 +-
 mm/damon/paddr.c                             |  4 +++-
 mm/damon/tests/core-kunit.h                  | 22 ++++++++++++++++++++
 tools/testing/selftests/damon/damos_quota.py |  7 ++++---
 4 files changed, 30 insertions(+), 5 deletions(-)


base-commit: c2b9a116bd15d6afa6c3d032e97136fc67f06970
-- 
2.47.3
