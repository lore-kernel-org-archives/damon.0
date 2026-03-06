Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E353D3D0C;
	Fri,  6 Mar 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810964; cv=none; b=IdBQuPxfZ3dA0NmyOLXdqEkK8dGk6jmrH95156YI8rAdGlkURyEs0p/BU912ELdTcy8VXz1zj+KmT5B296N1+ihLmGAUcDI9nvp+oEA7Ar1ZE3E7nZBOASV4kIEbfKjL4JojW+YEceaFmhb1ZhoCPbLaiR9NLAdcBES/tJ8A5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810964; c=relaxed/simple;
	bh=BLMf6S2CwC1uRw1Za6T26Ewe+0K+xw3rETEPypk9tzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5tVic4FdwdmFlCyGMNxWj/XYFAa2artQLh5A/YvxVvVhboQ5icM4QU+M+0aW0qOPa+gmiIohtK3w5BA0DZsrM0/6693Tc+uLjq7/WBstI9gjJyePJAJPRra9MD3vFrcR2XzeKyMFxH2IrPWIkmTZiwbaJf3JnX5MOwq+1y0iI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuC3k1qZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuC3k1qZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2390C2BCB0;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810964;
	bh=BLMf6S2CwC1uRw1Za6T26Ewe+0K+xw3rETEPypk9tzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KuC3k1qZgIOPJDD/X46auDKxq3ATjy5gZTmx/CxXFUu3O5B3/YOsoc8RKQTwt/1KX
	 XCxHakNdUY4Q9ufSqNGgUPpWujZkUh74rJ2iEKSwAf6zlqOjSj3aAWcRW+MH+ySKB/
	 hbEG4TUYrrv7xJvJv/jeLTu8wfGeZ0arlCP6nq3xXIF/KitdCAm9KaMEoG52rqwCHf
	 PA64Uv67H13ctUxnBWLTBVGXzGBEJ+p4mH49ubp4CSqNxUW56sWvRQaK+doykJKIHR
	 rePX/kzL7vgS3HM/Eb5PxMe+jdzgqyZHDo4xYwDx/XDxMzKdExacChFuCYa75OIwJ+
	 WLEwl5QXsnuBw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/10] mm/damon/tests/.kunitconifg: enable DAMON_DEBUG_SANITY
Date: Fri,  6 Mar 2026 07:29:12 -0800
Message-ID: <20260306152914.86303-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306152914.86303-1-sj@kernel.org>
References: <20260306152914.86303-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DAMON_DEBUG_SANITY is recommended for DAMON development and test
setups.  Enable it on the default configurations for DAMON kunit test
run.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/.kunitconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/.kunitconfig b/mm/damon/tests/.kunitconfig
index 36a450f57b581..144d27e6ecc5c 100644
--- a/mm/damon/tests/.kunitconfig
+++ b/mm/damon/tests/.kunitconfig
@@ -13,3 +13,6 @@ CONFIG_DAMON_VADDR_KUNIT_TEST=y
 CONFIG_SYSFS=y
 CONFIG_DAMON_SYSFS=y
 CONFIG_DAMON_SYSFS_KUNIT_TEST=y
+
+# enable DAMON_DEBUG_SANITY to catch any bug
+CONFIG_DAMON_DEBUG_SANITY=y
-- 
2.47.3
