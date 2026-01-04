Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297E173
	for <damon@lists.linux.dev>; Sun,  4 Jan 2026 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767490396; cv=none; b=KlebLgiSOx1ChXgCP7t+kIogjdrq3L+UqEoUN+RdvUkzoFxH81/FSXZOCGVaCHzfUAKvMqwmcbLCU8JpoN19DbycGNB1JAE7rOTkE9Q6pAB3pG1Nthf2+6/pKnuoWiCe9rhqZzDKDsIbFnT3AaSOJ8GxSHB200hkFojsqOPV+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767490396; c=relaxed/simple;
	bh=KJbsc163JyofqO7qEkSRnV/OWNJtiJo1sVpReyNv0/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d8lgsibOdKJqhy/4O9lcipSCe9eGMeY2fZJ2aASHYnuBb9XJ6rWSUaxFmEbhRD0x5LrQ3UBznmOSEEFK/Vk50eXGWBPCIG/0ThzuBnz5vA3vWShW5o9hh7q4EgAsChTamXUf3lEKUVfjRvRzRyO1vUKXSOL9SZb6NtjlfhttbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from inspur.com
        by ssh248.corpemail.net ((D)) with ESMTP id 202601040932568941
        for <damon@lists.linux.dev>; Sun, 04 Jan 2026 09:32:56 +0800
Received: from anolis.. (unknown [10.94.14.65])
	by app9 (Coremail) with SMTP id cQJkCsDwJ_dJw1lpIl8OAA--.16032S2;
	Sun, 04 Jan 2026 09:32:57 +0800 (CST)
From: Aaron Yang <yangqixiao@inspur.com>
To: sj@kernel.org
Cc: linux-mm@kvack.org,
	damon@lists.linux.dev,
	Aaron Yang <yangqixiao@inspur.com>
Subject: [PATCH v2] mm/damon/paddr: initialize 'folio' variables to NULL for safety and clarity
Date: Sun,  4 Jan 2026 09:32:55 +0800
Message-ID: <20260104013255.16962-1-yangqixiao@inspur.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cQJkCsDwJ_dJw1lpIl8OAA--.16032S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4kGry7CFyxtry3Cry8Zrb_yoW8ZrW7pa
	yxG34DKrWjgFWku34DAF4kZry3trWUXF9xCFWfGa4SkF1Sgr1kKw4UA34UtF1UZryUGFs3
	ZrWFqay7WFZ7JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: 51dqw15l0lt0o6lq211xuou0bp/
tUid: 2026104093257455ad401ea5bc51ae3bf98b8118e7f70
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In damon_pa_mark_accessed_or_deactivate(), damon_pa_pageout(),
damon_pa_migrate(), and damon_pa_stat(), the local variable 'folio' is
declared but not initialized.

Initialize 'folio' to NULL to:
- Follow kernel convention: uninitialized pointers should be
  explicitly NULL
- Improve code readability and maintainability
- Provide safe fallback (NULL assignment to s->last_applied is harmless
  and callers check for NULL before dereference)

Signed-off-by: Aaron Yang <yangqixiao@inspur.com>
---
 mm/damon/paddr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 07a8aead439e..7d887a3c0866 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -156,7 +156,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	/* check access in page level again by default */
 	damos_for_each_ops_filter(filter, s) {
@@ -212,7 +212,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		unsigned long *sz_filter_passed)
 {
 	phys_addr_t addr, applied = 0;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
@@ -262,7 +262,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 {
 	phys_addr_t addr, applied;
 	LIST_HEAD(folio_list);
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
@@ -295,7 +295,7 @@ static unsigned long damon_pa_stat(struct damon_region *r,
 		unsigned long *sz_filter_passed)
 {
 	phys_addr_t addr;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	if (!damos_ops_has_filter(s))
 		return 0;
-- 
2.47.3

