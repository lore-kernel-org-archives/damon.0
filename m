Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E36248F48;
	Fri, 22 Aug 2025 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883270; cv=none; b=SAz/V30h/Pz7aqYcY+5e616WvBYEjDegkV/F/TAO61V6UCO2cdz5vfSKpiJY7C1b75ZbXlbLbDwBwcU8kA9QTzP5S3cDjkIeRNtg7yseHffe7oMtD4ctEphqpQvtdfZ11JIdy11D71ynUvDMXJwtJThbYZRFT/r0QO5zCqtyWHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883270; c=relaxed/simple;
	bh=ZImj3pjcYuC2ihJZo92yeY0fuEGYuXc7qZ1H0GE4D34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAnGm5x7+YYaO3JjImLWb0STVUtQRp5qJyMSeTkKyLpYp/+7SkAGyVIHP1OH5opErURSZExADAHnBGYhvB6bcfJ4OR8M6LYy/GNdARs5SNCJWtIWr0kw6wyx8Ow40A7cvmnCNoFQvNTi2f5qBlednDJQjIws84EwT2bm+6uB/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U88LAdsT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U88LAdsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BA7C4CEED;
	Fri, 22 Aug 2025 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755883269;
	bh=ZImj3pjcYuC2ihJZo92yeY0fuEGYuXc7qZ1H0GE4D34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U88LAdsTJUm1l/MTizSKP6oUQ3Htzz0sjYBWkSHEKk3dYvNK+5a4X++WJUqfFLOpR
	 a/0qT8uuJcJYFZmDuwKoU+HngpPEm4rABiiWLp0NwjnycF3JTrjHjl8wzAQ4GENfPt
	 T8DRqTpfCso4pA0qrwiEllba4qK+ZTFF/MsHHyQO6ifMrLmAdQdxJ01G88VnowxySo
	 kdgXDuDbxry+dk14E9/kOQ6Eb8lcNCQv/Z+GAccUdv6kYSndGlyRpSRaQWlKrN+Nxu
	 iz6E+4qTobnX4H5Gx/KD0kTJ244st+C2gWSSGk0Vr6lZQ4NeirIM8iPjsHqTw7swyI
	 s47KU38XvZKjQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH v2 00/11] mm/damon: support ARM32 with LPAE
Date: Fri, 22 Aug 2025 10:21:07 -0700
Message-Id: <20250822172107.53905-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822093420.2103803-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 17:34:08 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Previously, DAMON's physical address space monitoring only supported
> memory ranges below 4GB on LPAE-enabled systems. This was due to
> the use of 'unsigned long' in 'struct damon_addr_range', which is
> 32-bit on ARM32 even with LPAE enabled[1].
> 
> To add DAMON support for ARM32 with LPAE enabled, a new core layer
> parameter called 'addr_unit' was introduced[2]. Operations set layer
> can translate a core layer address to the real address by multiplying
> the parameter value to the core layer address. Support of the parameter
> is up to each operations layer implementation, though. For example,
> operations set implementations for virtual address space can simply
> ignore the parameter. Add the support on paddr, which is the DAMON
> operations set implementation for the physical address space, as we have
> a clear use case for that.
> 
> [1]https://lore.kernel.org/all/20250408075553.959388-1-zuoze1@huawei.com/
> [2]https://lore.kernel.org/all/20250416042551.158131-1-sj@kernel.org/
> 
> Changes from v1
> (https://lore.kernel.org/all/20250821105159.2503894-1-yanquanmin1@huawei.com/)
> - Set dst->min_sz_region as src->min_sz_region in damon_commit_ctx().
> - Fixed the incorrect 'min_region' in the commit message.

Thank you for continuing this work, Quanmin!  Now the entire series looks good
to me :)


Thanks,
SJ

[...]
