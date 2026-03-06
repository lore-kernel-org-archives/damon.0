Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F363D333F;
	Fri,  6 Mar 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810962; cv=none; b=a7/DPgKr60aGWGfsgRBQ52s9TpHFX2sj+1uoDDO9sRkIvX8/0hKDdG7QUXPHcHMuuVkCmWs3fmZRpWCEg8fSWmCoO67Ljqb0PzcQpnFbJgq/ykyOkEsomxBKLFZjtTmqMzvuqlfcSFcm7dp8XQtdL4auXy5xDS2N9cKDq8Mw020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810962; c=relaxed/simple;
	bh=mPwVqtgK5FXF6rtx4eARff1DBvg92YGlSMSnRp8dVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6Gg55u852J/AQCIbmO/62reoD5XRNVxKQCRoJ2dZ7LPJ7H06iW9ALQ9xBZOC4C4bITBthcr59HPvsJPHQuNr3ZED6aup8CvWIIdtEh+JEiAQarN0j3Wn4b6zWqwiuqrpbxqyiP6vTLRdgLfCSfQNzVxBh5C6Ooq67hFHYkWxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoYtOTvO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoYtOTvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213C7C2BC86;
	Fri,  6 Mar 2026 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810962;
	bh=mPwVqtgK5FXF6rtx4eARff1DBvg92YGlSMSnRp8dVoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NoYtOTvOVdC5NHLliOnNupYdNTkqPbZgtHYp4eZWZRLRjj+sT0vgd3NGm3Z7OkdXo
	 rKPM/tXPBq+UsQAhdBk1ugO0+QbWCSO4Nf5IZAPyQOLpHEyfEeUTTandpLri/LpULR
	 RrVLfe2koKp0GWNHZSWNf0Rc6D17Gxt1c77HpJWH8zzSHfcO4DrdmfIxA0PBHQIV4W
	 dzklFvANhadVEAmtaG4XJVeNn/5ncrsGTq9neksEvWoa2BQnU0JcHkZW5TrMI0p/18
	 w4nkLr5pAv8YO/7r2gGs4iovBuKznQ4BlAZ5bAv4b/N4bob1eR5jXCfhklTT8NJYHz
	 RzaHfQC2kVR8g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/10] mm/damon: add CONFIG_DAMON_DEBUG_SANITY
Date: Fri,  6 Mar 2026 07:29:04 -0800
Message-ID: <20260306152914.86303-2-sj@kernel.org>
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
