Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC186182B2;
	Tue, 27 Aug 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727832; cv=none; b=LO2mCsjYouRdXsrPLqT7Sqjitq5d9Ho6inisT5HOfWG1FxnIHwTNXgqZQDnqKzcgBmoDBthGPjJTtkXNGbx614GLWT/2JiPf1GsXm04NmMzPiYoHDP7qc1SL40ho4GkBaY/tnfBWB9tP5N5n94p+EyayRiGUaj3HJgsn+E+Y7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727832; c=relaxed/simple;
	bh=ZaGVTXIiI8PW6Ml6OfO+1JWaxqCvOdy/W/r1hHy96T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UydQCs7qmRmFqOZDlZu1kf6KXnSdgU30lpoNoSvMk3DTZQ/wVSSt/ttdfD6iKCdDgAWXDUoiOsPGP0NFkkxet9J/E/65SR9uxJYsBRXEw2tPHCxK7HYVIRnT2iIauTegw+BLYO48eEpkmPb4cW9jmmvAdQANj8nm1O1SNUk64bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMu+YKfg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMu+YKfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19B5C8B7A1;
	Tue, 27 Aug 2024 03:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727832;
	bh=ZaGVTXIiI8PW6Ml6OfO+1JWaxqCvOdy/W/r1hHy96T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMu+YKfg4RqNEUEeEU1xo7yEGptZoWTq6zET4EtB7FTt76Ox0VabnKIEZx4VWJQvK
	 Hg4mBubK6R/gHCjai+on24wQaH3xRu8CfHOzZVKTxLRUoW+FIMy4lJH8ND2jur9o6F
	 o6UyON1x+rNlZ9GpowuGLSUWbCkrhIIBBKTnVVPLwmGgxnj3bqA+bjFuCO4vP2PRTY
	 jyhZMiQHzkKvlEEsJXZ5b8U/7nqGmREL3CLIzxJXLYsOIQjLmwNbR8JSsPuO+1GeKw
	 vnvF/tBu2RAi3vQjnWlXlIVAxPEwQLXJu04BEngDYwYpnRPMwuUTyz3jVXgge61NWo
	 CSsXW6sEug/1Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] mm/damon/tests: add .kunitconfig file for DAMON kunit tests
Date: Mon, 26 Aug 2024 20:03:36 -0700
Message-Id: <20240827030336.7930-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827030336.7930-1-sj@kernel.org>
References: <20240827030336.7930-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'--kunitconfig' option of 'kunit.py run' supports '.kunitconfig' file
name convention.  Add the file for DAMON kunit tests for more convenient
kunit run.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/.kunitconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 mm/damon/tests/.kunitconfig

diff --git a/mm/damon/tests/.kunitconfig b/mm/damon/tests/.kunitconfig
new file mode 100644
index 000000000000..a73be044fc9b
--- /dev/null
+++ b/mm/damon/tests/.kunitconfig
@@ -0,0 +1,22 @@
+# for DAMON core
+CONFIG_KUNIT=y
+CONFIG_DAMON=y
+CONFIG_DAMON_KUNIT_TEST=y
+
+# for DAMON vaddr ops
+CONFIG_MMU=y
+CONFIG_PAGE_IDLE_FLAG=y
+CONFIG_DAMON_VADDR=y
+CONFIG_DAMON_VADDR_KUNIT_TEST=y
+
+# for DAMON sysfs interface
+CONFIG_SYSFS=y
+CONFIG_DAMON_SYSFS=y
+CONFIG_DAMON_SYSFS_KUNIT_TEST=y
+
+# for DAMON debugfs interface
+CONFIG_DEBUG_FS=y
+CONFIG_DAMON_PADDR=y
+CONFIG_DAMON_DBGFS_DEPRECATED=y
+CONFIG_DAMON_DBGFS=y
+CONFIG_DAMON_DBGFS_KUNIT_TEST=y
-- 
2.39.2

