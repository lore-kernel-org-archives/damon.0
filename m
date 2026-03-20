Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C12EBBB7
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773984277; cv=none; b=oq59/U8BMteor2tJd5G+OCDYxyaKHtVQ5j+Bd1GkahBpAL9l+5NkxuVmqbObKksmMGjXrSs0K5bdNNUdaGnRDmbCBrHeGJ0MG+pmX188dYTAX1deLyscRVlqAOUeNUF9iIpVP9vI1FZd0lW+m0lgfgxclVO13qVJ31oByuhYNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773984277; c=relaxed/simple;
	bh=XTy61AdYWWJdbL/8/InZlSZnoZsdovmZHMW+Vr904Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPY8W8tO/1EP+4zM0rEEqoNCJ4vcomDoFR6g+A6oSOtoeEENUqKqAHDU/oMg/Qu3/M7IDe6gNgWiqkg0RcVka928yMUZY7m+v0iMgg0c7HkwWMjBE7baR8myO9t6+dZRA0G172ybcSAI2udGvE39Bx6kulZRkiEG7bE8PFjKR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCKrEwFh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCKrEwFh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b061b6cf36so1783255ad.3
        for <damon@lists.linux.dev>; Thu, 19 Mar 2026 22:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773984276; x=1774589076; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMXG2iiWDtSJZMsB11hiOBrR4Hw4ibVnoY6QikWleZY=;
        b=gCKrEwFhWerB+t2YYhDfMyl83G72B1xB5VDN6HuuHZSt08PTDFC/CB7IKHKMK9BIgn
         c6TtKdCnZVONFtZAdLQvhWxHMkzbRtigUbUft+MgQZ5bA3AKgZuaUF6Mzo2DXYumVxle
         ZNNv6hASQytVcT5SaGtQU+F2Ie4l0gusuvANu4N2LInIDhR8WnObVoqwNg1yaNvvXJF7
         m52m4UG1LW+zJkvWGq1PjZ07vMtb/PGgOj1YBTlO1+InCvLmHDZHExNr4VZc2ceDvDWN
         qVoF4uZBt16sAK/92BLB9RzrkNGHyXkyuJD3XZRunrWOJClD0jibZhc94hwSq7Bz9R1N
         SLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773984276; x=1774589076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMXG2iiWDtSJZMsB11hiOBrR4Hw4ibVnoY6QikWleZY=;
        b=V5vPXS780NNrMy72HJk4UkB4EcXjCD7PnQ/DbZFsWu0p/PeKeSlC7Ht2j/6kvQ+OBj
         z4Vz50kizXz5JPJorKk4kUF7kob9pMKkoMjE4pWQ/Ewm+tvmDHHfQiROL7yYgREbYTIj
         oCObC1gBIEW9miDRhiWNQn0G0yrw79qCKzyCFnvU3ba9mzg1xt5xnDF0Rd/l08UH6Aso
         /CKx8OII4d6mDzi633udieJwlYl8dVPGhH+06Flsoj0L9hvoL9BYDqtjyw7hbsRbWE1Z
         /VlzKXMmjGOKDfNrItQth/Caqr7AXHbqoCA+u9FUE9M92XyyqNpiOsc9Upu/9p6oFCCk
         evFw==
X-Forwarded-Encrypted: i=1; AJvYcCXewhWSJXqMpHDD5r5iKK0g1NoIGWQPgrcgiop9BRR0hW2nZDRqAQUF/pSx/w4Kivvg6J44Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxqxDOZTabvom8X2VOXDpF8S093/QY8OnigaKmKU0u66hB42Ro
	aXPwRcz+8x2Itw/TOqs8d0qfH4t9Sm8aFYokUJ80d3NJitCBbfMRU0yEhtdwF2sE
