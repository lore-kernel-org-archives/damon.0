Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC016F839;
	Mon,  1 Jul 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862032; cv=none; b=q8u57kTCL2+Yd+b4K7Q4h9+VnUcQix23C/gBiaBwIv+vqVksdYLSgOVMDzhglBjk/Sibc8ZTR49xBaSvALjc4tkyLMdlsEafa2WzuBMpdfcBTj6MZiPTUQ6Ta3BD5E5b7ppsZX5o+Stb4lXg74Xeey6NkrE4F2Wv5Nqt8jwZyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862032; c=relaxed/simple;
	bh=QYtOsoHg40YEBAD6vy86pU8pE6QF4gmCEDYVeoDEr90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FDE5M9OeJS8gpkY6JCIj6dq4L7lSSmqUDob6AhTFHp5V9a/t98bqaQMAsvnWIodnqjWvIOVFkrapwbRdmRhorZ+bf3kDWnQsOPreiOBTMAVglvNxmKOFdYmAVMae4KfgHo1QaLvDapqE+MF/TA6zoXCTpxjAsVEkcUkV54+XJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIXekkpC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIXekkpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E2AC4AF0A;
	Mon,  1 Jul 2024 19:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862032;
	bh=QYtOsoHg40YEBAD6vy86pU8pE6QF4gmCEDYVeoDEr90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIXekkpClCpeAyF/agJ4pi4kJcklJISQ3HTbSRrR/nQKlhbKVw33QHjyTWCFKL/rg
	 joC6RuKMtx5R24WQe3yhGAFj4TLqxXJK7uwQLDlz+wNNLY+BJ94OaK3oW74hWjnN4f
	 BByybX1lYAV7PayI5RTe6Uppm1AOLrMiG7mzczUqLIzioPz1RldLSV99Bl7Zu+A2FA
	 DTaiOCPOwMPG1KHskLGBjubQ9V+gA85MR/dBwjvCWYWKpK404Jx5F5j0LiMYnHQ8bs
	 7nEKrTL8L14bVCL8/h0csDnA7vcu3N05hxdcqWOv9dfk4EJPUn8po6Umh4r1LO4Tce
	 3T62d3lH3fwcA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] Docs/mm/damon/design: fix two typos
Date: Mon,  1 Jul 2024 12:26:58 -0700
Message-Id: <20240701192706.51415-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701192706.51415-1-sj@kernel.org>
References: <20240701192706.51415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two typos.  The first one is just a simple typo:
s/accurach/accuracy/

The second one is made by the author being out of their mind.  'Region
Based Sampling' section of the doc is mistakenly calling the access
frequency counter of region as 'nr_regions'.  Fix it with the correct
name, 'nr_accesses'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 3f12c884eb3a..6beb245cbb62 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -25,7 +25,7 @@ DAMON subsystem is configured with three layers including
 - Operations Set: Implements fundamental operations for DAMON that depends on
   the given monitoring target address-space and available set of
   software/hardware primitives,
-- Core: Implements core logics including monitoring overhead/accurach control
+- Core: Implements core logics including monitoring overhead/accuracy control
   and access-aware system operations on top of the operations set layer, and
 - Modules: Implements kernel modules for various purposes that provides
   interfaces for the user space, on top of the core layer.
@@ -192,7 +192,7 @@ one page in the region is required to be checked.  Thus, for each ``sampling
 interval``, DAMON randomly picks one page in each region, waits for one
 ``sampling interval``, checks whether the page is accessed meanwhile, and
 increases the access frequency counter of the region if so.  The counter is
-called ``nr_regions`` of the region.  Therefore, the monitoring overhead is
+called ``nr_accesses`` of the region.  Therefore, the monitoring overhead is
 controllable by setting the number of regions.  DAMON allows users to set the
 minimum and the maximum number of regions for the trade-off.
 
-- 
2.39.2

