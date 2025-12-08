Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2731AF25;
	Mon,  8 Dec 2025 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175410; cv=none; b=SAqWz0B3naZGTFZR7ZaDt/XeLuy6FZlhfFAQ8a5CDPNtsLJhxGuOE/S+SuyqP1P1g7+FNTBeeRtuhL8I6gJTw1BbrjAImpVyt42bbbgQGp45Pfh+FD5oEtYvLh6zUYJtKWeoprP0oCapRLlW/6SgUCC0c8om6EFIxxqBcV9/Pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175410; c=relaxed/simple;
	bh=At5tPajQSPLt9hOlFCrxmrzWPKun1WpQ7z3727tgAL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txe6HiZRFlCstd3iL2xteJ8PPnPhU8f08hDKa5Wse32qLu1RUTi44MDSK0S3slUO0oY03xf+1amN0d/5XO8Ik5ivJEfS8+LQo90V0APNHlyxQvU89oolmTOx1Ocnv1fGqXQeJAbWQtX1wUHLvHFOcg4HHShkL2OBnLjL9KvZDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWYxgDEw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWYxgDEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23296C116B1;
	Mon,  8 Dec 2025 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175409;
	bh=At5tPajQSPLt9hOlFCrxmrzWPKun1WpQ7z3727tgAL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWYxgDEwewUI4Si1uvn2A7qlU6sI0b+yWp6SF/szJF2mbBBdXg0ZIAIekRW+ZOrrG
	 6TbmzOGczenZfeBVT1eGwM8skmQNCoC+T7rzUAg1s/D7qKk5krfv223sDy+Et7SKYV
	 oKDb/jYUtQD9s5Sp7d1+s6HJyBRA78C9StrcOfWWsYip5AOF/H+pRJNQBU5+6oOv9w
	 bB8o7cqHCaJ9YJ8Qk3M3o0RMOD2nKZPDQiL6V77bFV/BxTWnDPT447D3IS3ql5eu4y
	 Hm319ClPVM1KMf1IeY6kU7NtDbSWg2Wq3lUwZjBk+UOcPyDyvcpSJnwXRSjLE7qQRx
	 /YO2G1qXPqUiw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 13/37] mm/damon: extend damon_access_report for origin CPU reporting
Date: Sun,  7 Dec 2025 22:29:17 -0800
Message-ID: <20251208062943.68824-14-sj@kernel.org>
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

Add a field to damon_access_report that can be used to report which CPU
has made the reporting access.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b04c2e36833a..e23a10ba7c92 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -115,6 +115,7 @@ struct damon_target {
  * struct damon_access_report - Represent single acces report information.
  * @addr:		The start address of the accessed address range.
  * @size:		The size of the accessed address range.
+ * @cpu:		The id of the CPU that made the access.
  *
  * Any DAMON API callers that notified access events can report the information
  * to DAMON using damon_report_access().  This struct contains the reporting
@@ -123,6 +124,7 @@ struct damon_target {
 struct damon_access_report {
 	unsigned long addr;
 	unsigned long size;
+	unsigned int cpu;
 /* private: */
 	unsigned long report_jiffies;	/* when this report is made */
 };
-- 
2.47.3
