Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA12D94A7;
	Sun,  1 Mar 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387011; cv=none; b=inEGkv0K35OEKo/5tRZLpBneGKTTq1SeZ2lpgsA8hOGJ2fJ9tYuNHcP1JxppeKyYuyx8E0LJdagVaV3HzyxZ2LFWmzOUPS/f+05uq0NEKo809Gy1ChmHKO8TfC3sDHgvKiOlJUGNMtGrOHAH5g0eVnzrtULjC8kUuzMHRrV2MHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387011; c=relaxed/simple;
	bh=mPwVqtgK5FXF6rtx4eARff1DBvg92YGlSMSnRp8dVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN/l5BobgqkBm2OHlBk+f56dVBK3Fy947ceiyrUTliVTu35O9vaEbKdjls4QyHUyU+ZRwj4Zpo6120sCM2dMXK02E8ZDNNzNkGHIhotubJK/aeZ8ckqEL+8af0t7NIsrBHlHDTwv4HEHFwlI2VA7dQpQXgW+si3EDekzyEOvGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awD+wgeY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awD+wgeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EABC2BCAF;
	Sun,  1 Mar 2026 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387011;
	bh=mPwVqtgK5FXF6rtx4eARff1DBvg92YGlSMSnRp8dVoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awD+wgeY2fdQRhwsH8LJvXvq7v/Lq9nU+S08wkPrKt6smF7TQafJiLWcLfBmKWjPu
	 AVLaVLzmq3IXbsfioes75WoiTrIWkdkkT94bsal5ZqejbVdK/WB7kWDL+ykLOsXvH/
	 r4QXI5wQCF9fwfYDqBLAPxwKJIwjbpYEcgdQegVxGbmE/a19c6xGggJ5OdxiodE+VN
	 zaWc5qn934v35fVidvaoQT7TBVFFJXrJAST2QeNB6oPiV8Z5XbkOsc6sztFwNECyzg
	 T1OgDj9LoMyInlvSFG3QI42Clv83YPUs+XDnbZdkG0QwQ6Ek07LLhY23nKVAAdZXm6
	 uYw+M6XFuBCjw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/10] mm/damon: add CONFIG_DAMON_DEBUG_SANITY
Date: Sun,  1 Mar 2026 09:43:16 -0800
Message-ID: <20260301174327.76849-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301174327.76849-1-sj@kernel.org>
References: <20260301174327.76849-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new build config that will enable additional DAMON sanity checks.
It is recommended to be enabled on only development and test setups,
since it can impose additional overhead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 8c868f7035fce..34631a44cdecb 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -12,6 +12,17 @@ config DAMON
 	  See https://www.kernel.org/doc/html/latest/mm/damon/index.html for
 	  more information.
 
+config DAMON_DEBUG_SANITY
+	bool "Check sanity of DAMON code"
+	depends on DAMON
+	help
+	  This enables additional DAMON debugging-purpose sanity checks in
+	  DAMON code.  This can be useful for finding bugs, but impose
+	  additional overhead.  This is therefore recommended to be enabled on
+	  only development and test setups.
+
+	  If unsure, say N.
+
 config DAMON_KUNIT_TEST
 	bool "Test for damon" if !KUNIT_ALL_TESTS
 	depends on DAMON && KUNIT=y
-- 
2.47.3
