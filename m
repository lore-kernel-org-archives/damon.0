Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434928FE
	for <damon@lists.linux.dev>; Sat,  4 Mar 2023 19:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE5FC4339B;
	Sat,  4 Mar 2023 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677958801;
	bh=+0s3q5P93UqG6M+TlQeZxhgJ5LHMlSIa1orOsWRdKV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kziuyNZuajLhSjnjdZnm8IqkuHkf02BiKBZNeQC+XzR3qFQ2pMIvgf0HFTNa9ZvIU
	 MiXIATlC5kNsCUH2IkV3+WpY+nfN1Et1hC77JdpBgeKoTLn/HW0Ki4lmvtt1zPIJNL
	 hYKnvMg2LwM4bqzO6VLrDXgwcM5tSxgINdUbiPlqsy10b8o5tOTdX6A3qIKpyDDJcN
	 zqsNJd4/fgyJ3UYj1S4AzQdJDyXfrsZxRc8y8fmEk6fxnmS6dBIJ1aLQGYaT6jB3P5
	 K4/8VIcDCSdpIZ11RUrXZOd8tV5KMmXciw/36gYjhopIQHHvdgbUSEye2jFUZsSZ9w
	 JWulLNMHHCudA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/paddr: fix folio_size() call after folio_put() in damon_pa_young()
Date: Sat,  4 Mar 2023 19:39:48 +0000
Message-Id: <20230304193949.296391-2-sj@kernel.org>
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

damon_pa_young() is accessing a folio via folio_size() after folio_put()
for the folio has invoked.  Fix it.

Fixes: 397b0c3a584b ("mm/damon/paddr: remove folio_sz field from damon_pa_access_chk_result")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 3fda00a0f786..10f159b315ea 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -130,7 +130,6 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 			accessed = false;
 		else
 			accessed = true;
-		folio_put(folio);
 		goto out;
 	}
 
@@ -144,10 +143,10 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 
 	if (need_lock)
 		folio_unlock(folio);
-	folio_put(folio);
 
 out:
 	*folio_sz = folio_size(folio);
+	folio_put(folio);
 	return accessed;
 }
 
-- 
2.25.1

