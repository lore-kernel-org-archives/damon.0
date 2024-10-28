Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4ED200C81;
	Mon, 28 Oct 2024 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158270; cv=none; b=tIJ3NwF7w/uRmd0MeN8autcEjl5i5+SPiXUSYLbfrUwpEWYQxpuVGlC727eBgBSiMdjMX1EK20Lfyu6k7VtdLmA95ABUtlQXR5AynzAfduoxdIUsTH6IZc5jyXRfZkmw1ilB6fGo27iG3HyJ06diIkys/1oc9cRr3GsRFqxgfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158270; c=relaxed/simple;
	bh=LXvmRzX05dupx2R/ol4gf8N18g44uMKZvueRyAo+O7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVaX+JhpzZFZuWA0saG63Z770brduSGLyB8oQX2tkE+lB73wCam6Y3IXopKFraqvhkBR6fiiYmueE/lL9TWcy+yNHqKCcDoxAM21/hggGNHdx8ceenX9CbctJMgepEhGhDippxh4dsBF37Y9Nao2ZvEFHurKyStmCxKwMwGxhog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl9JEZq8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl9JEZq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83B6C4CEE4;
	Mon, 28 Oct 2024 23:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158270;
	bh=LXvmRzX05dupx2R/ol4gf8N18g44uMKZvueRyAo+O7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tl9JEZq8genpVpYgIfEAampWnoalM7E2kRfFjipYpMBWx6Pj7yoA73tBajfZNLRS0
	 jBPTTpNgn4Zq3zG+lbvyYF0fqbXDOYin2n2nF1UY3NdPRbmAjzAOyb5Y6eUiRSeJOW
	 luAcrTRJ2Uai9vC9PoxqJMkzw9eDSxH+3uedpVS6g1xVW5UkbuWKU/w9xTayStpq3q
	 LhFsSjrb4xMWq1fuvtKcSolx2mlHw84WbWK95I7zhED+3aPiByVtsQXK7nfkaB47wN
	 uKRNBCclbg1lnFPSZmJycYgOUhJfXWsDktg94BMaMIrVT5+PjT542wwpsc5+jjh80a
	 R/KUiGSPIwv4Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mm/damon/Kconfig: update DBGFS_KUNIT prompt copy for SYSFS_KUNIT
Date: Mon, 28 Oct 2024 16:30:57 -0700
Message-Id: <20241028233058.283381-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028233058.283381-1-sj@kernel.org>
References: <20241028233058.283381-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DAMON_SYSFS_KUNIT_TEST prompt is copied from that for DAMON
debugfs interface kunit tests, and not correctly updated.  Fix it.

Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 35b72f88983a..d0357f3e9372 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -60,7 +60,7 @@ config DAMON_SYSFS
 	  the interface for arbitrary data access monitoring.
 
 config DAMON_SYSFS_KUNIT_TEST
-	bool "Test for damon debugfs interface" if !KUNIT_ALL_TESTS
+	bool "Test for damon sysfs interface" if !KUNIT_ALL_TESTS
 	depends on DAMON_SYSFS && KUNIT=y
 	default KUNIT_ALL_TESTS
 	help
-- 
2.39.5

