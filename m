Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C322BF3D7;
	Mon, 25 May 2026 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727871; cv=none; b=hmEn9cp4ohxJkhhqhI8TfnvDMJAYmUq37XXyt7pQkmArogD6+ZD/ehR1e1G3Txel3MT9WT9eBEMs4Jemq+htV4EjxE6utfoQgrtpDMN60ctlwoYmcdcRGc2JMMTy4Wmf7Oeed+vzSNA3K0SYn1+HJh9FtbPr2PyIU2oZJ5hDXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727871; c=relaxed/simple;
	bh=cIjKw8EzEyZkSEdCzqZ1uJhg1YfkvLHhVblyezYlSXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH1z8/H6RoqpUlaw3NR/9JEAQrmrIPlvHEocFXAwxfpb+hTSOrbPyJgaXAzNM98yyq5XvvFX4u3Cr/J+LgW659wYNXf3Ke8/UIuCWbtIJ2ABzZr/KyU3UmfsHB5r4KqIhC4RAX8Asvo9yvyG1hx7i05kanGJ92aRKvXSeUiD50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNvlsXGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNvlsXGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407081F000E9;
	Mon, 25 May 2026 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727869;
	bh=RGRd8m08iAzM3f86tiDF6ZjDlkBX7e5O1+6jLpCVw3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNvlsXGNa81D0EBa1qX7xZDUp+8/Ls6apCzLG273YuQJBT9NwFVlzp44FTRpZ47IO
	 KyGf8GnSHjmxGy9u6qJFjRTbYGsCgC7vV5tdozfMWsEOqZ40mYL83QX4UgHCCtYbrd
	 0YDVRvAANttHskBTchc12Hpl5NCqv9eOy0nXqu2fP+4RkMgP2fffBXcDCfo6AJ0gpB
	 evKwHIABPPPl+k/lj6qMDI3NwkXRXxwzm3MTbCBHKXqGJp01+N9A5baqqiHSjI1DO2
	 8FfVh/gf4vettLoGTDX84TAgX4kOdLv00jVH3PUcqnTvMpd9ZXCzAi+3ETfteItaAm
	 AErM/NjqC3Unw==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
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
Subject: Re: [RFC PATCH v2 2/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Mon, 25 May 2026 09:51:00 -0700
Message-ID: <20260525165100.9016-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <fd55452e-8c4c-4983-a403-bd1ab7ac73f6@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 May 2026 18:04:25 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 5/23/2026 8:27 PM, SeongJae Park wrote:
> > On Fri, 22 May 2026 14:55:16 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a new DAMOS quota goal
> > 
> > I'd suggest to rename it to DAMOS_QUOTA_HUGEPAGE_BP for consistency.
> > 
> > Also, you missed the ending period after 'tuning'.
> > 
> >> metric to measure the amount of huge page consumption to total
> >> anonymous memory consumption ratio.
> > 
> > Why against anonymous memory only?
> Well, that was my first approach. All the projects that I have done
> recently were related to anonymous memory. I'll test it with total
> THP user vs total memory consumption and see if everything works
> in the same way.

Makes sense, looking forward to the test result!

[...]


Thanks,
SJ
