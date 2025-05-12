Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085082989B0;
	Mon, 12 May 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074442; cv=none; b=Ck6Aj4VkKy8uml6N/UvQEOdd1fTbC8jFfurjb1APYAevGsnlni9WgeuJwvKDSCv3hq2AKqZ6hmv2QyLw544OEyCTI2sbeoz0604MeCIjTpFGd7zQpvTrx9RQ1TpVNRrulNlwBUN01pdrnL4+DlsA2VbPxfYz6LxGVmExlrH4fqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074442; c=relaxed/simple;
	bh=2Xzrax3Bv2jB/dQYzj+XSzLPEbT+pzZZ0yeFVr03EIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pc1KQL6n5P5wUZVhOGOeIdE2U+acbvHCE2IKZWMj3QfC1EjtoJKAFO1lI7sJbq0Cb/3Sz0A75fT5/xFC5+0OCNnMqxKrC1iQMYevJgf04X0EJ7aS4z3e/kHLDTM3ZGc4Ok8h+VY9pT1U60Blfxm8BAjuXvUvZXphAg/oHNky1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwRqTvNO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwRqTvNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4738CC4CEE7;
	Mon, 12 May 2025 18:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747074441;
	bh=2Xzrax3Bv2jB/dQYzj+XSzLPEbT+pzZZ0yeFVr03EIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwRqTvNOFDkpFdjOH9eq2nUeXBYHF+ai8XBHGtGcbvcCpcYXQ6TNefOflFAHF9F0z
	 FGFSnQXV0NO/NLsnd7EG1Z00xyD8A+fRsmr3kwBg3LZrR0a33IhJ5GdUULIUE+HLNl
	 Hz1vErvd/R6TnMvnZ1ScpHSwxHQl4bu1UtzQxgP8EV/uF+xLvETdrx0XJ630wbFJiS
	 10oUBTh39le2r39u81DnLGdGaRhni6Fy4w0b7r5VYbeOApNH3pG4zfflk8aiEruhkD
	 xo5nbrhksyZyttGG4IS9opimu09OpXkp0McigjBFlZZFi9GdtT23X7whppyCik7hLp
	 s/cIWcrDeitmg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm/damon/Kconfig: defaults VADDR, PADDR, and SYSFS to DAMON
Date: Mon, 12 May 2025 11:27:15 -0700
Message-Id: <20250512182716.50245-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512182716.50245-1-sj@kernel.org>
References: <20250512182716.50245-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is suggested to enable DAMON_VADDR, DAMON_PADDR and DAMON_SYSFS
configurations together with DAMON, since those are essential parts of
DAMON for optimum and usual usages.  Because those need to be enabled
one by one, and there are other test-purpose or non-essential
configurations, it is easy to be confused and make mistakes at setup.
Make the essential configuration defaults to CONFIG_DAMON, so that those
can be enabled by default with single change.

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
