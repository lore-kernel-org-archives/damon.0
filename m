Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B573A261567
	for <damon@lists.linux.dev>; Tue, 11 Feb 2025 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297188; cv=none; b=Dpur6fwp5HBytw1Vxcm1/h/sY4e4tEN13Z0OcIFA+j+f/oaK6SB8BjILJOeqEZ/9NNDLskYu82Ke+596YH0mqfrrEyETULG+MVh0ym3TFaI4bsOwu6A3vv6tBFdKFxIEh0yh3ULozfM/E4Q9DtnbZ/Ynlh1/X3v77mGyJ1DbBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297188; c=relaxed/simple;
	bh=84MAvIM/VeTuYIvj9u6395n1gQVT8MnaIW3O3oOsNEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwfJVNzZYV86XzHDnGt/yuRG+xynxXoBZ1TtlPF4GC84hCUc9YJWIXXbmLIfbLWQM5e9YU6we52shDQkWW9AQ0YS9YP5X0rahnQQIzZUz5Rcf9d31cLRaqDkuy/61YNgvtFomqbxll5eKIH/iVD4ctStDN59GHdbCVmcTjtuSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X77gxoIp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X77gxoIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2809C4CEDD;
	Tue, 11 Feb 2025 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297188;
	bh=84MAvIM/VeTuYIvj9u6395n1gQVT8MnaIW3O3oOsNEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X77gxoIpWDlyoBruk6rMJAx/xSRW34QmHUZQ9Chqcm0cEUupBmeVrZGSQMZmhJlQ8
	 o7n5Am4c8wyu+RIPVITrqoHuJ+HgZW4hqTrMqkFyizjVNvytE67CwFt7yNxCcwUcr6
	 9NHEV6nHP2lnYWh4fvw25z6LnD9n0/cpYTmfVOCfr1SVLsSrL0VtcaGPCx4WeATkrd
	 Qb/RTth4E+6x2yp01hGqIsCXua4ec8nSHsuNvd0koJIRQyXfDHfNhVj4aAhkgei4Fj
	 3pW3xmygL9/Xph1F+wbVBr9LmkYaSpztSPLLplvhNpaNvvV4XLWZ8bDUMWdDHcKkpS
	 KBZx9cDtn1ldA==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v5 0/4] mm/damon: add support for hugepage_size DAMOS filter
Date: Tue, 11 Feb 2025 10:06:23 -0800
Message-Id: <20250211180623.11008-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211124437.278873-1-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Usama,

On Tue, 11 Feb 2025 12:43:39 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> Patches 1-2 from v4 which are a requirement for this series
> were sent separately by SJ and are merged in mm-unstable.
> 
> hugepage_size DAMOS filter can be used to gather statistics to
> check if memory regions of specific access tempratures are backed
> by hugepages of a size in a specific range. This filter can help
> to observe and prove the effectivenes of different schemes for
> shrinking/collapsing hugepages.
> 
> v4 -> v5: (SJ)
> - Drop patches 1-2 which were merged.
> - change filter name from 'hugepage' -> 'hugepage_size'.
> - change struct name from damon_folio_size to damon_size_range.

Thank you again for continuing this great work.  All patches of this series
look good to me, so I added my Reviewed-by: tags to the whole.

Also Cc-ing Andrew, since I think this patch series may better to be queued on
mm-unstable for wider testing.


Thanks,
SJ

[...]
