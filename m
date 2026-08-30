Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F13A5E87;
	Sun, 30 Aug 2026 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788107651; cv=none; b=VgNBHCNMQqBt30FkOtcgDDrusGrg1AL/L30EkWHrzXrcOM1im5/bSaavTeKuznGfn+AS//C09XKCyB3YYLltJZ39IrDJ+QqBxxl43WfNO9iK7pFFhoZvLDrSdfmkCtZb5TObwxkXPhJPy4LZr1wnroZ2ei8NA71Ar+uEhHj7U/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788107651; c=relaxed/simple;
	bh=gmDn/tQ9jYjV/1c5q63d4WoLrXnnpIkgjJ7a6SB5rNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMPqHY243Y5SKOkWcC0OFusw54JW+Fd9uH+YGMVOQnrXqWHpGlqYwU/OAtRmYPkSJ0+tlnkI5ybph+s3zqj1+0oflxYr1LINyI7wv/rTcVxyGDjWzvhhoG6+iENjQQhowwNF3ghZjT0LYhmR/nr0lbYLqdQDbMTOZ8bDA6FSjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxFUMVqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxFUMVqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15CD1F000E9;
	Sun, 30 Aug 2026 16:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788107650;
	bh=ItGHUO2m/wmnNvVoRrFldiDP+k6ZywGIW41EylHx9I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PxFUMVqQme8ZR/LjwyLecA1wNS25gKULYLUoMH/171OfiURmUbbJkJY3lgKhufDtF
	 oCBT4khp0yKRX7dwHqg7xW3DdsbLLGtP444F4FBQc+6BcME7Y7suEPA1sJmkhwIOJL
	 eyzSJs4YuWLAWl4xgQdZSpYb575/sfm/+L6iqDhgQPvfK2g4/FHTum0EBMfxeFdkYj
	 FeikZy/UHCt/OTzpTYUWK1uxk8DEidehJ2XuGlzVPBA+eOzOvSncdPQ0bpOW1D9qfb
	 +G06DBTBkTFkoBVF77xZr1663/9ZK33kDX5eOGGdT0Gl8KFmSBI3Aih+DNBzWO5+ob
	 k5hBInrZzqorg==
From: SJ Park <sj@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/damon: move damon_hugetlb_mkold() from vaddr to ops-common
Date: Sun, 30 Aug 2026 09:33:57 -0700
Message-ID: <20260830163358.102281-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830051407.50008-2-kiyer@crusoe.ai>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 29 Aug 2026 22:14:02 -0700 Krishna Iyer <kiyer@crusoe.ai> wrote:

> damon_hugetlb_mkold() clears the accessed bit of a hugetlb-mapping huge
> PTE and propagates the aging to secondary MMUs via
> mmu_notifier_clear_young(), spanning the whole huge page size.  It
> currently lives in vaddr.c, and is thus usable only by the virtual
> address space monitoring operations set.
> 
> The physical address space monitoring operations set will need the same
> logic, to support access monitoring of hugetlb-backed memory.  Move the
> function to ops-common as-is, with no behavioral change.  A follow-up
> change will use it from the folio-granular rmap walkers.

Looks good to me, thank you for this patch!

> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
