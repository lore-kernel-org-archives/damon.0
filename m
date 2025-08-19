Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80E217733;
	Tue, 19 Aug 2025 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584870; cv=none; b=dQ0NEsU6yKf9AbbpYBEUZdqzu4Tr2B8GNdDQVJXaYRWq0LAcPKdnGGnnHzWn3seHxzzlnHyJgbc+CYtePKmR8xbqMd7qsQUCaZFhDwoBTljV5oatDz6uVMH1lXpNFvWExpsFxgXsMitCcB+kVuKXLqxa6FGMjNbffcz18GmrunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584870; c=relaxed/simple;
	bh=AwJvsFLxwS4iuj+sBbq471Qe7na3TD9I6DWOiSYCPCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAlgQWclIiU99IVIu0RSMwxMm1kF4nY0g/7W70o87RXVRLSHk9TVwQl566ny9cPGc9RdLD7RgU6AlZdxTAVK5lXu5CTvfA1fNUw6se3aFzId/cLMPGT1JjkucazKcrDu8yWHfwqLbHmEPuCMblK/WQONcl+yRQRKlNGMBaJCIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2xVcKYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2xVcKYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEC7C4CEF4;
	Tue, 19 Aug 2025 06:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755584869;
	bh=AwJvsFLxwS4iuj+sBbq471Qe7na3TD9I6DWOiSYCPCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2xVcKYyCz8zH0A41cHA5/5KzkzTWDc0ZeVVESjbJldNtbfYLfmz3vVrsphAclUph
	 HsGPkNLUlnBsetxjioJMFbQYY+/lSM9yjFdjzSdbjpApwnNc3u00PdSZ+LfBz+SchI
	 o0XdMK9OmbIzGvl8fXzlvpthBkxLqsrZh7QF6e16/vB3hwf5kBHiAsIF7mv+NHj+qp
	 DvprCneFcRxkpPHuR2yVtdorvHr3B0tm6f6o0yR2T1GEXXE60rHTVDK/SbLkhfVLKt
	 4/VqoWcphkOLmDnkn2ewCrlsBG+BSjpZAG+jGi1nzNdzeRLD7J5nmGZ8rFNqNcfVLQ
	 WtYUn+JrNHlJA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 06/16] mm/damon/paddr: support addr_unit for DAMOS_STAT
Date: Mon, 18 Aug 2025 23:27:47 -0700
Message-Id: <20250819062747.40259-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819062217.39729-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 23:22:17 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Quanmin,
> 
> On Wed, 13 Aug 2025 13:06:56 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> 
> > From: SeongJae Park <sj@kernel.org>
> > 
> > Add support of addr_unit for DAMOS_STAT action handling from the DAMOS
> > operation implementation for the physical address space.
> 
> As I suggested on another reply[1], please squash attaching patch to this one
> when you post next version of this series.
> 
> [1] https://lore.kernel.org/0001-mm-damon-paddr-set-DAMOS_PAGEOUT-stat-in-core-addres.patch

Sorry for the above wrong link.  Plese use
https://lore.kernel.org/20250813170806.6251-1-sj@kernel.org instead.


Thanks,
SJ

[...]
