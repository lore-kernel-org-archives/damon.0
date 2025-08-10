Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784E1E515
	for <damon@lists.linux.dev>; Sun, 10 Aug 2025 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754853957; cv=none; b=avJFY80BJtB1mfgHpDDnRBJ1JfQDQ3MK8SwYA4x2+H2qXbAS7D/EEleDMuWQcthd5CsfhWvklktlW24kWb+i/K/Tj6bDOYRt9BrCkenpUrQajSswFbQ8QlFarcasW+WMJcPJ45mjj0qsfBXFgGuCVCTFqoDoZ5Iaxyt3IWewKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754853957; c=relaxed/simple;
	bh=WyO8PtQO+3C+ZYPrF+e4+P/lETANCz26Qlp1GXs3gLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r0f5D/x1cbo05ApVGh6E+x3p6WysS95VnhDKHk17QkIienXnJqdTjupnmM2vgYd+ZADXqDW5WE7apDuuMhWaO6zUukcxl5e3DB+oqabWWBX4iEZJdegD3H4r864lmuXR44HiHl2ure6UDVdxu1dt/LcHXHLUOO80PzhuR9R1+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxUn9Yoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxUn9Yoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAAFC4CEF1;
	Sun, 10 Aug 2025 19:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754853956;
	bh=WyO8PtQO+3C+ZYPrF+e4+P/lETANCz26Qlp1GXs3gLk=;
	h=From:To:Cc:Subject:Date:From;
	b=uxUn9Yoag0uQmngugzY8heUDdXJBQMyMWguEvZk9gszM5AtoVS+y0oL+HbQ4/muuR
	 Pg7scW8udvbYhVhnK+3ZGYmDb806r/ZJKHJARJ1B40yQ6+VociJGe6n9fu5SX7U+63
	 IA+YoqnbBBJd0SROziim8ay5KbxWpcCTTMM1WnHEcxjO5yEQyCzo1xCf+W0IgrHfdx
	 NSSiMR1YXFTdBpIp63FPJJRXMf6323/Nm6ABuOTO2XgcU8xTlFXuqdh2/PKwirzDgM
	 49BhiUbqus2eqDET0C2W6ZbqoJsxtNtPh9XdyZimG1CCw1zQshAVl6K4fMwdgFRNM6
	 PSb4p27OEDAtA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	sj@kernel.org,
	kernel-team@meta.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v2] docs/mm/damon/design: fix typo: s/sz_trtied/sz_tried/
Date: Sun, 10 Aug 2025 12:25:47 -0700
Message-ID: <20250729144414.31958-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20250810192547.EBiQB9ySC4qrfPKDm3ZAnpZjcspLULWSW5_d6tRICbk@z>

From: Sang-Heon Jeon <ekffu200098@gmail.com>

There are some typo in statistics section of DAMON design docs
- sz_trtied -> sz_tried

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lkml.kernel.org/r/20250729144414.31958-1-ekffu200098@gmail.com)
- update the subject to be more specific

 Documentation/mm/damon/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 03f8137256f5..2f6ba5c7f4c7 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -689,7 +689,7 @@ DAMOS accounts below statistics for each scheme, from the beginning of the
 scheme's execution.
 
 - ``nr_tried``: Total number of regions that the scheme is tried to be applied.
-- ``sz_trtied``: Total size of regions that the scheme is tried to be applied.
+- ``sz_tried``: Total size of regions that the scheme is tried to be applied.
 - ``sz_ops_filter_passed``: Total bytes that passed operations set
   layer-handled DAMOS filters.
 - ``nr_applied``: Total number of regions that the scheme is applied.
-- 
2.43.0

