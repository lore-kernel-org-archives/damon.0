Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2733DEE1
	for <damon@lists.linux.dev>; Thu, 21 May 2026 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339177; cv=none; b=qSt739Xq0ISeL4tPOA+J3lXPzHhOWPnm4sk1uxM3FLHpYgGrpFtvZqnYmv3R1UMfnTyVLGedurY4/HIv8RohUliSUW2xidpQINDZeOTAoMM/dTmf2Y5E+rkA4ATnl0d8bj8Bw+NxW91yStTbRUq4GeUlj3Z4y5oIg3helqFAejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339177; c=relaxed/simple;
	bh=At5+/hD8qVKWYJiNzJI2ynYKgPThmBmsWkv2hNPvzs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNZqsqUxsnbEI2GWgFe9ZWs7CnQSkjV0Z4kPdu0luhKewItAX5Hy6HL7+tKNSgcIJ/OcBl3mxvSjL8QyyFtbEXvMmYJkryIyBVpipd5S5mdMCBxNgsMj4pluZsxZ/eQGO2qsuLG4GQsbPX1eSoNkGiu7uOFCvveYO8FrGruaQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uARqszmD; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uARqszmD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779339172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N7qfxh/zfMOAlXTKCwcPQJBPsWRq4EyvbHE/YRBH0T8=;
	b=uARqszmDfkqT1jfFDWvswzOrjg5aZWiOcyLKMsZb86BzRZynvJdgn61Eez2N9NDFgZHj2B
	TIzgkZy5eO0Y+tthvD3YJwx+8+YWEUogOBXkfAlvp5o6qeyVp4Pqwoq7pwy2AKWqqzgOxy
	8ga6myNIfl4HRMLojD2HcmOEn5tn5tg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon/core: detect internal variation above max_nr_regions/2
Date: Thu, 21 May 2026 12:52:22 +0800
Message-ID: <20260521045236.115749-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

kdamond_split_regions() bails out early when nr_regions is already
above max_nr_regions / 2.  A large region that picks up new internal
variation after that point never gets split, so we lose visibility
into its hot/cold structure.

We hit this with damon-paddr on hugepage workloads and damon-vaddr
on processes that mmap a large anonymous range.

On our production tree we added a current_nr_regions counter (no
good upstream home for it yet, so it's not in this series).  We saw
nr_regions never getting close to max_nr_regions, and the picture of
the access pattern was too coarse.

Example with max_nr_regions == 1500.  A target ends up with 799
small hot/cold regions plus one big region (an earlier merge
collapsed a uniformly-accessed range into a single piece):

H:hot
C:cold

      r1     r2     r3                 r800
    HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|

    nr_regions = 800  >  max_nr_regions / 2 = 750

Now a cold subarea shows up inside r800:

      r1     r2     r3                 r800
    HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|

The small regions can't merge with each other (their access counts
differ), so budget never frees up.  r800 can't be split because
nr_regions > max_nr_regions / 2 returns early.  The cold subarea
stays invisible.

Patch 1 lets this path still split regions that just changed
(age == 0), up to whatever budget is left under max_nr_regions.
If a split turns out useless, the next merge cycle undoes it.

Patch 2 adds a KUnit test for the case where nr_regions is already
above max_nr_regions / 2.

Jiayuan Chen (2):
  mm/damon/core: split age==0 regions when nr_regions exceeds max/2
  mm/damon/tests/core-kunit: test split above max_nr_regions/2

 mm/damon/core.c             | 68 ++++++++++++++++++++++++++++-------
 mm/damon/tests/core-kunit.h | 70 +++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 12 deletions(-)

-- 
2.43.0

