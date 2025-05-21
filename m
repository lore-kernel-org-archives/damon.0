Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCDB22F384;
	Wed, 21 May 2025 04:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747801681; cv=none; b=lDQdgPrk6CKQaY8s0FF474R72ixPzA3BU3+FaSkg36Wy7DMy1nZUwdl7J5R19i06ihf2bUp0fmf+ae9acYfe7idsBIZYKvTMjXMGjp6UEi+MZBpQSFQIAqdobguXJPtUS5qUwJBblvWFVp0G4gDt/pz/C6yzogVBxQQgw1WPmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747801681; c=relaxed/simple;
	bh=gikuULGjj+izdU6OlPzJGvNFZzPyv7Zh2oaHSFLM5Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dD1XxtzlgGuO+XpzFEYE6fBIXsFJ+BDEUkwYSB59bwKTNaOs2yC8IAEpl7zu1YDBVEPe6C9DfoqAnF6HP76s8GSgC8XfCi5YpCpsCqscGWci59/E2QPZazwGBXlXpljWzSzPlUpWP5npqFfjQVyvGFUQU4jLlQ4Mzq9cxdGIDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2tDeaTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2tDeaTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F15C4CEE4;
	Wed, 21 May 2025 04:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747801681;
	bh=gikuULGjj+izdU6OlPzJGvNFZzPyv7Zh2oaHSFLM5Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2tDeaTBbl38PIGsebz0kMD8QPEiIRkaB6k96jtom5hn7INbomV2/VNJ+8LPD+4rc
	 QAK1ZRBphS2Lb7rrNZ0mEc+kRotXy/fVqOR0dbL6yaTrMjYCrAg9TrJ6YPXbjLHr6t
	 iYrDIbg7zNg3kXYO8zBcahVw+OoxqFabpNATRiKsGN0IIqjNh0DwweQ6zYxO9oQerM
	 osMrEK2w6Limcgw0EAY2VMyS/5FFcKLyFLSL1/WfCbRXTxPMVMSyhvF4BO8LLXwDuN
	 v7kCPr1R37dQeID7fzjcnNPEgdzTo7IQ5BOuKxWkMGEawmnO0ArvzGdV+STNIpOcrU
	 mUTEDWH58G69A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/Kconfig: set DAMON_{VADDR,PADDR,SYSFS} default to DAMON
Date: Tue, 20 May 2025 21:27:54 -0700
Message-Id: <20250521042755.39653-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521042755.39653-1-sj@kernel.org>
References: <20250521042755.39653-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_{VADDR,PADDR,SYSFS} are de-facto essential parts of DAMON for
normal usages.  Because those need to be enabled one by one, however,
and there are other test-purpose or non-essential configurations, it is
easy to be confused and make mistakes at setup.  Make the essential
configurations default to CONFIG_DAMON, so that those can be enabled by
default with a single change.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index c213cf8b5638..c93d0c56b963 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -28,6 +28,7 @@ config DAMON_VADDR
 	bool "Data access monitoring operations for virtual address spaces"
 	depends on DAMON && MMU
 	select PAGE_IDLE_FLAG
+	default DAMON
 	help
 	  This builds the default data access monitoring operations for DAMON
 	  that work for virtual address spaces.
@@ -36,6 +37,7 @@ config DAMON_PADDR
 	bool "Data access monitoring operations for the physical address space"
 	depends on DAMON && MMU
 	select PAGE_IDLE_FLAG
+	default DAMON
 	help
 	  This builds the default data access monitoring operations for DAMON
 	  that works for the physical address space.
@@ -55,6 +57,7 @@ config DAMON_VADDR_KUNIT_TEST
 config DAMON_SYSFS
 	bool "DAMON sysfs interface"
 	depends on DAMON && SYSFS
+	default DAMON
 	help
 	  This builds the sysfs interface for DAMON.  The user space can use
 	  the interface for arbitrary data access monitoring.
-- 
2.39.5
