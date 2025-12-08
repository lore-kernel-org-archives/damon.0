Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4B320A10;
	Mon,  8 Dec 2025 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175430; cv=none; b=uIMgHN/Pp/d2SUBliMPRmVc7s/kekjFSLB8dNgCHw/DJ8vbw+VDPWOTx5Uua1ajb1l4Zw5o8hP0ffGj6/xFPOfVOP8rsv74urlov6YQQAjgbDJTT/UbttE2RUk/CMe41suSy7UteXir3Z6TbAdS3tOamCBthptCr64wosULjBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175430; c=relaxed/simple;
	bh=JPE1XJEWPTQxQyA4KvTjuuct2aS89H1amzc/wDg9UWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTSaYo6/guGRxC15b9vLhQmThDRklBQ9sgpGoecx/xCrtwiB7aw4JGN8pLJ0Jcs1w5T1ZuSpYTFwTeIBKaKmTHb1OJjScEkK0K7zQO7awtOFibtlisliUfLDBSDH1Ru5/wcXvo4eGB9aUvrEOTvUSiuMhReTZWaXGG6ekYzOaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJgREwbl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJgREwbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B051BC19421;
	Mon,  8 Dec 2025 06:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175429;
	bh=JPE1XJEWPTQxQyA4KvTjuuct2aS89H1amzc/wDg9UWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJgREwblfsPOxlzcswCmUBjL+skiE69803sMzc3gSdhETg2/YQKMTmiUTdKrSpIXk
	 NOdj/igxZZbOXrL/JAkgCT3/YtMbkS8uSBPiL810CntJQ/tU7m05PHbrEEkZno5dnB
	 WRjYU3mEpQ6zRE373T7OxkdT30znjkQ4N5WHpSyPbR63r/0upbHKttJQhRjI/p/WTF
	 yOofkVwejRIAofsv5sqTF00LqmTd7DUrOd0bD9M08jltQoMdW6NXLtPz8u+VG/FUQ5
	 ZBE2ZhkelamznjhP0Cm7Y7YRfH7sDjVUVFLL7Vz5vaDereF7P85kB8UwEKDPAMdDrF
	 4HvoQZYRLZk6A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 26/37] mm/damon: extend damon_access_report for access-origin thread info
Date: Sun,  7 Dec 2025 22:29:30 -0800
Message-ID: <20251208062943.68824-27-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The access reporter might be able to know which thread has made the
reporting access.  Extend the report data structure for the information.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index aff34dce7c7c..80332bb2b73c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -116,6 +116,7 @@ struct damon_target {
  * @addr:		The start address of the accessed address range.
  * @size:		The size of the accessed address range.
  * @cpu:		The id of the CPU that made the access.
+ * @tid:		The task id of the task that made the access.
  *
  * Any DAMON API callers that notified access events can report the information
  * to DAMON using damon_report_access().  This struct contains the reporting
@@ -125,6 +126,7 @@ struct damon_access_report {
 	unsigned long addr;
 	unsigned long size;
 	unsigned int cpu;
+	pid_t tid;
 /* private: */
 	unsigned long report_jiffies;	/* when this report is made */
 };
-- 
2.47.3
