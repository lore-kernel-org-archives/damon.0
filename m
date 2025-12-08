Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49815322A27;
	Mon,  8 Dec 2025 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175443; cv=none; b=IIVILWxDA3VMOkAVFAYayomtPXMJTwEdiMsqHtEgMUIDUkAwNVliWRUGKzQqKVqQVWwSWkRFl3LOvjyWa5Mr9NTsKXFM3J8Rz8A6mGJpdFg050IYB85UFC15HHdbH2iL1qeVo+0Z9lkEq7WU5NcY4yjd2JtiiJWnQOqvLt1wArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175443; c=relaxed/simple;
	bh=3vYcUeBmXr4garxcQHjJx07QLWWSN2yZSMq4StEXQLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWHldEvoIZM4W8vOckU4yQp0j96DE88HYVbA9WGtrNQzEaaZqXvdTmQ6gcQ1EjpvQwRbeH/4rMApOSnFT2MjteGywpZNos/saU0POOQtPJO8Gwbn0NR6JIY4SY0iahrRtTlSiTHb3SNtD+fh5Oib00tYWKKojecK9tM1hwtqjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0xtLSkF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0xtLSkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA08C4CEF1;
	Mon,  8 Dec 2025 06:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175442;
	bh=3vYcUeBmXr4garxcQHjJx07QLWWSN2yZSMq4StEXQLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0xtLSkFs7pqEae043u1j3xnB95Eun6fs+QGZgZO9d81R7nVANe8WzFd7INUNaH5J
	 G0cu5g13QicS+7SpfXLfFYjeCO7OZky97UtEnCU1Fg8vOIqL0guCnn+Met1AgHKg5M
	 5NTPXJXNgEVF4hk8vk1FGAsAu82jhb0v522m+QxbyOFfL7UlnXHN/ha84/c+mqS2eq
	 0qSRuP9CaCpfcNNAkk+LdrdatyCNz+99Jk1hlLUrlAc3UBxmBAqyPlfv8/yoebiFZt
	 WeGrFytSTuFCntaqviHlHDTKBMaMONUSg6xP56TYbN2K/XjRoJDfgJDnBS6pPwmnAS
	 6VzqV0nDquVZQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 34/37] mm/damon/core: report whether the page fault was for writing
Date: Sun,  7 Dec 2025 22:29:38 -0800
Message-ID: <20251208062943.68824-35-sj@kernel.org>
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

The page fault event reporting function can know if the access was for
writing or reading.  Add the information to the report.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 782af39ef0c0..e2fd17b83a92 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1732,6 +1732,7 @@ void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
 		.size = 1,	/* todo: set appripriately */
 		.cpu = smp_processor_id(),
 		.tid = task_pid_vnr(current),
+		.is_write = vmf->flags & FAULT_FLAG_WRITE,
 	};
 
 	if (huge_pmd)
-- 
2.47.3
