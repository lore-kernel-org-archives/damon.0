Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97051E6DC5;
	Mon,  8 Sep 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362522; cv=none; b=SHAxUY2vnPuA227JdsVos7l6lmeaSkOZ8H4kYVWob5wdBnnD+jQjJzqA5PQbjrOg4Je7KTfL02ka3Ie2sKEPcX+wtqpyx+0In9MLlo4FSULZB87weGYhzhSFAHl2VM7+JdYD2h4OZftJ0NdeuqqdihGdM3AdHZO6sgLpRCF4bok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362522; c=relaxed/simple;
	bh=PsGl1+WwcckdRHMNuQl2e0MNEvzJOQisrq1GlKGfaCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E+jWlnOKN2ePpw1QBoWmqnZfsBy5/r3tUMCZOYISwMiBerDr7aPJGUCmqybQw3kXMK3pc9zd+K+EwPf6XXIUW0tm9JAd0cyTGysZPI+09zr6eQrBl7uMcnsL5pT1wYIrcAP7k3oQtTlxIoLkBfjhJ5KvP68lGuSVVFoNO0Qg+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSLrMLEQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSLrMLEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37191C4CEF1;
	Mon,  8 Sep 2025 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757362522;
	bh=PsGl1+WwcckdRHMNuQl2e0MNEvzJOQisrq1GlKGfaCU=;
	h=From:To:Cc:Subject:Date:From;
	b=QSLrMLEQ+Sff9ZhkGd2/EQvdi4s6SFcpSXumSej2vOAWR4wGofHWXVfKjPWm0DWkj
	 Y47b/kaJFKDsF2ckhjPrk7E7wSB0cEji1HsZnochJqgUgC2umdAPfq4rEOmQ/OZ1dL
	 RswLUl+4sUjnEpGVcKW4OSdGQgOwe2F170vR1t4LXzXXW99NnLhY+3hzL2mDP+AIWJ
	 gk4pi+38Cz0IUNoxVlwqGJZvm+0g+/xA28+Otx9BB1TdqIs/iMC9yf/iUsciInh803
	 jqfFeTn46g1xAs+1MQruh7x37TZqu3N903t2XoT8IxSCRK43A2Yrdf5S5GQ47C8iTm
	 EDCJ8POwRf/lQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/sysfs: fix refresh_ms control overwriting on multi-kdamonds usages
Date: Mon,  8 Sep 2025 13:15:11 -0700
Message-Id: <20250908201513.60802-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Automatic esssential DAMON/DAMOS status update feature of DAMON sysfs
interface (refresh_ms) is broken [1] for multiple DAMON contexts
(kdamonds) use case, since it uses a global single damon_call_control
object for all created DAMON contexts.  The fields of the object,
particularly the list field is over-written for the contexts and it
makes unexpected results including user-space hangup and kernel crashes
[2].  Fix it by extending damon_call_control for the use case and
updating the usage on DAMON sysfs interface to use per-context
dynamically allocated damon_call_control object.

[1] https://lore.kernel.org/20250904011738.930-1-yunjeong.mun@sk.com
[2] https://lore.kernel.org/20250905035411.39501-1-sj@kernel.org

SeongJae Park (2):
  mm/damon/core: introduce damon_call_control->dealloc_on_cancel
  mm/damon/sysfs: use dynamically allocated repeat mode
    damon_call_control

 include/linux/damon.h |  2 ++
 mm/damon/core.c       |  8 ++++++--
 mm/damon/sysfs.c      | 23 +++++++++++++++--------
 3 files changed, 23 insertions(+), 10 deletions(-)


base-commit: c6680f5947fa5ff95bc881f2c4e36443478c8829
-- 
2.39.5
