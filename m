Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46D13AC6
	for <damon@lists.linux.dev>; Sun, 22 Oct 2023 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr2+dXiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A11FC433C8;
	Sun, 22 Oct 2023 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698008860;
	bh=5ZgrkUlzCX47pRqWIhyU/veHGqYnGCkei+KNQLGqf1A=;
	h=From:To:Cc:Subject:Date:From;
	b=Mr2+dXiJPkTQamZC9s42dpr+F9W0/gxa5/gu5u+m66R8FYIBTu1+AJbCM7duHuFnV
	 3wskyjxpue0Cbn0GZW2V/05/NCIVgiaAzmfVSD1FpZae9HpvNdmj4rSL1u6iD383OY
	 HAOGHljzTiXsfZ3c9WqoZKRhR20LSG6+PmC/dkp01D3CnjTnnJCpGa4WdmjDFWfaHe
	 uQcj1QvuBJ+k/kSaQmTV7H/F/W8CDV20wOCgNSog60fqpbeY8lgJ3oKq82Sznwbgo2
	 iXDj0VOAx9IfaMuGqZhgao0fXWepdy2vr6wDH0s6hp5q37mgSiAxNbTu/8jyOkpS/n
	 tKvX3/xb3NJrQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon/sysfs: fix unexpected targets adding bug
Date: Sun, 22 Oct 2023 21:07:32 +0000
Message-Id: <20231022210735.46409-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs code for online targets updating can result in adding more than
expected monigoring targets to the context.  It can result in unexpected amount
of memory consumption and monitoring overhead.  This patchset fixes the issue
(patch 1), and add a kunit test for avoiding similar bug of future (patch 2).

SeongJae Park (2):
  mm/damon/sysfs: remove requested targets when online-commit inputs
  mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()

 mm/damon/Kconfig      | 12 ++++++
 mm/damon/sysfs-test.h | 86 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs.c      | 52 ++++++--------------------
 3 files changed, 109 insertions(+), 41 deletions(-)
 create mode 100644 mm/damon/sysfs-test.h


base-commit: 9a969da6ffb9609f5fa8d0b7fdc6859c37a10335
-- 
2.34.1

