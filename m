Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B35399372;
	Thu, 19 Mar 2026 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897728; cv=none; b=npC7NqOd+kwoph5I5A7nAdsUbJznw9LnWwLxOfmWPjQJf20SJ8eE08IOVLqz6qP/ZJk0dhkfCHjLr6xgk8Jx++bbZsy1mQBtPcufr2gmDheCn/tQuzeIlyU8f7eBrE9q82tNRGeTvMhUolXGv0kqFB4/yrgOr1l0kiBXvahv0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897728; c=relaxed/simple;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RINjHjL/RAseT+cKvxYkGaU1s1EjCp1Lilo5hIjdHNXruf1bpRb+dPe4ZbOurKtKv3sSmShkAcSATBXW77WJyVrd3Cg0VEYjph1eDKrtwxnK7Hw2SyAtmhwyEKqkmZgsnKtjGpR0tWJPtOYO9fa1DvA1VwXF+B7q4IPq3FQXWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uagNiGAx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uagNiGAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B52FC19425;
	Thu, 19 Mar 2026 05:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773897728;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uagNiGAxETvojRrk7as8iLji3zWm7q9RFc79GcLFgZssck6NDsuRBowVLTVn2K+P7
	 NP0/tAvIoRmJ0ggHCeZiP8W7iFRe2kkRiOe1zUSSj8qOs3g+24UnZPIR0Sz1g1j++8
	 QvnMSjwh4WTf2TI/BsC6AcekX8X4kb5qFzKhlHv2qe65rx/1pPu7Gi6kdk9WjTjhWj
	 ROqKIb3YCOROpO3FdvC+ClnOIOGuWlDzQ5TZwQSyNufR9a+vkyNdF8pEOrGSN26aXG
	 TDUz6TwaOc8Zz3OPunFBnYpTn8DD+aHIwBW56DZf7wEKY2EqIhIKAQsRE/+7ZgW2iQ
	 68gbVmMq1sX9A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 05/10] Docs/ABI/damon: update for pause sysfs file
Date: Wed, 18 Mar 2026 22:21:48 -0700
Message-ID: <20260319052157.99433-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-1-sj@kernel.org>
References: <20260319052157.99433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the DAMON context execution pause/resume
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 2424237ebb105..7059f540940f0 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -84,6 +84,13 @@ Description:	Writing an integer to this file sets the 'address unit'
 		parameter of the given operations set of the context.  Reading
 		the file returns the last-written 'address unit' value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/pause
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a boolean keyword to this file sets the 'pause' request
+		parameter for the context.  Reading the file returns the
+		last-written 'pause' value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
