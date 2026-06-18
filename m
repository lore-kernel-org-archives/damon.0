Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321E40D56F;
	Thu, 18 Jun 2026 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781741781; cv=none; b=bu1d+e+tBK7I9a4zGXLlfI0dv5ildjZQ70qBxuHb8pQjx2YoSR0vD4OwNHwygjNgpoJm7UPuPl2f1zs34spieO7Jl5KPkTICuYhXoKUob7UdGiio3R8Sa4+p5Yh7Sppzc88r+ji1sQidiEDsoez+PV2GumnQYigb2SB2evVUN9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781741781; c=relaxed/simple;
	bh=QiC1ilcbowaxmYykKMD+sRgAoHlaHOdxfYwImAHW/NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILdaA9p4//hK4zUuaq2guyx/UQQvwJdYMi2ppQs6afdsJeyRYxEgthQzaV9//1h/5gUYaChUifwNCkqjRIKCfEdcUm/0pgVn3Eldif2delruLA7S0rNQQ39Fl7XBPQQliX56OUrKOqE15FtQr275KubL0RDMDmgHsUODZKw9zq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS8O7Ldl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS8O7Ldl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF871F000E9;
	Thu, 18 Jun 2026 00:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781741780;
	bh=l0kWAyRfonITHEKTmFqHGzAP61+hrxv6P9ACVWEGEu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mS8O7LdlB4rRbIWjF+Ru/oL0KgXE2iC8EIhFSLq6zjbxqntdp5RXsI4g0gvvKYN/o
	 DsjWZq11bDZ707uQpDbPLBzivaiBAbZ6S3qpypIF/SOjMTUZKMGMIpeZZTEaHU9ua6
	 BxAvW3IbfurZzKGnoMpu5Ev+iDCPo5EctbJEmyGao4+p2gtvnkpaSXdu2puniKbS6Y
	 c3ws46trieNiNQoAeZlIUhsRRw9rkxOGdBZP/3l7JY3dSInIfnVS5u6K+syPeCadNP
	 7K5BcB+fO/Pox+0S+MdpS/kT03P+vnS7a+tbkRR+T4TWoTR7LETSASUrhNh9RuKBeA
	 FUHR09USFgVtA==
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
Date: Wed, 17 Jun 2026 17:16:08 -0700
Message-ID: <20260618001609.83965-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617040452.98621-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 21:04:52 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 16 Jun 2026 15:03:15 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
> > From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> > 
> > This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
> > which collapses hot regions into huge pages.

As I mentioned on the previous version of this series, this sample module looks
much better than the initial shape to my humble eyes.  Much smaller and
simpler.  I really appreciate Asier's efforts on making this.

However... I was asking myself if this module is really needed last night, and
still got not real good and confident answer.

After all, this is a sample module.  The purpose is to show sample code thhat
helps people understanding how they can use DAMON API.  Maybe we can argue this
module can be helpful at understanding how DAMOS quota goal can be used.  But,
mtier is already showing that.  So I cannot say what new advantage this module
is really bringing.

Meanwhile, this patch adds ~200 lines of code.  It is a very small and simple
sample module, but still we should maintain it.  I, to be honest, getting
little bit concerned about the maintenance overhead now.

So, if Asier has a good reason to add this module that I'm missing, I'd like to
humbly ask to consider dropping of this module for now.  I'm so sorry for
raising this concern this late.  But, Asier, may I ask what do you think?


Thanks,
SJ

[...]
