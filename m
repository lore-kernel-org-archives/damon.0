Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B621ABD7;
	Thu, 23 Jul 2026 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766546; cv=none; b=Gf5kcdIOjLM8Qjvq8nYBGsKXqVBBw4vOJypEr4mj8a1wAWl0PVE24sP7N0UXfAl8LE130zJL+jB8fEqyJCQIg8egp+870CwfNmSZAaP6xrU+9lBOaw9IZOkHqh6dslDf1SQRfBtjDXJyrlVBsK6QAt9qJ8cu2+y6WSpsmkcOYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766546; c=relaxed/simple;
	bh=zxESdflNfw+7qoOdnbOKN5uAhZn4yWMzUziYBQqvR3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqugX4yRPF+6b5HOmm/y63gsNpKTv7qIHV52gHE+RmP2o5jBB6T0+OOotXlSKRAL+iPovj25jiHx1Ey/YhY0tyWqaxqt07xrF+sfSWqm+48PSjkJ4ocMcV/QnuJqailN/3fKFlu36rEnVuD3zf05wRmfVnWcwVVwz72jCBsGnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC8q84n8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC8q84n8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D881F000E9;
	Thu, 23 Jul 2026 00:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784766544;
	bh=1klxc6MvqPDoBZg4y3VrtQPMZwyGIj+K0awBUjVudaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZC8q84n8D4cCcVWG3ruQNYAZ7wB4HufMgOv7fxYaxFk+zpOeHFLglfBdflUnHM4Lg
	 WUQvodDRWuxeg7x7gM2TWHfWy7jb8HLLPIfp6L86W4p+4U+O83Fm7kdg1qfkegt6Pt
	 4s4jQWkp2iE7hHlnK8LHyfBXP5q6kdr0VQe8jS28EflHpsfCQF75bnuaYXHN2Bqoj4
	 nB9QlYSyMHVv3bZJwY6TqMha/WvcJEPulzKaEiXawP4xrrVYYhqQGPZ1tStNlk+omX
	 hvsI7OOV2C6sUZwCJ0/1nZM+Q/M28/rEM7uoTsU0i8obhMw18PNZuq3ysxfUns2bic
	 mVAmeLyzSZz0w==
From: SJ Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SJ Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Wed, 22 Jul 2026 17:28:56 -0700
Message-ID: <20260723002857.96284-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1d91aa7f-1601-4cd9-8ef5-8599983bc42f@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Jul 2026 16:51:22 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 7/22/2026 4:45 PM, SJ Park wrote:
[...]
> > We (mm community) now want to focus on making mm.git more stabilized and
> > therefore ready for the next merge window, rather than adding more changes that
> > are not really urgent.  I agree and want to help [1] that.  For the reason,
> > unless Andre pick this first, I will request adding this to mm.git only after
> > next -rc1 release.  Let me know if you think this is really urgent.
> > 
> > [1] https://lore.kernel.org/20260722133829.87607-1-sj@kernel.org
> > 
> > 
> > Thanks,
> > SJ
> > 
> > [...]
> > 
> 
> No problem at all. I am fine with it.

Thank you for confirming, Asier!


Thanks,
SJ

[...]
