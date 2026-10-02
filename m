Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA338DC5A
	for <damon@lists.linux.dev>; Fri,  2 Oct 2026 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950063; cv=none; b=BCTyJqwlUgQyJQT3wCMPQqGkSTsPBx3QVEc/BLCPCU58cHBLIbU7caLWmAw6l1pN/3vsu+5NARl6oZVphsQAEgNHQz3Ljv57iAa4oMQjzWqSV8ke04y6vqgOfmd1FBCSEtQ5gSqowyZiGnyiupE2eNZGtBPM6cKBrZah0yW+umI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950063; c=relaxed/simple;
	bh=JjO6pU949CqRqbL26N1fqRy0WHxaqLDDRf+/sHdhEoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFxYzqCyBzPTa/lkVeWWLBTxRko0LN6Tm5ynzbHUIIbnQSyROpUc40F/KNbo9GOE9WKAOxGMfdrmb6NoP6097s2G6r2ggiCnQact39iZVxTPdv2cvsF8kCgzYmPgCKDkhjkCGGVyr1y0Tu3iM4DKYKHIpU2SQ6fhRE437ulCkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Nm4ZGx/I; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Nm4ZGx/I"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so501055e9.2
        for <damon@lists.linux.dev>; Fri, 02 Oct 2026 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790950060; x=1791554860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zcpSt1gDUaHzC+rz1E47o28EjRtid3BchWuzvfuo1o8=;
        b=Nm4ZGx/IuupjnMZHlCYxm6WNRNo75TWwHM2F6tX9Ccne5cmFIJI7lqYNlzQrwnRS6i
         Rm+b+EJcGRnxLONtKMiOONuUowYjCUcPKgtk9syT2mKeqVMXK3L7WxTPuayjAjaRCvtn
         GA7m/BaSBOd4JUWneoFlmzHSMew0jSzdx7cvw4UBdozXG5BClduDs8up+1W+WtHcPI6Y
         H28jAdyYZj/68qv8HDmdL53PBKcrhMwpE5pI13S5rWbrBtNQg5ffaJ7NUv8EMwrw0AH/
         +XlGfziYob4UwRu8lIP5Hq2PqsV7G888CzfsEC/OmgHkf067x/BqXBxoUc3Lp6NfQXxO
         IbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950060; x=1791554860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zcpSt1gDUaHzC+rz1E47o28EjRtid3BchWuzvfuo1o8=;
        b=CdSZRGM3lwz3fxKpuM3SjxnyzsY9wU88xEHsf6rPzwzwKfU+032p3nDE0JiPgiZyB0
         XIzTHrDlGMY0/C2mjaRb9FX9JmzhdzQt5UJYC5bubqZokZdHf3xAJXYlxtJGK8LM5U1z
         dugn5D3gwE7TKKBJuVYe7BbmTXbWL/EJIcEkkoZiSnnS4xHnowz3ST4M6+c7gawUYA6u
         eI+hdO4w0g+zcEiDDublgUPpRR5BnC+eZvOO1TrEUBeK5qBGQ/vXbHbBoI3rnuR1rj0P
         tL18GUTPMb8ifN93LUcKgcfzPSmU7JwAPCwczYmD9+csVdkEDuYHzM0CAEMLcWuQMWmC
         gEPQ==
X-Gm-Message-State: AFuF++m/8sadmX99AhNGCcjmMHHrmuqYfDdymupfd1xQsotOahAWAXL2
	6MqDp0mrEu6/AzKN5Leg8+6nPpcOFKPZrbtaXpC8kyLX7Ae1sFWBkdsgqghQXBIE1RrriRen7sC
	JZqWI
