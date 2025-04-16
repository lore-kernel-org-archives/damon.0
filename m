Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1D419F438;
	Wed, 16 Apr 2025 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777557; cv=none; b=W1+MLLCcb5Xe5MMui41kO8gxrNQP+DaBYwCN3GTXV2TkibvFZ8UmxgpYWCmFrTSPszrvaFy1gSPhie+tsZ7rNB6yWMHjarwLgYO1U0hUO2CLfQ37mmNjaCpVmO2C1ci+LMWS1/PCYbMc7YhcMbKuaURCZb6rqDSyC79Ozyme1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777557; c=relaxed/simple;
	bh=mYG/+R348tZd+dJ2HFrDs46wncUZ9D5vvhSOn3amrJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PDZ+6FEw+I5URc44Top35V2FtBFgIO1WaKXOxVfZy1rbJZyq9h+wxgYZICQ6UUACD+sLnb22Hh3hfFvrp+6i0UBX5kpsyMf9KZA/QUmpzXN+QTdDstqzLxSSZttQ58AlJ5qCc/U1T5Rxufb21lQH3QAeRQ+V3UKHEWt8Ipe3F2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peMo47u0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peMo47u0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3643FC4CEE2;
	Wed, 16 Apr 2025 04:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777556;
	bh=mYG/+R348tZd+dJ2HFrDs46wncUZ9D5vvhSOn3amrJw=;
	h=From:To:Cc:Subject:Date:From;
	b=peMo47u0ongXhI2+Hi541Qw7tSxccSBkOVAeh67fLXCVzr/iNluYMxIZGJz/iVFCu
	 Si+QN4paJgvp/bEYcGiq7N/ceZFKuCL0DACO1UgSgoHl/NkJZBjGJw12tiq4IgJKMS
	 IUg+1kt1lSRocJ4lyuuNTSeNiAMb80bVpLWHWxgF1Qbclp555WZyrF5ts/nxiGxkGR
	 eudUeXvyRSnCXf+pF/8j2iF2yrB71Vhqq8DDxZFpuba0Vt3VAc013AkEAvZwAaITqQ
	 sgW1GuPN3P0rcou8PF3Sph83uqR4IvU2f9SIa/Me6wXIenq+qg6p4YwykWYcIlXMcW
	 t5RjkSfNoV6hQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/10] mm/damon: support address space larger than damon-core address space
Date: Tue, 15 Apr 2025 21:25:41 -0700
Message-Id: <20250416042551.158131-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core layer has its own address space that uses 'unsigned long' for
handling addresses.  The underlying DAMON operations set implementation
translates the core layer address to the real address space that it is
working for.   For example, vaddr and fvaddr translates the core layer
addresses to virtual addresses.

However, all operations set layer simply assumes the core layer address
will be same to those for the given address space.  Since the core layer
address uses 'unsigned long', it is ok for virtual addresses.  In case
of physical address space, however, there can be some cases where
'unsigned long' cannot handle whole address.  For example, 32bit arm
machines with large physical address extension (LPAE) is such a case[1].
Arm with LPAE is the only reported use case, but similar cases could
happen in future.

Add a new core layer parameter called 'addr_unit'.  Operations set layer
can translate a core layer address to the real address by multiplying
the parameter value to the core layer address.  Support of the parameter
is up to each operations layer implementation, though.  For example,
operations set implementations for virtual address space can simply
ignore the parameter.  Add the support on paddr, which is the DAMON
operations set implementation for the physical address space, as we have
a clear use case for that.

Patches Sequence
================

The first patch implements the new parameter on DAMON kernel API.

Following five patches (patch 2-6) incrementally add support of the new
parameter on paddr operations set, for monitoring operations and DAMOS
operations for each DAMOS actions.

The seventh patch implements DAMON sysfs ABI for letting users control
the parameter.

Final three patches (patches 8-10) documents the new ABI on design,
usage, and ABI documents, respectively.

[1] https://lore.kernel.org/20250408075553.959388-1-zuoze1@huawei.com

SeongJae Park (10):
  mm/damon/core: add damon_ctx->addr_unit
  mm/damon/paddr: support addr_unit for access monitoring
  mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
  mm/damon/paddr: support addr_unit for DAMOS_LRU_[DE]PRIO
  mm/damon/paddr: support addr_unit for MIGRATE_{HOT,COLD}
  mm/damon/paddr: support addr_unit for DAMOS_STAT
  mm/damon/sysfs: implement addr_unit file under context dir
  Docs/mm/damon/design: document 'address unit' parameter
  Docs/admin-guide/mm/damon/usage: document addr_unit file
  Docs/ABI/damon: document addr_unit file

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 ++
 Documentation/admin-guide/mm/damon/usage.rst  | 11 ++-
 Documentation/mm/damon/design.rst             | 16 +++-
 include/linux/damon.h                         |  2 +
 mm/damon/core.c                               |  3 +
 mm/damon/paddr.c                              | 95 ++++++++++++-------
 mm/damon/sysfs.c                              | 26 +++++
 7 files changed, 119 insertions(+), 41 deletions(-)


base-commit: b32e0b4ccfbe176a541e7feee0cdaebb957738e7
-- 
2.39.5
