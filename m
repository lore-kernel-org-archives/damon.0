Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616721990A7;
	Sun,  7 Jun 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780853814; cv=none; b=c1gzA9Hf5tEi1TBv4VgyqkJ36/NG0ERsfXlQ1gad+CGNhyIKopi4/k9xMl8ylZ3etdb+1NR6v1+Y1aAsuHSimNSNKMgGAjYNfthKs3qcw8fJy5jetqNK2B7rW2C81hWquiaVr8/9LqZIqzVW6x0fao37BtArFRQG6tPBH2F0pHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780853814; c=relaxed/simple;
	bh=9mrYQ9q5fuJek6ZBAZ3LWZ67bu314SIVdn4QAmQ79NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7OqFcQ80lJnAYveqCMvCmBx8IvFyk9A47h94LNxXfSmVX02X4TdYOSlPPV8t9jXML48l6C5nN642ymjaaLevrBQK31AacDtpZC1wIaKgVERKaDpSZaNd3EprhaQJ78fMlQNSUCpyG9WIZLvb/i0SKapdNGH3ZgV5HMC0Iu8paM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv3HEGr5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv3HEGr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8DB1F00893;
	Sun,  7 Jun 2026 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780853813;
	bh=52SIwcd9Prvxu4y3GXU1hVE6SDvGCfin9Q9wjcWOubQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lv3HEGr56u8JGKcD5qnIgVON54GoCgMtVH94rdgRP9So9LKvoOI08KozG7d5XYh2X
	 rPPLhDmrrdRIuTCZoFdk4LA+VNBVyMWDACfxV58WObjyjyJoxvac3cz7fGG9QUdt1u
	 pVJ2gDDF9H/3mkdcuCU0tCjC/2fKArR7S9bsu6IcpSe00Bkp/ETrJ8lEzPMWa/iu9v
	 MLEWAKYxPEP3GW6DXicJ3dlirU4NU5GSmbNp7QuCGS+RJmGmKu2AfM+tGHE5IVH6IE
	 8H+RLQgdJYeB2I/jAFkog4uY4vIdPfUoxu1BBoXUbUAk97HtTxiiXUM087/L1Hi6Zw
	 7KDOkt63oDO6g==
From: SeongJae Park <sj@kernel.org>
To: Cunlong Li <shenxiaogll@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: drop redundant mmap_read_lock from damon_va_three_regions
Date: Sun,  7 Jun 2026 10:36:44 -0700
Message-ID: <20260607173644.93883-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260607-rcu-v1-1-3c9f5995a3a0@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Cunlong,

On Sun, 07 Jun 2026 21:48:52 +0800 Cunlong Li <shenxiaogll@gmail.com> wrote:

> __damon_va_three_regions() already walks VMAs under rcu_read_lock(), so
> the outer mmap_read_lock() is no longer needed.

The function aims to read a snapshot of the virtual address space.  So I think
mmap_read_lock() is still required.  Please let me know if I'm missing
something.


Thanks,
SJ

[...]
