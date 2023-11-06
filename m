Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FD29D07
	for <damon@lists.linux.dev>; Mon,  6 Nov 2023 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf599/1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54337C433C7;
	Mon,  6 Nov 2023 23:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699313649;
	bh=PbpR9uAMS4z983F6X6mqfiz2aQZYHIrus56jewv3Dm0=;
	h=From:To:Cc:Subject:Date:From;
	b=Zf599/1WIA2jNOUN4kR6gOh3lwFhhyDXC4RuryzQnC5JBIIHZIzvtul8AWm0Cj3AP
	 DRTXjtzUf05LqPIg2tLtbNDn5BzCTLwS7WGB8flQ2zX2OBsp6ZNSAIqULowMqed27J
	 CAoHT1Pzg6ONtcJLuS2YPea+Eq/vqqIeh6VIyxxja8Feu0ezVbgdOzCMrXQND5LZAi
	 0wIqTG5GMQP7N68wqCP3uZlmKxSYyxbWw6k2Ly4LDD7L7AwhLXWDSvSefmSw23Efa7
	 E8YRMS7WI+nFrqyD4iqio5wDm049e6aoKFO99iOvGpYK1QCT45QIqL0W0i026aHu9C
	 qQ/b2gV0R/fhA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm/damon/sysfs: fix unhandled return values
Date: Mon,  6 Nov 2023 23:34:05 +0000
Message-Id: <20231106233408.51159-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of DAMON sysfs interface code is not handling return values from
some functions.  As a result, confusing user input handling or
NULL-dereference is possible.  Check those properly.

Please note that these patches are not cleanly applicable on mm-unstable
since mm-unstable has dropped the mainline-merged patches and rebased on
v6.6, while some DAMON patches that these patches are depend on are
merged in the mainline after v6.6.  I confirmed these patches can
cleanly applied on latest mainline, or mm-stable-2023-11-01-14-33.

SeongJae Park (3):
  mm/damon/sysfs: check error from damon_sysfs_update_target()
  mm/damon/sysfs-schemes: handle tried regions sysfs directory
    allocation failure
  mm/damon/sysfs-schemes: handle tried region directory allocation
    failure

 mm/damon/sysfs-schemes.c | 5 +++++
 mm/damon/sysfs.c         | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)


base-commit: 3496e8e0a1eeabb738105c09e575495fa78914bb
-- 
2.34.1

