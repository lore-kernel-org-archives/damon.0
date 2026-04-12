Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8A303A0D;
	Sun, 12 Apr 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010805; cv=none; b=RUckfaHc2tTc82GAoBZdMEs33De3w1+1B/e/auY+HodufLkgVQ0iZxoX2nOwlCm66JM2ETppkzHZ+XCNoCLrok6I5XwrVhvHtxKi1F/iSIh3zTL8SaXnmu994FuuK5cQdurRfOdRkpizSbNjpNvtfs3vUnrQdNBEE8Jz/tt1WV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010805; c=relaxed/simple;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdmJhl+hfOTRswCFiEftNAN+Skhjs30i2a4GSHTtYjrcO3EcW2uW1D5EGVIGdP1UetRrpCTFwWbmOSx8kYZtW9662XiX+94Jv6ui0Lu0FOYCx6XBH4CAFL+abmGfQiUg0hWQgNPHElfuKWkSPuOIsKtGEpm+SHJuNb1ofdSbuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go158nx8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go158nx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0709C2BCB5;
	Sun, 12 Apr 2026 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010804;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=go158nx8BH5wgKLMjcmj2GNCaGpXFTv8GALgZhbg1MwLzUu1PiIKmQ2hf6SZ5Totq
	 /G72za/RW+8/JEEnUYwSWGLIRMEpWrQgjbiZVx42Ewbnk6ygizBccxGBjzAC2ZVaRZ
	 EgIKM5yBQfdEDEyfNkL/cNCsqR+bzpnQPomrt2vJ9SMYzihGiEvxNDH2xrUi2crUT0
	 UVvlumPhUfeA7lgNWOee6C0wh1ggZnRFo+pQ7CM8cS5Dp0Ass3mKlSGclERIvJlBh2
	 sQxEpv9agPUOTNo+AXW3DAKDn4dxWrOylZIR4GaZ8oP0nfxaKKv/hSYdaVCzt6mXEv
	 WRN3GPr5BSogQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5.2 07/11] Docs/ABI/damon: document fail_charge_{num,denom}
Date: Sun, 12 Apr 2026 09:19:50 -0700
Message-ID: <20260412161957.82835-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412161957.82835-1-sj@kernel.org>
References: <20260412161957.82835-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the DAMOS action failed regions quota
charge ratio control sysfs files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 7059f540940f0..971c22e34e722 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -329,6 +329,18 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the
 		goal-based effective quota auto-tuning algorithm to use.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_num
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		action-failed memory quota charging ratio numerator.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_denom
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		action-failed memory quota charging ratio denominator.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
