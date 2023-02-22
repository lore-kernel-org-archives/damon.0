Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF71FAE
	for <damon@lists.linux.dev>; Wed, 22 Feb 2023 06:28:12 +0000 (UTC)
X-UUID: 0fb0b1f4b27a11ed945fc101203acc17-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GlIiKdz81RC+WT6ye6XFZWOPht8IFh4/MI/IcySt7tk=;
	b=Wy5W7Pma7ksrsOWmCqdALFtvC2TG9DiuPqdcpe8rFJx0sULsSyYjxbelVrC4lrS6IIT2ULuqVVe4sGqu9mVaiwzzA5TRngbFm1pXJlCQiBb06vvrXF3mWpCIJB0h+Ok/R4J1DebHGio5Qu8e7tjuESz5sBHH5A0aVycuCA2euOk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:5b8d3c7f-90d5-4979-88ad-ea03f3ead3ad,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:95
X-CID-INFO: VERSION:1.1.20,REQID:5b8d3c7f-90d5-4979-88ad-ea03f3ead3ad,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
	:quarantine,TS:95
X-CID-META: VersionHash:25b5999,CLOUDID:e1dc5426-564d-42d9-9875-7c868ee415ec,B
	ulkID:230222142806P43O9XSH,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
	C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 0fb0b1f4b27a11ed945fc101203acc17-20230222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <andrew.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1151569263; Wed, 22 Feb 2023 14:28:03 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Feb 2023 14:28:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 22 Feb 2023 14:28:02 +0800
From: Andrew Yang <andrew.yang@mediatek.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <casper.li@mediatek.com>, andrew.yang
	<andrew.yang@mediatek.com>, <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] mm/damon/paddr: fix missing folio_put()
Date: Wed, 22 Feb 2023 14:27:54 +0800
Message-ID: <20230222062758.6183-1-andrew.yang@mediatek.com>
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

damon_get_folio() would always increase folio _refcount and
folio_isolate_lru() would increase folio _refcount if the folio's lru
flag is set.

If an unevictable folio isolated successfully, there will be two more
_refcount. The one from folio_isolate_lru() will be decreased in
folio_puback_lru(), but the other one from damon_get_folio() will be
left behind. This causes a pin page.

Whatever the case, the _refcount from damon_get_folio() should be
decreased.

Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
---
v2:
  according to David's suggestion
    1. revise subject
  according to SeongJae's suggestions
    1. rebase to mm-unstable tree 
    2. remove braces for th single statements
---
 mm/damon/paddr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 607bb69e526c..6c655d9b5639 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -250,12 +250,11 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 			folio_put(folio);
 			continue;
 		}
-		if (folio_test_unevictable(folio)) {
+		if (folio_test_unevictable(folio))
 			folio_putback_lru(folio);
-		} else {
+		else
 			list_add(&folio->lru, &folio_list);
-			folio_put(folio);
-		}
+		folio_put(folio);
 	}
 	applied = reclaim_pages(&folio_list);
 	cond_resched();
-- 
2.18.0

