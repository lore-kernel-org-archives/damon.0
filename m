Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AE37C912;
	Sun, 15 Mar 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608424; cv=none; b=huQgaqQM05ntxMB+gVkcyWddxigwIRgLyRdnW1HYaVWjqlyWEUpzUQ5tUENC9oq1MVhyj0tlP2Zmv6AxfY1VAsZf5rWR0yUtFdVHrt/YQqNG7lDE0Tut6U9NfqGpe0f8MDtEmQ6bWCIPEyfz/mrzhgYoxJH0g3SiIen1yD7kyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608424; c=relaxed/simple;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njTT4kYlzYw6KPwpl/w/bzoC28fZpZRMz9FFiAHp5I+FpI0babbUARxqKQ/R6l09gGB+EtxJcZ6qDF27vAWoAI8cvikno77u9pPVXAmgKofU/l7G/VmA0qW/S06PoLciBXh6Mb9WBHdJUkP6V1XtdZOQ9F4qYOuvLJsD6U07MKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEzKpWx+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEzKpWx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A99EC2BCB1;
	Sun, 15 Mar 2026 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773608424;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEzKpWx+0qOPhCqTs6Tmujac6Z1+jtupZdJO1eipchDkTNY+FsLgjYSiesZhbPdQA
	 0XI5hq5goiqMBqEYDk5NF+MNK5070vyCbw5UTYRvfPfl4cAeh7+PL2dMdy4zOe4stB
	 BMmRVa6UA/xcNFBFHZ/DSAEbpxZZooS/xb2TInqKQF2o8e8QKulRbIDHlwYlwGkYkp
	 GKLJdWXHIam9TV6vwwI55dqA/zxZrugc89uQ1kSd+2r1JZduUFzX2r6Gf03bSRVF+N
	 7Km61cD1WWFSCvH8YmzK74Bcq3PGuV7VruLuJOM8NDa2Q/sdg3cE0zGgE2spihnrTb
	 8SQMDfYmVCX4Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/10] Docs/ABI/damon: update for pause sysfs file
Date: Sun, 15 Mar 2026 14:00:04 -0700
Message-ID: <20260315210012.94846-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-1-sj@kernel.org>
References: <20260315210012.94846-1-sj@kernel.org>
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
