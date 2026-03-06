Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805153D4100;
	Fri,  6 Mar 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810964; cv=none; b=vFo4R6m1CvC2y1ib4eAnvP9V6vRqJ+m59flW1KQAZPuJdTRHWJO2VDAFbw1iU4TlCZKIn9ndDp02Oal3Vmdg08FMwWUhSXfkRjzu1TJFt5zZtoOitHFr+v5p0PJa5fzpcoMAgbFO4spmNF9LM7SalzO2igjPNCqjExz1ZMgJqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810964; c=relaxed/simple;
	bh=iYt3HJjJZ2u5nNYQJzA/aRcSczmrsEXHtQU6RM/AfoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtAmq5v7p50lsb49/pFAJmShWHRnLfP8aAbspAUgifmqYB/H8wL+nsdnPyrU4hU+cLcohSeiOL/xHBKpTQeT944lTGFXGCz08Ad2LZbGjjuGx7YVq7ep0BXXGN9XLwuWAJ+6d+qpjDsyicQJZIXtz6nm9Mmhb0APh6hhcadZTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRg73TdE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRg73TdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C48C2BC87;
	Fri,  6 Mar 2026 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810964;
	bh=iYt3HJjJZ2u5nNYQJzA/aRcSczmrsEXHtQU6RM/AfoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRg73TdEVyvd4i2D+cE9DKozFYt2Lcl8StD2ZBnxuBM0TNHBmZtMWcKJvhOZbZLui
	 8I4V1H0TzahAbhtvqRgaG9uzarzmB0ssnWK1whlA/YvsWX98IMhiIi/mi+hc+vfoyd
	 J7/fw2wVoYrWLqgFExxpSEG+86Rii8ni8rKDjEDsnyrhqRKBkmNrgZmfPjXq9q9DiU
	 RJsd/RK4whkCF+zr1FTPvbz9QvPwWH9lOgtB6YHD8YOVPROqBpKffuvaFIcB9tmrMg
	 a9bMKvGd4ZPF6UycBVDy5YHa05AEqBytV6u+CP0Gn5ikzygJvasD66i71UG2DLkyvF
	 SyVMBLokqm+eA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/10] selftests/damon/config: enable DAMON_DEBUG_SANITY
Date: Fri,  6 Mar 2026 07:29:13 -0800
Message-ID: <20260306152914.86303-11-sj@kernel.org>
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
setups.  Enable it on the build config for DAMON selftests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
index a68a9fead5dca..6304adacb741c 100644
--- a/tools/testing/selftests/damon/config
+++ b/tools/testing/selftests/damon/config
@@ -4,3 +4,4 @@ CONFIG_DAMON_PADDR=y
 CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_RECLAIM=y
 CONFIG_DAMON_LRU_SORT=y
+CONFIG_DAMON_DEBUG_SANITY=y
-- 
2.47.3
