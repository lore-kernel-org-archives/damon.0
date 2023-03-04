Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD22906
	for <damon@lists.linux.dev>; Sat,  4 Mar 2023 19:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D13C4339C;
	Sat,  4 Mar 2023 19:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677958802;
	bh=uVtft0lxTja3jBPQPJpnoQbKRCxZP/ST9hjfus9mMms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e3nKr5Xsgp0MN2UPq7FxyhDz5NDDfGt1VW+xC+uwXKXl/fw5Ie91/IKKZwhFgi+yh
	 9CFrNXy26L4W8ttmk7TxHUh28ikksODKGfRMLce15uwQC3XqMYNKtV7Vj7ORG+oyDP
	 mlPZ/o1VpAT8fNgpNrqGke2yktJx4RWUtx1oHDmE6d0G9zaqXuHyE7Tlxmgl0RG6sB
	 e4OzERuIHep+cFfGL6RNdEEtI2fzu0E7JvEyAElXtJXvcoO/LwD4tObncoLD/62A/t
	 CcLHJgqyFqenktJMegZbT/nUoR0mfKR9Bav6rvN2UVlatGynzpKP55fHXEDqUGwAEf
	 AZ9ZkvF6WyUMQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/paddr: fix folio_nr_pages() after folio_put() in damon_pa_mark_accessed_or_deactivate()
Date: Sat,  4 Mar 2023 19:39:49 +0000
Message-Id: <20230304193949.296391-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230304193949.296391-1-sj@kernel.org>
References: <20230304193949.296391-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_mark_accessed_or_deactivate() is accessing a folio via
folio_nr_pages() after folio_put() for the folio has invoked.  Fix it.

Fixes: f70da5ee8fe1 ("mm/damon: convert damon_pa_mark_accessed_or_deactivate() to use folios")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 10f159b315ea..0db724aec5cb 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -277,8 +277,8 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 			folio_mark_accessed(folio);
 		else
 			folio_deactivate(folio);
-		folio_put(folio);
 		applied += folio_nr_pages(folio);
+		folio_put(folio);
 	}
 	return applied * PAGE_SIZE;
 }
-- 
2.25.1

