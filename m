Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3E233939;
	Sat, 23 May 2026 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779556824; cv=none; b=QblJAMfQGvU+ns8H/s6CErYA+/M9PeWo7RHXuGhSXh9c+HSIvk89K6OL48rLnbECxZ6uDlEpYYN0yfzZTxon5zXS8tIfv/zPFnP5nNHytKkIYEdn6ildt5wxX858g4APUPMeKHQNuBhUDxOCNBNBL3oWFH9H+q+vXv5UN6J7tgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779556824; c=relaxed/simple;
	bh=2g3L8qNqnriYoIafhBHjnRGx1q+TXMv4NNyUmLzFRWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bi/NCyDiJnMy+sBiN9gWQ1XXvhqZPvD8gGAmnJXrDsxz0LOUXKzNfNWNxwxc9ahXGV32OCyFE68PkdCWT1M84/cmVlwVx2o+E862JjH/EU9dumKLHjzPiKXFl4GkRPKhDxm8h51qgzvEou6IjOcEp7GngH2N8TtKgrPq1SRaMYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdBc6A0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdBc6A0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619471F000E9;
	Sat, 23 May 2026 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779556822;
	bh=Cn46e9sP8RWXe4pDnVCTwvbROxd5cIri5X6KIHPGG44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdBc6A0bU+zDa1mr+anokMrBFvEk195l5VZkRbZje3sKTSqurDhk+5tQ79ST7ZH1f
	 UKOcqGkKlYCjuqxLFhLqMLO59JYBDsIM17pGJYIerqxt/JsaUxlR/AEu3YTVfhidAK
	 j2ga5mx13np4Oqn9IkJ9EZyP4GeYN0DS5ioYp7lIUpnR59Qc919A9BK/kqGdnI6el4
	 3d9XDDDewkRaDxm1VIUUauW+B6m4hFTuLdci78OT9wJVkMKRnjgkgl2kY/dj9Py4cQ
	 8aUBHZf60mIWYKZsQM6P/VN0ny9DDMLoltDI5C06crZFnprHxPYbZYcNXFiOUJPIX5
	 3r0ard6rWw0XA==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] mm/damon: Generalize ctx_target creation for damon_ops_id and add vaddr support
Date: Sat, 23 May 2026 10:20:13 -0700
Message-ID: <20260523172014.89053-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522145518.158910-2-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 14:55:15 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch adds a new function damon_modules_new_vaddr_ctx_target.
> Since ctx_target creation for vaddr and paddr is almost identical, the
> logic is extracted to a new function, damon_modules_new_ctx_target,
> and vaddr and paddr functions are left just as interfaces.
> 
> This change was suggested earlier1 and it is needed to allow
> developers to create DAMON modules that use DAMON_OPS_VADDR targets.

As I commented to the cover letter, let's put this just before really be used.


Thanks,
SJ

[...]
