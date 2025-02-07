Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B5194C6A;
	Fri,  7 Feb 2025 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963239; cv=none; b=pmfLo8Va0z6Fi62KtgrMvIIMYWtwtV8qzSSImj1dhTsgTWk5wumSZtUp2fFemEQ6V3rySQaBzdbVU2dM3BIS4ffZu3tXc96W9LobyINbrNdoowQbrw9VurcSveyQ7+O8iM8zUR+msRiD/ujNhGLqBTINf+YIKRJtU65T5td/Mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963239; c=relaxed/simple;
	bh=xKqNvsnx3tuKSu7o9r1b3TR/eqwZBPe1SkMZAx07Gso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YTJdEVQDqTrfwO9t95r26a6SDbY1mT9gC2elDZCksIxYZvIKHqmH1WTDpPHO9fNyFKVjDodH6aosWFymP14q+Gg7kabgRU8V6tK2KNOz42CTLEtINVk/XbmQd2G2V3Dy9HOmn7L6YigLS/iNgXqdUN9Fj1g+a33JXSONNcVEgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUEu1kUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUEu1kUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B321C4CED1;
	Fri,  7 Feb 2025 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963238;
	bh=xKqNvsnx3tuKSu7o9r1b3TR/eqwZBPe1SkMZAx07Gso=;
	h=From:To:Cc:Subject:Date:From;
	b=GUEu1kUkr5xmAjgVAlNhRuAwZ6If0KD3Oy3aOwXO1Jy8ocoo7tvIQnsg+eh1gLbFI
	 N7wYc/mHNt+Jzhi1cRokMFYF5844ngrmsFMtxHFxl+wcNVj+no1VfhzsZHOnEBYaAd
	 eYQ3zAdCv2gzN7HU/Ca0jCazu6RI5hSJlUBguag4b+CL5ATwN4ms1tCcMAaZQMWWEH
	 JLf0tdv6aHAIzVO+4P17jH2pYmQsHBtB0NTD78GOo758+pcJdH7iWc2i/8nBHyrCie
	 4/Et/N2w/6JmkrXbvZjp9ufS2tuqmCODM8K3im9PpnXIkT71Ih28y32wvZo5PtQoZo
	 EmnzAgNpmSl9Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] mm/damon/paddr: fix large folios access and schemes handling
Date: Fri,  7 Feb 2025 13:20:31 -0800
Message-Id: <20250207212033.45269-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON operations set for physical address space, namely 'paddr', treats
tail pages as unaccessed always.  It can also apply DAMOS action to
a large folio multiple times within single DAMOS' regions walking.  As a
result, the monitoring output has poor quality and DAMOS works in
unexpected ways when large folios are being used.  Fix those.

The patches were parts of Usama's hugepage_size DAMOS filter patch
series[1].  The first fix has collected from there with a slight commit
message change for the subject prefix.  The second fix is re-written by
SJ and posted as an RFC before this series.  The second one also got a
slight commit message change for the subject prefix.

[1] https://lore.kernel.org/20250203225604.44742-1-usamaarif642@gmail.com
[2] https://lore.kernel.org/20250206231103.38298-1-sj@kernel.org

SeongJae Park (1):
  mm/damon: avoid applying DAMOS action to same entity multiple times

Usama Arif (1):
  mm/damon/ops: have damon_get_folio return folio even for tail pages

 include/linux/damon.h | 11 +++++++++
 mm/damon/core.c       |  1 +
 mm/damon/ops-common.c |  2 +-
 mm/damon/paddr.c      | 57 +++++++++++++++++++++++++++++++------------
 4 files changed, 55 insertions(+), 16 deletions(-)


base-commit: 9c9a75a50e600803a157f4fc76cb856326406ce4
-- 
2.39.5
