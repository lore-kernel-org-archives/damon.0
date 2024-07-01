Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1918635;
	Mon,  1 Jul 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852821; cv=none; b=t3ozwR0G9+8X7h+dBTYi+ltefxohI/bwgNbTg7t9Shvh32NQXEWTf9W6ZWyIcVkkYMWIneSAMyCR2hgBZ7yJffUskeoaQTl1t48dP8Z7OOOAr0GZkfQGcBTy/TgfORwvpKhyToYkF0IjMNpTtWpEM8Vlx2gpXhmcUDKkgKKtFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852821; c=relaxed/simple;
	bh=vnMuZlhKXm3KWWW0CRfEhy9hgYlQoH9VI9igjz+6Si0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ui/sWSiQ8LPDEtBd6dFk1GkNK2C74D6+foD7ih/m10gp1AKPTxU0Gf8cRtPLt0TVK+ymh8aQTNSA9tiMNK5lNE5O0fR651Wx6wJRHl/I2u3vP7L4rM/yDE6T+cmplf+R8KZvRxPGr0AINxD+JfBtLisJDHYZbuS9xmwokPXI2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YciY+bie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YciY+bie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58559C116B1;
	Mon,  1 Jul 2024 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852821;
	bh=vnMuZlhKXm3KWWW0CRfEhy9hgYlQoH9VI9igjz+6Si0=;
	h=From:To:Cc:Subject:Date:From;
	b=YciY+biejtOG3AjVCjmdQi/3gRrbbRsqkwGMgtpLIbfJhZAQ1HX9Xj2ZGDYyQXFRF
	 esTXKo3nhK1hYmRFIYdGq4dIvEoVcBOEuKxwuIvYxQRHnbofntCHv480h98IdkRmbl
	 XLVS+Z77J4ioWulfFtbv8bfADc5zu9aimUPKCILRLK9tbjDHR8TbAG7BnXbkFkskyy
	 9MD7elwfPsUhLp6wjjv1PEWVv067dNQxQVQ34Ct2Ydt8o0fu/CiB8SBa0/PkQxYIFh
	 0JFoTeA5SiQlo8bN9cErXolZ214cDLJDwSawX29KPK1aOUHfSxFVZ9+moPfzksnRds
	 dp5pjo4zFwRuw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH mm-stable 1/1] mm/damon/paddr: initialize nr_succeeded in __damon_pa_migrate_folio_list()
Date: Mon,  1 Jul 2024 09:53:32 -0700
Message-Id: <20240701165332.47495-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable is supposed to be set via later migrate_pages() call.
However, the function does not do that when CONFIG_MIGRATION is unset.
Initialize the variable to zero.

Fixes: 5311c0a2eee3 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion") # mm-stable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202406251102.GE07hqfQ-lkp@intel.com/
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index af6aac388a43..a9ff35341d65 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -332,7 +332,7 @@ static unsigned int __damon_pa_migrate_folio_list(
 		struct list_head *migrate_folios, struct pglist_data *pgdat,
 		int target_nid)
 {
-	unsigned int nr_succeeded;
+	unsigned int nr_succeeded = 0;
 	nodemask_t allowed_mask = NODE_MASK_NONE;
 	struct migration_target_control mtc = {
 		/*
-- 
2.39.2

