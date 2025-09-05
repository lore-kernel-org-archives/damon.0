Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0F2737FD
	for <damon@lists.linux.dev>; Fri,  5 Sep 2025 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102864; cv=none; b=Tz4QJ45Nh9UVESsurwDTJV5HZh4IzXWxbE6XxRxRbtUh8HbscHup7NpQjgUHY2mvPDpZq75seV8EcTKAaj/y8DjDnomsY2DfRMyWikoKn99/0KxnE1Xr3na5xRPmR07WMuJX/ezICgG8XwpH0TcUK4jSQ4ApjAyLhipOnTiwwe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102864; c=relaxed/simple;
	bh=jHN5l/n36eqNvlfVm5AtNHwgRq7ri2ggX+xWjwq+YqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmI2qq5v1BoZXhT6uOrLGFixrEfTbR5+1AcOTjHxZMRF9KTZIp/C1gyRIX4bb8MY/d9VHeA+qLv7WNozRATv/J8zy518RUxOognc961a5wOCXtDv/x/5CFJRRVUrJc34RvpOzsLzP4GuLnyZtw85uled/40mrVHFdvbNKxMxS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6Ldd5rL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6Ldd5rL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1DFC4CEF1;
	Fri,  5 Sep 2025 20:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757102863;
	bh=jHN5l/n36eqNvlfVm5AtNHwgRq7ri2ggX+xWjwq+YqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6Ldd5rLRhqN8jDhl2/VPIV1LhN3qvVB/osCDTLJ2JqdiuHYOaCBFEfxMEfDb+Cf9
	 6MHQdvsrWolrE9cSwbSdtNYhP6tohC5h4w1uh31aKU9eNpe68wTFzuIgNkmLdHrbTL
	 xZoxoXlsjQx4aXYIMPEeDrzpbgeJzX9qeKvq3exw63lFYWdx3lQBZ9TayVbxPmzmrK
	 t5U0RycnaHthPbb4coQhxH1w4xzyR0v7jMzybOowVNDV4tEIRCZoKyDyICbK8Sk9mL
	 W/A4vwQP5iXuBok0WCPppBKX0VD3AqXpsC6HYnGrGKIUjwpxjOcARvESIFBNgY2bsn
	 cTLxqDLaylZww==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com
Subject: Re: [BUG] 'damo stop' causes kernel crash in v6.17-rc3
Date: Fri,  5 Sep 2025 13:07:41 -0700
Message-Id: <20250905200741.23489-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905090827.969-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Sep 2025 18:08:26 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> On Thu,  4 Sep 2025 20:54:11 -0700 SeongJae Park <sj@kernel.org> wrote:
> > On Thu,  4 Sep 2025 17:29:45 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > 
> > > On Wed,  3 Sep 2025 21:02:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > > Hi Yunjeong,
> > > > 
> > > > On Thu,  4 Sep 2025 10:17:38 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > > > 
> > > > > Hi!
> > > > > 
> > > > > I encountered a kernel crash when running 'damo stop' in kernel v6.17-rc3, 
> > > > > I tested and confirmed that this issue also occurs in v6.17-rc1.
[...]
> > Thank you for confirming.  I confirmed attaching patch fixes the problem with
> > your repro on my setup.  Could you please also test that on your machines and
> > confirm if it fixes the issues on your setups, too?  If you confirm, I will
> > post it soon.
> 
> Thank you for the patch. I have confirmed that it fixes the problem on QEMU.

Thank you for confirming.

> I will test it on my physical machine early next week and share the result
> with you.

Looking forward to!


Thanks,
SJ

[...]
