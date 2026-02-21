Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9B3EBF3E;
	Sat, 21 Feb 2026 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702595; cv=none; b=lpdIFfQ45JOmAeW+XfR1htBEva6Gw/hK3lMSwD/rauDx0Ii9okuOQsOwVcHgxZ2gyBvuocFtovLkl+v/dIqMoFf5Vd5qsHjErogjKRVjkeyuJxQgTa9R1xMlHUJKkJ/4Uhq8qdigXqEwK7nAq6xgRHGrNnm+hyL2VfgHFz20fhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702595; c=relaxed/simple;
	bh=NP5yGYScgnKGoybmv99+TvTrjNGo877C34B0II+hAcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5GQ7qTsaA71hIMNCYMV9K75e6raCMdHMyHkg3KOO291mWVjRHATORC/yxQU7T3NUPnEzNJQ2x1dlinyRAVFYj8NwMoAkQduDiiPFCqa9Jt6bLtDqEHtqSIUza7VSkF0WDD1F7C3Y3RU7FzszulGnQqwZ3qxIQ7BXK+OkrDmpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/wZ7aER; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/wZ7aER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973C6C19422;
	Sat, 21 Feb 2026 19:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702594;
	bh=NP5yGYScgnKGoybmv99+TvTrjNGo877C34B0II+hAcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/wZ7aERGs2PvqVhMrKPyc6Tc+lGG1/WZh2v8Sb4EoKD5+7RTgO9/TJc5ZAfJXkvp
	 eb5b2xcJ3HFcTadFVuhNa8aNxrjCf+yOxE1DS2O847hktwk22wgrJ02hc+cvEsNlg4
	 yEPg8AcEKU9J3oc1IdwNrhSWZq3FPC15HSY0XFrJ0MyjN0RhP0fCurfvjnAAMUzFox
	 lnGtcsT8xfuFl6BLGuiT16hYzCgHtqMZkm2Ni8USIF4ehnaQyZ+jdGGH7oJf9Z5ws5
	 xCb40o6OBnj1RMff/oNVgxYUcxQXyfXf/Y/J9GwvGyFFTQNnmHhknLyf8oEEM/BH/r
	 QKg5pTnR6c9Uw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/10] mm/damon: add CONFIG_DAMON_DEBUG_SANITY
Date: Sat, 21 Feb 2026 11:36:18 -0800
Message-ID: <20260221193629.19332-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-1-sj@kernel.org>
References: <20260221193629.19332-1-sj@kernel.org>
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
index 8c868f7035fce..413adbd8e4089 100644
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
+	  additional overhead.  This is therefore recommended to be enable on
+	  only development and test setups.
+
+	  If unsure, say N.
+
 config DAMON_KUNIT_TEST
 	bool "Test for damon" if !KUNIT_ALL_TESTS
 	depends on DAMON && KUNIT=y
-- 
2.47.3
