Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F75401A3B;
	Thu, 15 Oct 2026 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081934; cv=none; b=icYV27Rch0tKJsKFFvsscjPWLpqRzoTdxCyWtoDYdt7Kq3nGfsbKJb6OkA4Yr/M414Hnj15XDMBUX0c2FxKubxznVrAZF1Gxb19WHjMzdyHeZrgkNqxJj4Ba9thxye+r403hosvpZesZEqXv+TsA7D9aPNt0Y3AHxJs8K82paaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081934; c=relaxed/simple;
	bh=iwAp1WxneTu40UtJSubGmq22Cuaf2WoUTUwAQPE2bjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DSr07EBT7/LXA8pYYq+zlASu7KTN+cOshlVAPbK3LBKx8l9ydqQYKL1zQIh3/UBiNPSKZlSbXMT9eHF5KhxdoujbjzTbbmPn51Teq3wCeZvyryImFhHFPawjU6vR0w7j6UzaHD6rQKvUiuM333GdXOubmrptISBXn7/4eWZ6qDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKtG+cuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKtG+cuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDA51F000C4;
	Thu, 15 Oct 2026 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792081922;
	bh=5UDMqtw54d6/qy4Jttb/86PiM7pxwIVD6wfg8FpzVr4=;
	h=From:Date:Subject:To:Cc;
	b=AKtG+cuEdRdcHnI2bC9bkgGF3tcrhkLVvjO7KAu+Mvox/wFJrc08B+bbuDtA+pSYu
	 w547Fh20Y0EEBt80AcvTVFG2SRwxL8vZ6ezaZiy/Tbaa7inRyOaJjNFIFjnkruMBqG
	 IgTRdEEyhXLG6xYY02WY37Yr8eEQ4XcLNetTuPAJUfbW3DfcurY3yoWv9zu3s1H8Ft
	 gXRsrGh6y3KJkDTNHbxd2T5uPaIGn/EuiJATuxCXERky+Jx6s1evOe2asYn/mnyPin
	 WRRZytq7GvUNYB6pz0doME6W1qYeU5BV9Y/pX/dXQb1tEO8Oen9CpHZmDN/8EmL4Id
	 vyQE627BQ5kcQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Thu, 15 Oct 2026 18:31:46 +0200
Subject: [PATCH] MAINTAINERS: exclude DAMON docs from MEMORY MANAGEMENT -
 MISC
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-maint-mm-core-x-doc-damon-v1-1-226decb5cd0d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPH/0GoC/yXMQQrCMBBG4auUWTvQBFJKr1JcxMyvTiGJJLUUS
 u9u1OW3eO+giqKoNHUHFWxaNacGc+koPH16gFWayfZ2ML1xHL2mlWPkkAt4Z8mBxcecWKx4Nwg
 cMFLrXwV33X/v+fp3fd8WhPU7pPP8AIeilvt9AAAA
X-Change-ID: 20261015-maint-mm-core-x-doc-damon-d2da56de5ee8
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=vbabka@kernel.org;
 h=from:subject:message-id; bh=iwAp1WxneTu40UtJSubGmq22Cuaf2WoUTUwAQPE2bjw=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWRd+P/71SZvpcea//dwy298qs6+es2+psN/ZEw3vmHXM
 cm8kRSc2Mnoz8LAyMFgKabIUr37hKPoTGWPaR6+H2EGsTKBTJEWaWAAAhYGvtzEvFIjHSM9U21D
 PUMgQ8eIgYtTAKba4yT7P+OjOjsM5SK3a11V08sQ0G6J3VFmcCJk52fzjNM+uVaHvD+lnll6YIt
 1TdVLj02n3sq9rNub3L3fPej74Sjl4Nj1BndYDbfpML1Z/dKdy+HGS8+Y1XkfFmkkH0lI3/po+p
 wT3yNcOS3evTu+Jqox9KtYvYjMnhJHz7nVmyYVs+zax1KtUXW0KUfQOtslbce8ih/Lpsb8K92QO
 iFi49s/qyruHHu27Zs/A+sWd6XQNZ+0snSbFT9Gxt9vvem8WO90Xvb6WQ4fLX8Jf12mk5i9JCvN
 Jcne+ReH8zzdbpNgnvmPxH1M1aSid8jIsfEu7T6/3VLZ+P+s0G63Jc4m00Jvp+30u3whdcbar5r
 pK2dYAwA=
X-Developer-Key: i=vbabka@kernel.org; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664

MEMORY MANAGEMENT - MISC is a list of misc mm sources and also acts as
catch-all for the mm Documentation subdirectories. Documentation for
DAMON is well maintained within its own subsystem and also actively
updated, so there's no need to Cc all MISC maintainers for them as well.
Thus add exclusion entries for them.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
I'd love to have the time to check the DAMON documentation changes, but
it's simply not happening, so this will save some mail traffic for me,
if others agree.
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..cbe565b353d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17269,6 +17269,8 @@ F:	Documentation/ABI/testing/sysfs-kernel-mm-cma
 F:	Documentation/ABI/testing/sysfs-kernel-mm-numa
 F:	Documentation/admin-guide/mm/
 F:	Documentation/mm/
+X:	Documentation/admin-guide/mm/damon/
+X:	Documentation/mm/damon/
 F:	drivers/char/mem.c
 F:	include/linux/cma.h
 F:	include/linux/dmapool.h

---
base-commit: d6d3455d8751854e0d1820f14184682e23ac4475
change-id: 20261015-maint-mm-core-x-doc-damon-d2da56de5ee8

