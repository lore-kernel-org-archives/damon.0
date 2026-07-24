Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7227603F
	for <damon@lists.linux.dev>; Fri, 24 Jul 2026 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872937; cv=none; b=a6Lcq5Zaqn1khkQxrUvh1kwdKT/oakrp3eBc+wd8arFxjGPbk11DsS9rmz/US7uz9MHaDA4gn+Gr7uZrx96PB398MIdH09qVd2isP+eXOfOVFw8cv+kEQsG7/uRfaTS+dzRirmmS9GSEVm5D+LFtIXygGRwGXu4IzKIL7A5vH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872937; c=relaxed/simple;
	bh=BAcdpHisSFNKXmvN//xeH4T0S5UKM23bl2uYLQvG500=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=flBg/CWGq7dEaDzp9omcmNbv9yvkSSoePuYlX+h2fbH2Qp4pinB3O4NU9f+gq8OIBR3RTBIJu3NBjGfSk9QnD25c3r98QvfyQ19D9vwzSli6+x97wwAC7BVgdhcAKACnIPJHiCVUEoaj7w8PiAaJCV6JAB1th5ouzlaFtZ9zjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZsIvBOkA; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZsIvBOkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=R1
	+jg2jd6zdtixDn5cV87cReCHNp3Q2BgAIgphba4TI=; b=ZsIvBOkAGmHRGYLiBk
	mEi8v3b6fMgXS37pMBfZFoz+Zf/Eug+h0svgFhKohiA5RN6SOTyKhtAOu/FIcYCN
	xlvR/RiAptcEGT5CcLFnIwusNjPZI9CVx71wr3teInSXn3DBIfTstBnTvEoWlb0m
	UdqTGeWZEMJT8QEB15rqAW/+U=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCH5tPD_2Jqww8QIw--.45032S3;
	Fri, 24 Jul 2026 14:01:41 +0800 (CST)
From: dayou5941@163.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>
Subject: [PATCH v2 2/2] mm/damon/ops-common: factor out damon_putback_folio_list()
Date: Fri, 24 Jul 2026 14:01:35 +0800
Message-Id: <20260724060135.3014676-2-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260724060135.3014676-1-dayou5941@163.com>
References: <20260724060135.3014676-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCH5tPD_2Jqww8QIw--.45032S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry5Zw47uFWfAFyUXry3CFg_yoW8Zr4DpF
	1rG3yDXrWUtryxur13ZFZ5Zr1YyrW3Xr17AFW3GFs3JFn0qw40gF97Ja40qay5Jry7Jr18
	ZF1kZa45uF47JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCzuZUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3QVkE2pi-8WmbwAA3U

From: liyouhong <liyouhong@kylinos.cn>

The putback loop is duplicated in damon_migrate_folio_list() and on the
invalid-nid path of damon_migrate_pages().  Factor it into a small helper
for readability.  No functional change.

Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
 mm/damon/ops-common.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index f5ded45fabd1..9a1e8aec5444 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -331,12 +331,22 @@ static unsigned int __damon_migrate_folio_list(
 	return nr_succeeded;
 }
 
+static void damon_putback_folio_list(struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	while (!list_empty(folio_list)) {
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+		folio_putback_lru(folio);
+	}
+}
+
 static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 						struct pglist_data *pgdat,
 						int target_nid)
 {
 	unsigned int nr_migrated = 0;
-	struct folio *folio;
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(migrate_folios);
 
@@ -374,11 +384,7 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
 
 	list_splice(&ret_folios, folio_list);
 
-	while (!list_empty(folio_list)) {
-		folio = lru_to_folio(folio_list);
-		list_del(&folio->lru);
-		folio_putback_lru(folio);
-	}
+	damon_putback_folio_list(folio_list);
 
 	return nr_migrated;
 }
@@ -395,12 +401,7 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
 			!node_state(target_nid, N_MEMORY)) {
-		while (!list_empty(folio_list)) {
-			struct folio *folio = lru_to_folio(folio_list);
-
-			list_del(&folio->lru);
-			folio_putback_lru(folio);
-		}
+		damon_putback_folio_list(folio_list);
 		return nr_migrated;
 	}
 
-- 
2.25.1