X-Gm-Gg: AYBFou3uinm8g6NwX7rONmtOqqT7+VOZYdODfp2HepGCPjs/MIhQ1OZ1osVBEVpTO1n
	jb2orKcEx1eqYg+07nrrKn+wJUhYnaMttX4sjgLUkLwSZipR6OZazjoySc4SibH3JIkE9EeSER1
	9pyTsuW316ATF35TsN5oQNLwWviKkviGTAaIMZREOtGH2N2hvYZ+asaLIvLnBX8YungZCHd3fpz
	IQbLEVYugyYZOwT8XWFJtwFXoS47+w7mjbO2A3aNCoaM849Ejg15IXUrTwRyd4hV8EgPDMWYGpr
	RKYHS2VT4fKM4R3maJE31LvuC0CRW6nfUW4evPkNllmc+Ymx5ptJ1vkcP/ZIpui9MjLRrzwUHP9
	qSn3KTajQp+AeQMHbANs142e9woYZ2IOlJdjDbUHd5FGfLm46M3SY7wgwxDjogap5a8xHTVM1uS
	KfYEgQzC6xfN/E3ZOpCLDMBcqzUKHhWJu7oxm09KZZTb2jJc8OIdHEQLamOSVSTX0rFkhIIFsU0
	xop4NQagsMwVSPDp5BRWGQ5P1k=
X-Received: by 2002:a05:600c:3e05:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-4a0276a0e94mr48124685e9.26.1790950060260;
        Fri, 02 Oct 2026 07:07:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.thefacebook.com ([2620:10d:c092:500::7:9b19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm62670135e9.2.2026.10.02.07.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:07:39 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH] mm/damon: use damon_get_monitor_folio() for hugetlb entries
Date: Fri,  2 Oct 2026 10:07:27 -0400
Message-ID: <20261002140727.701709-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Price <gourry@gourry.net>

Hugetlb folio acquisition is open-coded in three places:
  - damon_hugetlb_mkold()
  - damon_young_hugetlb_entry()
  - damon_va_probe_hugetlb_entry()

DAMON already has damon_get_monitor_folio(), which paddr uses to
get monitored LRU and hugetlb folios and to filter them through
damon_folio_acceptable().  These paths bypass that check.

Use that helper in these paths too, so that DAMON acquires hugetlb
folios and applies its acceptance policy in one place.

No functional change intended. All callers reach these paths with a
present hugetlb PTE under the page table lock, so the folio is always
a mapped hugetlb folio and the helper always returns it.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/damon/ops-common.c |  6 ++++--
 mm/damon/vaddr.c      | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 77366f42b3e5..f986d79391e4 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -140,9 +140,11 @@ void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 {
 	bool referenced = false;
 	pte_t entry = huge_ptep_get(mm, addr, pte);
-	struct folio *folio = pfn_folio(pte_pfn(entry));
+	struct folio *folio;
 
-	folio_get(folio);
+	folio = damon_get_monitor_folio(pte_pfn(entry));
+	if (!folio)
+		return;
 
 	referenced = damon_hugetlb_ptep_mkold(pte, mm, vma, addr, &entry);
 	if (mmu_notifier_clear_young(mm, addr,
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d5dde97b3cd0..b549496ea8e2 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -411,8 +411,9 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (!pte_present(entry))
 		goto out;
 
-	folio = pfn_folio(pte_pfn(entry));
-	folio_get(folio);
+	folio = damon_get_monitor_folio(pte_pfn(entry));
+	if (!folio)
+		goto out;
 
 	if (pte_young(entry) || !folio_test_idle(folio) ||
 	    mmu_notifier_test_young(walk->mm, addr))
@@ -660,8 +661,9 @@ static int damon_va_probe_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	if (!pte_present(entry))
 		goto out;
 
-	folio = pfn_folio(pte_pfn(entry));
-	folio_get(folio);
+	folio = damon_get_monitor_folio(pte_pfn(entry));
+	if (!folio)
+		goto out;
 	damon_va_probe_folio(priv->ctx, priv->r, folio, &entry, NULL,
 			walk->vma->vm_mm);
 	folio_put(folio);
-- 
2.55.0

