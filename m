Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D992F49FD;
	Wed,  8 Jul 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519899; cv=none; b=s4wXqWXGzTfxIbOnHdaw37U4qTnXVqdl4saDnUp2+zCKnRP5CUxGtTXYzfkkTiTHFrtcbQ/HqlRCaqjFqa6FVZRCmfsrBtlNfLh0KwxbOIe/akd1bbH4uFU+L7LVxyqk3VyHYiO6GBeSHYlrm6wqin9zrtSwY+csDkwnQWHLt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519899; c=relaxed/simple;
	bh=g+/R9e8kMmYBEjhykJ/JgMclt/rtf/u35Ssmi+dfqPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzIFMBihu1nHCKP+7MLZFtGRYZwkGDJ5RMHuqH672uQkqmRxB6ktYCn6zBsQTlit+7EN/EIogPrpL0cM3lAe1gtCMJgR2jtbij/GTNnSHJYzK9ZehJU+H2K5KtyBzxeUFnySJ5TBuVM9yHf/PidIftm5FB1mPX5qm5cizBbdGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKK7qS3a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKK7qS3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF251F00A3D;
	Wed,  8 Jul 2026 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519898;
	bh=oYNY6fayT8bgIf+rrVvdnnG8n7vDl1N8Udf7r3kCuck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKK7qS3ayOUoGqbDi/TxN4vTUQ3c46MmEmzbBUj7+5tgh6t0FPyeD7sJH8+N+7eN6
	 n4VRIjKu06gOYUah6DD63yV3pxz98udRx98r2J2kng87LWbCrR47I66j5SxjUDON1z
	 /ifzB/LubUG0VxRxXXb6CxJ9N5VBoNo+xwWi5fjGMTBY6nz+Y/VCnmyHnQITS7R2YW
	 aM72WF9/KZrqnZYjlRNnfJd+gUJmkNOeiZYvX1AAjz7q83GOOCaC2OX/cF28RGnqWS
	 Ux9gp16W04ABGFXsAK6AGep466gRcm7OcBiQxxJ1dgSDMLpQ7LkwTVuWRJBrj2uuz4
	 +fExMa0KST6MA==
From: SJ Park <sj@kernel.org>
To: zjh <jiahuitry@outlook.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: prevent migration fallback to non-target nodes
Date: Wed,  8 Jul 2026 07:11:33 -0700
Message-ID: <20260708141134.123360-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To:  <BY5PR02MB6642F4D1A8BA92BFF3A034B4B5FF2@BY5PR02MB6642.namprd02.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello jzh,

On Wed,  8 Jul 2026 01:07:54 -0700 zjh <jiahuitry@outlook.com> wrote:

> DAMOS_MIGRATE_{HOT,COLD} passes a target NUMA node to migrate_pages().
> But alloc_migration_target() treats mtc->nid as a preferred node unless
> __GFP_THISNODE is set.  Hence target allocation can fall back to another
> node, and migrate_pages() can report success without placing the folio on
> the requested target node.
> 
> Make DAMON migration target allocation strict by setting __GFP_THISNODE.
> This is consistent with alloc_misplaced_dst_folio() and
> alloc_demote_folio(), which also use __GFP_THISNODE for migrations to an
> explicit destination node.

Thank you for sharing this patch.  So this patch is introducing a small
behavioral change.  May I ask why you think the new behavior is better?  Have
you find some negative user impacts from the current behavior?

> 
> Signed-off-by: zjh <jiahuitry@outlook.com>

We as the kernel community disallow [1] anonymous patch submissions.  Is zjh
your preferred identity?  Also, it is not a strict rule, but we as the mm
community prefer using a formal name if that's ok.

[1] https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1


Thanks,
SJ

[...]
