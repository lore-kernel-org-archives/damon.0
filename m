Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3935E1AE;
	Tue, 14 Jul 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039756; cv=none; b=QKZkWsW6udgp54XRllZB9+2FkmRA7lMK/rxymzWNUqo+lZZKPDAnK2Wqe3dil6Rcmv6NYbl8COPO25CSzY3dRLTcgd8MmgOMAnuqLBgnax1WkjmoAiDcG/fDGxpmn9SG+/5Q9mBgkhE5GNdXXEaLY/OHpcrfg10Yi8WnJJaec/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039756; c=relaxed/simple;
	bh=fu4rX0sucrNYxb0wQo+OGMJNku3uz4oeRu7UN4CO5Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0fuUuIHNLEhjdR4sZbqlYImdxW/Rs8UUeUj3PlPGFwu8SwWASlxKred5q4mOPLlSW2yNn/5FvkaeTZ/eDSDUwvUPAYyHb4TdbqTlK3E4IFTuZ4n+1gGrY8n7KgUDB8YmSHRJWG8eKS2ZIkpoaWDNuFxWCZaADUq52tEYl85dRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE6LKRDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE6LKRDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DF31F000E9;
	Tue, 14 Jul 2026 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039755;
	bh=BL9Gxm8Mv/zd9x7MZsEklN154y2t4/YkAY5BKQKrvgM=;
	h=From:To:Cc:Subject:Date;
	b=eE6LKRDTtiHq1wR48G6wWZe/4+45GdqWe+7vNBA7shEax/GB77NATk2vFuS9iQsQS
	 rR6fqCtv0inb9K7uuL92T2QrFqBOlY85AjGERbZfLEbPYACw90/4jlV7bVIBIBTFW+
	 iYmksHeTst3/IWysTwFmOGSeKIa8aR1TY+Tn8K3P9zo66GhaYgys6osSF8x+DWs5IR
	 4LiHCIUeEV2LzhY+997Ii+bmz+TgUKkvjzWuCFMmPWfTOL9CMM96SPChhGA4taTPbt
	 mb+T6ehY1zr40/5hv4FLHaBLlpuhMq4cZlbQlRQ/T1H8rJEwk3HUCzOLgvFQ5ngtOo
	 TnDjtR3+Bh/Dw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/10] mm/damon/core: hide core-private struct fields
Date: Tue, 14 Jul 2026 07:35:33 -0700
Message-ID: <20260714143544.101305-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core structs hide core-private fields using 'private:' comment
tags.  It is incomplete and inconsistent.  The linked list heads in a
few structs, for example, are intended to be hidden, and always be used
using the wrapper macros like damon_for_each_region().  But those were
mistakenly marked as non-private.  A few core layer-only fields were
also mistakenly added as non-private.

This only encourages callers to directly use the private fields.  It is
easy to make mistakes, and difficult to control.  Mark all such DAMON
core struct fields as private.

Patches 1-8 mark the private fields for damon_region, damon_target,
damos_quota_goal, damos_quota, damos_filter, damos, damon_filter and
damon_probe, respectively.  Patch 9 removes DAMON_SYSFS's direct access
to core-private field, damon_ctx->ops.  Finally patch 10 mark the
private fields for damon_ctx.

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260714043437.95811-1-sj@kernel.org
- Drop RFC tag.

SJ Park (10):
  mm/damon/core: hide private damon_region fields
  mm/damon/core: hide private damon_target fields
  mm/damon/core: hide private damos_quota_goal fields
  mm/damon/core: hide private damos_quota fields
  mm/damon/core: hide private damos_filter fields
  mm/damon/core: hide private damos fields
  mm/damon/core: hide private damon_filter fields
  mm/damon/core: hide private damon_probe fields
  mm/damon/sysfs: do not directly access damon_ctx->ops
  mm/damon/core: hide core-private damon_ctx fields

 include/linux/damon.h | 110 +++++++++++++++++++++++-------------------
 mm/damon/sysfs.c      |   2 +-
 2 files changed, 62 insertions(+), 50 deletions(-)


base-commit: 4c0f8c26ecc149f268b6c488e6cbde2a4e58160a
-- 
2.47.3
