Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22205946A;
	Fri, 12 Jun 2026 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224442; cv=none; b=roMDMbYuXuFqxrdeCx+H0i00Ffxbglg5NQ9DllOs1R1B3cAhE3hSDdEIwvFs2442/X3hOx9OrtrbwMknzcuwHlc5aELestAX511t6Y8yPU86FF1xyn0uczIR0jJyD+bzR4oDw8fU65ZIuw+Nsdf1txqVXEGLZBtSCnsjJp30KIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224442; c=relaxed/simple;
	bh=l6b3jTFoUEOAjQme75PyP1mJn3pWsyE9Sywf6bNy1Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJRFHGMU4soTS/4GNoKmxBsZVqR50WImIX6SkSvBienOTXbfpGO2f4UfxLzB7TyAlB7nU30RducUwkrpwHV1DmXsXcftfelHP18yIEj88G+F1z8v88BLdKyfmIImw/wDTy1Eo4zL/3Bzo/P8EPTKHOEDWRa+Tuk74kWL+ZJCeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgAqQB3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgAqQB3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621521F000E9;
	Fri, 12 Jun 2026 00:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224440;
	bh=G0OzEYWLN58a9bndRvEdLc+805st1EVDrM4p5AuuZ6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YgAqQB3DA0EyByGP9YVgrex91Vv1pBOVq3yBv9kf3ihj2R+QuJ+S/03tW9msb9yE0
	 3nkVeSDGWYtIXhHBEg/u/weDuLMIxR9JlcHTH9aI5sosh5x10YRm1yJZMj55s07rhj
	 6ZYtCJlJqKdWuMmj9jEGaA4IUh891kXui40NKlQQiTwIW1LkpfWw9OjV8yqDoN/iNR
	 5253k7i+VRhpWInKW0cB3RKwC+RLeaQk2jMBCC7weV4ZqHkptxvkIWkKo5I5Iexp2f
	 6QflkbWXGR6fqIVweSOCse6RHML6ywmfF0SmYAMslL2boJOz292WWSRz6TXzjcDx+L
	 YakSmss3qRzqw==
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
Subject: Re: [RFC PATCH v4 4/4] Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management
Date: Thu, 11 Jun 2026 17:33:55 -0700
Message-ID: <20260612003356.83586-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611150244.3454699-5-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Jun 2026 15:02:44 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Add documentation for the DAMON-based Hugepage Management
> (SAMPLE_DAMON_HUGEPAGE) feature, which automatically manages
> huge pages by identifying hot memory regions and collapsing
> them back to regular pages. The documentation covers the
> module's features, operation, and all available module
> parameters.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  .../admin-guide/mm/damon/hugepage.rst (new)   | 113 ++++++++++++++++++
>  Documentation/admin-guide/mm/damon/index.rst  |   1 +
>  2 files changed, 114 insertions(+)

This again feels like following the non-sample DAMON module's patterns.  I
don't think a dedicated documentation is needed for sample modules.  Could we
drop this?


Thanks,
SJ

[...]
