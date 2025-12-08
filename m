Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8B31A808;
	Mon,  8 Dec 2025 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175411; cv=none; b=cXZfYpyDhbwoHcRqrG3V8uDPiwsJlLmttBP3diNHG814JQBd8T0RKmax8UBLhbykhHre50bnVLyuf8/FabuL/XYcitdLu90OSaQTS81gmUNyEAV137xZHZy6QuAEZQXINPO1ZvKBnxSQ/6GMQeocWHFeH+hCN316Km4JyGexPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175411; c=relaxed/simple;
	bh=55qSAyG5lbRxWMFpgyshAGzR1uB1VLHtbYjVj1MXVYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY2ivnbN8s4b1FNv4r/Dv90CDY4d7EUlhw33hat/rmeDysywttm9qTpzEOrFYanXn3eMzwQFrSJEb50O01i07ClSUEFskiY/vdS2eEIm1k+Xtuh5KCDTUb3Sf7MmYEzgMPzi+V0/FseLQOUo66C0Rx7kq2jBpVA0z4ddmXY9Qdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pATG9OqS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pATG9OqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA33C113D0;
	Mon,  8 Dec 2025 06:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175411;
	bh=55qSAyG5lbRxWMFpgyshAGzR1uB1VLHtbYjVj1MXVYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pATG9OqSqP99RXBWGY7fJfLyZtQHGWBxHulVCPM+ydODfXlD5TnhqK+S5lzerqbZp
	 ekZhX9dMxDZRFfUaHT5/AvN0sqkS6YKZcSOE0NvI5G68DU6bsdO/BIMidyCJY5f5uD
	 7Vk+6Q1+zj24SDQCehMBMTSI5cwHPpdF896WJoTaJl0qTwmmI0QgVvTKPuzlG2xCn0
	 ziYlMA33EZHcUSw0rkmrwUQHl+DvAYvJdYA1LgqQtpp7+g2Bk8Z30yh6aCrZ5aB4dQ
	 PxFDxYAGQxvIu08k+g0FHN14/31RkH8JClxSmy8if7CD2SAFIcNFLbMAxaYadwxx9A
	 H0blcK8k17xZw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 14/37] mm/damon/core: report access origin cpu of page faults
Date: Sun,  7 Dec 2025 22:29:18 -0800
Message-ID: <20251208062943.68824-15-sj@kernel.org>
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

The CPU that executes the page fault event reporting function is the CPU
that made the access.  Report the origin CPU of the access.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a14754a47c7f..d2f842d8afd2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1585,6 +1585,7 @@ void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
 {
 	struct damon_access_report access_report = {
 		.size = 1,	/* todo: set appripriately */
+		.cpu = smp_processor_id(),
 	};
 
 	if (huge_pmd)
-- 
2.47.3