X-Gm-Gg: ATEYQzzKXMdnGNYYWtf2i9eX5GbiryNGjQG6aB6N4xJmsn8NRZu3uewnboIZpVq512B
	OFRcuwVMYiRO9RYvKWfm0slOOY+TPdkgiiq38amrUk6yLauzPIx3s+BndgXilVO8UWs4lrV6ZJH
	ty/ClPU1V+LrYItL0l3tAoSMeN1Bae2/a4Av7fHbsIDaPJiUSqy6BQm5DEVkgdpQ5e3DrNTt/VV
	qF5t8YAXas+/lKrqjz5H9mrHwFqKHF2cOPScZESDh2e50bt6rIGhztC0UQDM4hqQzzgbS2Ss8Zo
	9DgTy2MVRJayMHmrVu1EOAAcgu/jxxsYJ7rbreZZfMDZeWWdkyR40H1tA4QpKT8l6CyjKlKCJwU
	x36TykxTE+mV9Tj4uk4W94DeQ2Vb99lDPhxcyxmvCy0Fd0903wf+Nu1+G1uCl5tCPMpTAybltoI
	6EmI6tRwIr8WkEBsU/wRxaW2gfbhoTIjKVCR6TIxyCZ8sW+u4sI+Q=
X-Received: by 2002:a17:903:191:b0:2ae:8272:deb0 with SMTP id d9443c01a7336-2b0826feb3dmr17511375ad.15.1773984275780;
        Thu, 19 Mar 2026 22:24:35 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352ae70sm10024185ad.23.2026.03.19.22.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:24:35 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH] Docs/mm/damon: document min_nr_regions constraint and rationale
Date: Fri, 20 Mar 2026 13:24:28 +0800
Message-ID: <20260320052428.213230-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current DAMON implementation requires 'min_nr_regions' to be at
least 3. However, this constraint is not explicitly documented in the
admin-guide documents, nor is its design rationale explained in the
design document.

Add a section in design.rst to explain the rationale: the virtual
address space monitoring design needs to handle at least three regions
to accommodate two large unmapped areas. While this is specific to
'vaddr', DAMON currently enforces it across all operation sets for
consistency.

Also update reclaim.rst and lru_sort.rst by adding cross-references to
this constraint within their respective 'min_nr_regions' parameter
description sections, ensuring users are aware of the lower bound.

This change is motivated from a recent discussion [1].

[1] https://lore.kernel.org/damon/20260319151528.86490-1-sj@kernel.org/T/#t

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 4 ++++
 Documentation/admin-guide/mm/damon/reclaim.rst  | 4 ++++
 Documentation/mm/damon/design.rst               | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 20a8378d5a94..3d08baf9802c 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -221,6 +221,10 @@ But, setting this too high could result in increased monitoring overhead.
 Please refer to the DAMON documentation (:doc:`usage`) for more detail.  10 by
 default.
 
+Note that this must be 3 or higher. Please refer to the :ref:`Monitoring
+<damon_design_monitoring>` section of the design document for the rationale
+behind this lower bound.
+
 max_nr_regions
 --------------
 
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 8eba3da8dcee..153bf42645dd 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -204,6 +204,10 @@ monitoring.  This can be used to set lower-bound of the monitoring quality.
 But, setting this too high could result in increased monitoring overhead.
 Please refer to the DAMON documentation (:doc:`usage`) for more detail.
 
+Note that this must be 3 or higher. Please refer to the :ref:`Monitoring
+<damon_design_monitoring>` section of the design document for the rationale
+behind this lower bound.
+
 max_nr_regions
 --------------
 
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index dd64f5d7f319..68a25e07203c 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -165,6 +165,13 @@ monitoring attributes, ``sampling interval``, ``aggregation interval``,
 ``update interval``, ``minimum number of regions``, and ``maximum number of
 regions``.
 
+Note that ``minimum number of regions`` must be 3 or higher. This is because the
+virtual address space monitoring is designed to handle at least three regions to
+accommodate two large unmapped areas commonly found in normal virtual address
+spaces. While this restriction might not be strictly necessary for other
+operation sets like ``paddr``, it is currently enforced across all DAMON
+operations for consistency.
+
 To know how user-space can set the attributes via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`monitoring_attrs <sysfs_monitoring_attrs>`
 part of the documentation.
-- 
2.53.0

