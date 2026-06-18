Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCC40D56F;
	Thu, 18 Jun 2026 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742008; cv=none; b=obW5Ek1r9BBov7yM+yjrYRBKRoSNsAeVoCT8zf6PBIvWGJGFrDcohAH5RnKQmNwlTgt7ZvLxSrkqSM/CTM8yZn0OMtFstCV8PXeP5fVdkbikeDLkTs/QFAj2TOoRPw1FJjOfT0yIpdDlkQt0aAeUxz1mHV9ijxBwoHNcaoNMWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742008; c=relaxed/simple;
	bh=gWp88fxLOvMu1fJPUGEEv1QJfFO970iimr6ePkrZ4Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r05xAAV5uNfiZjrPUtlB4cQfdJzerzyYCkJBONeThPDJ/8HCD506Rvo2wxAe1+sBxBDOLgsnnMEzbnUf5dl9iALp8QigbFHjVoo0BwQy6LjI53O/KexMchpajpwfLJQaBjogGY12+RZR8UGVOHPwWxfqJeE6Jf8fAYkLI8NfapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYtnYh8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYtnYh8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC111F000E9;
	Thu, 18 Jun 2026 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742007;
	bh=Nm5YTSonfWo5AmxP+6Yk9tTG9YTHgMUcZYxSeB8yQm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZYtnYh8ka5j+1wbYp1kW4Qe0JWAnZYadELtku+/W16/IsaLfRR+iP3uvsbjlDMIFy
	 bq4Zq7W4GgeA3mmGopZvqyfN1FteKfdqQcsPvt2+qkIoENV+1HRoYOaiL/0RDqmR9R
	 GOR8n+UhPej2kxOjgtnJ5lPj2c8E/gleg+WqbUxPyL6dO3Oz1TwebHbB62eFSw9/Fx
	 4DkzHyzgnvUwphCVLJphdf0PjkxpHw6mhVtil1yx6jbgEWTwID/n1vPDjBLZAcmD6m
	 28UdnHXFF7IQi5UvncjIOxnHD8BIKlOyk/ONXrQtNsyGPYs1mbBXEQprtIpbgW+6UP
	 j/3z7z5miYZNA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: gutierrez.asier@huawei-partners.com,
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
Date: Wed, 17 Jun 2026 17:19:50 -0700
Message-ID: <20260618001951.84226-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618001609.83965-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jun 2026 17:16:20 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 16 Jun 2026 21:04:52 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Tue, 16 Jun 2026 15:03:15 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> > > From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> > > 
> > > This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
> > > which collapses hot regions into huge pages.
> 
> As I mentioned on the previous version of this series, this sample module looks
> much better than the initial shape to my humble eyes.  Much smaller and
> simpler.  I really appreciate Asier's efforts on making this.
> 
> However... I was asking myself if this module is really needed last night, and
> still got not real good and confident answer.
> 
> After all, this is a sample module.  The purpose is to show sample code thhat
> helps people understanding how they can use DAMON API.  Maybe we can argue this
> module can be helpful at understanding how DAMOS quota goal can be used.  But,
> mtier is already showing that.  So I cannot say what new advantage this module
> is really bringing.
> 
> Meanwhile, this patch adds ~200 lines of code.  It is a very small and simple
> sample module, but still we should maintain it.  I, to be honest, getting
> little bit concerned about the maintenance overhead now.
> 
> So, if Asier has a good reason to add this module that I'm missing, I'd like to

s/if/unless/

Sorry.

> humbly ask to consider dropping of this module for now.  I'm so sorry for
> raising this concern this late.  But, Asier, may I ask what do you think?
> 
> 
> Thanks,
> SJ
> 
> [...]


Thanks,
SJ
