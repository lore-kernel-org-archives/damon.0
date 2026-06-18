Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6340D56F;
	Thu, 18 Jun 2026 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781741931; cv=none; b=bVR/iNBRzoz5233dCO7MHSTBMPOZPJhYrzBEUJjozXcvOei+L2+a/7zdENY8kwsOrg3FDbFQEQnlIY97RxnPF0olRby+947MTcuSllPB9V8ShDoluGy9RpLxX09MyD/mKFB9I44D37CIQwhy5BlE4Iok8p5FMIef9lIRlyVmd/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781741931; c=relaxed/simple;
	bh=yqKnjeOp3n9gZYZ/PPYL0Ydalo1gI4vUcE2hgi/NUsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igGqGl6Xvs0rOt+m/9uAu1G+7zEMAoKZgeErcwf7klEzX+hhGWOat1QTYQH10OwKNKzhgBbbF2MmVgcVn5QJWDbWXPQ2baeBCb19ty+4P0Yqubr86LnhAiwnNkb3f3imNjaEYf0Gs7LW1IDRXfQbKTEkYT57ieBChvvhK4PkjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcccTQhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcccTQhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729621F000E9;
	Thu, 18 Jun 2026 00:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781741930;
	bh=Tq5Dd79ingLOtWDO9qXa2YQGMrnxMPixhR12ifZ1um4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcccTQhJVBeAAD+7CELP/GBd9OnSVPTJIyF94/gJgSbsXfLLDEkMQCct0S/zdGYrn
	 DgoOvlKWcQKSTwcDx1VHp0b7TCgxJUoO1dUOhVpc2x0iVuFpzTeBZKlUUOFjmAmYVp
	 pltGjON3/AWa09bqVy8u+cI5sA8+wGvVeqefrCQckaXiHq/nSWGe9qwkqU1vhiJaqR
	 fzR63vcfz8IoJ7MOI1miBQKzmuXWcb807tBOaQPJoxaD0Kt27CeYC9ji5yX4RkDtQb
	 Y+zAIr5vuLMDRmpOtDFjLQVrXAu+AHRWTh5VjbWRT4ZntFx7skj5WOFww+MFMFaLJy
	 v89ZwAZA6FBbA==
From: SeongJae Park <sj@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	gutierrez.asier@huawei-partners.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Wed, 17 Jun 2026 17:18:41 -0700
Message-ID: <20260618001842.84103-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <39bf837e-d3c3-4b9b-b118-063caadcb700@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jun 2026 17:12:45 +0100 Julian Braha <julianbraha@gmail.com> wrote:

> Hi Asier,
> 
> On 6/16/26 16:03, gutierrez.asier@huawei-partners.com wrote:
> 
> > +config SAMPLE_DAMON_HPAGE
> > +	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HPAGE)"
> > +	depends on DAMON && DAMON_VADDR && TRANSPARENT_HUGEPAGE
> The dependency on DAMON is unnecessary because you already depend on
> DAMON_VADDR.

Nice findiing!  There are similar duplicated conditions for other sample
modules, too.  If anyone willing to, please feel free to post patches for
cleaning those out.


Thanks,
SJ

[...]
