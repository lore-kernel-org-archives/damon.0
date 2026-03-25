Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257EF371045
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424292; cv=pass; b=pAbdhu85NYUcFH5IFvceIIxdTm6dBZAR4YXoadje1Mqfb8UeUKzqr/WN1Z+P8OCJvcGFdtx5EUKhhh+1wpbfPCcSvlhMYAqHRzrTwoXY4Nky/l2j3WBr/LqfiCTOTgX44yksm354L0Hw7D3J7m262At2J9sVp0lzTaXW3e6Nrrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424292; c=relaxed/simple;
	bh=fvig4eFevfJjwx/nJkV2dv56m5ztYzm6Qqmo6Rpj0CI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e9q8olwwXSzeae0fGQfgT2cO9ABNdgotEKxWDOTmyHnJKV/EN93BNTgKFmLXi6o7B9bycO6X4CaHJes1AB+v1EPNoBJv7h0jzwD50X5rfOncxh5CUnHv5H+streRPd1cWEtc6FLa6hB7Go8Aa3hvq5yj40DpatDwHNJqwZgjuSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Fx1OVqB6; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Fx1OVqB6"
ARC-Seal: i=1; a=rsa-sha256; t=1774424284; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=QPL3xoec3+J16npX/yz/2M5R3W1E6C3tR1py4XzMlTvaCFq4LUuzPH2gTSiT+3/ZHadMhEuco1CCIiEHXBeEvrShTlo6BrX49OBwKJ7TDdQkx7zuNjrLcRmptyCPkRTQVJD/o3pPe19zjt4wNowSXcvPqpHoJsbU6E17CfLrM4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774424284; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0kayvcEZaNNI6TyXOdbY7FEWhmp/oITq1MJpxJ5exok=; 
	b=gVGMeEifXtiSW/dOGM8LOOBNr3STQQ8iAcdz12Np9Tr/zLl6x3XJrJar1/BWWOePbbkQA/3LgOAwnEEiC6xhXIEmrYM0llK/ey0iVpBDI2Xb+4nxJDmM1suFdA/32+dBhXkgLE0GY4RwoKQ/MN3oVAsEmAFt/6JCEn+GRA7Rvvc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774424284;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=0kayvcEZaNNI6TyXOdbY7FEWhmp/oITq1MJpxJ5exok=;
	b=Fx1OVqB6WtNEBn8pwvSs1o03QLWi9WcRTJReosKdlkqH1w27ArGsuvpYIAkH2G2C
	fzdSrB1r/2qqBuKHu2Thr1mlXtPWmuoa9i3eSqHm62RaKTQK5Xl7xBpyB0BWgnwjOXY
	XPrjkz6DCePqPIrr/KqeFWPy6xEKmmUBwHMd5kfE=
Received: by mx.zoho.eu with SMTPS id 1774424281840800.3483260836631;
	Wed, 25 Mar 2026 08:38:01 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 0/3] mm/damon/core: small cleanups
Date: Wed, 25 Mar 2026 07:37:57 +0000
Message-Id: <20260325073800.141756-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Three small cleanups for mm/damon/core.c:

1. Extract duplicated scheme-index-finding loops into a helper.

2. Use the already-maintained damon_nr_regions() instead of walking the
   region list to count in damon_commit_target_regions().

3. Move the static last_nr_regions variable in kdamond_split_regions()
   into struct damon_ctx so each kdamond tracks its own state.

Josh Law (3):
  mm/damon/core: deduplicate scheme index lookup into helper
  mm/damon/core: use damon_nr_regions() in damon_commit_target_regions()
  mm/damon/core: move last_nr_regions from static local to damon_ctx

 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 54 ++++++++++++++++++-------------------------
 2 files changed, 24 insertions(+), 32 deletions(-)

-- 
2.34.1

