Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015101390
	for <damon@lists.linux.dev>; Tue, 21 Feb 2023 09:03:37 +0000 (UTC)
X-UUID: 99cad4d2b1c611ed945fc101203acc17-20230221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DZiCKkXRKaBMEPM33tFzlW1XDIvB4CcSTT6creyaUOs=;
	b=Ke7xi24zxJ4Fc0DrdI8y4+RFQ3//kqLq0/lcATVL19t65+Qz27ioUGdEr67dGpreLRVR9jCR9Y/iYD3yvWyzjbhnnkNyrqyzshw+izTCkqwzQl6afvc6QX50rxevcrI6MCTOgGOqsRacFbr4uPjWxFa+H1xuWLVAMVcZfQ9TMJs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:ae9537d0-46f3-43f6-85e3-6dc05de696db,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:9ed73a26-564d-42d9-9875-7c868ee415ec,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 99cad4d2b1c611ed945fc101203acc17-20230221
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <andrew.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2135986972; Tue, 21 Feb 2023 17:03:26 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 21 Feb 2023 17:03:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 21 Feb 2023 17:03:24 +0800
From: Andrew Yang <andrew.yang@mediatek.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <casper.lin@mediatek.com>, andrew.yang
	<andrew.yang@mediatek.com>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH] mm/damon/paddr: fix pin page problem
Date: Tue, 21 Feb 2023 17:03:13 +0800
Message-ID: <20230221090313.15396-1-andrew.yang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "andrew.yang" <andrew.yang@mediatek.com>

damon_get_page() would always increase page _refcount and
isolate_lru_page() would increase page _refcount if the page's lru
flag is set.

If a unevictable page isolated successfully, there will be two more
_refcount. The one from isolate_lru_page() will be decreased in
putback_lru_page(), but the other one from damon_get_page() will be
left behind. This causes a pin page.

Whatever the case, the _refcount from damon_get_page() should be
decreased.

Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e1a4315c4be6..56d8abd08fb1 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -223,8 +223,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
 			putback_lru_page(page);
 		} else {
 			list_add(&page->lru, &page_list);
-			put_page(page);
 		}
+		put_page(page);
 	}
 	applied = reclaim_pages(&page_list);
 	cond_resched();
-- 
2.18.0

